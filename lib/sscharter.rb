# frozen_string_literal: true

require_relative 'sscharter/version'
require_relative 'sscharter/utils'
require_relative 'sscharter/chart'

class Sunniesnow::Charter

	PROJECT_DIR = File.expand_path(ENV['SSCHARTER_PROJECT_DIR'] ||= Dir.pwd)

	using Sunniesnow::Utils

	class OffsetError < StandardError
		def initialize method_name
			super "offset must be set before using #{method_name}"
		end
	end

	class TipPointError < StandardError
		def initialize *expected_state, actual_state
			super "wrong tip point state: expected #{expected_state.join ' or '}, got #{actual_state}"
		end

		def self.ensure state, *expected
			raise self.new *expected, state unless expected.include? state
		end

	end

	class BpmChangeList

		class BpmChange
			attr_accessor :beat, :bps

			def initialize beat, bpm
				@beat = beat
				@bps = bpm / 60.0
			end

			def <=> other
				@beat <=> other.beat
			end
		end

		attr_accessor :offset

		def initialize offset
			@offset = offset
			@list = []
		end

		def add beat, bpm
			@list.push BpmChange.new beat, bpm
		end

		def time_at beat
			index = @list.bisect(right: true) { _1.beat <=> beat }
			raise ArgumentError, 'beat is before the first bpm change' if index < 0
			bpm = @list[index]
			(0...index).sum @offset + (beat - bpm.beat) / bpm.bps do |i|
				bpm = @list[i]
				(@list[i+1].beat - bpm.beat) / bpm.bps
			end
		end

		def [] index
			@list[index]
		end
	end

	class Event

		TIP_POINTABLE_TYPES = %i[tap hold flick drag]

		attr_accessor :beat, :offset, :duration_beats, :properties
		attr_reader :type, :bpm_changes, :backtrace

		def initialize type, beat, duration_beats = nil, bpm_changes, **properties
			@beat = beat
			@duration_beats = duration_beats
			@type = type
			@bpm_changes = bpm_changes
			@properties = properties
			@offset = 0.0
			@backtrace = caller.filter { _1.sub! /^#{PROJECT_DIR}\//, '' }
		end

		def time_at_relative_beat delta_beat
			@offset + @bpm_changes.time_at(@beat + delta_beat)
		end

		def time
			time_at_relative_beat 0
		end

		def end_time
			time_at_relative_beat @duration_beats || 0
		end

		def [] key
			@properties[key]
		end

		def []= key, value
			@properties[key] = value
		end

		def to_sunniesnow
			t = time
			properties = @properties.transform_keys &:snake_to_camel
			properties[:duration] = end_time - t if @duration_beats
			Sunniesnow::Event.new t, @type.snake_to_camel, **properties
		end

		def dup
			result = super
			result.properties = @properties.dup
			result
		end

		def tip_pointable?
			TIP_POINTABLE_TYPES.include? @type
		end

		def inspect
			"#<#@type at #@beat#{@duration_beats && " for #@duration_beats"} offset #@offset: " +
			@properties.map { |k, v| "#{k}=#{v.inspect}" }.join(', ') + '>'
		end
	end

	# Implements homography
	class Transform
		include Math
		attr_reader :xx, :xy, :xz, :yx, :yy, :yz, :zx, :zy, :zz, :tt, :t1
		
		def initialize
			@xx = @yy = @zz = 1.0
			@xy = @xz = @yx = @yz = @zx = @zy = 0.0
			@t1 = 0r
			@tt = 1r
		end

		def apply event
			event.beat = @t1 + @tt * event.beat
			return unless x = event[:x]
			return unless y = event[:y]
			rx = xx*x + xy*y + xz
			ry = yx*x + yy*y + yz
			d = zx*x + zy*y + zz
			event[:x] = xp = rx / d
			event[:y] = yp = ry / d
			
			return event unless angle = event[:angle]
			dx = cos angle
			dy = sin angle
			cross = y*dx - x*dy

			cx0 = zy*xx - xy*zx
			cxx = zz*xx - xz*zx
			cxy = zz*xy - xz*zy
			dxp = cx0*cross + cxx*dx + cxy*dy

			cy0 = zx*yy - yx*zy
			cyy = zz*yy - yz*zy
			cyx = zz*yx - yz*zx
			dyp = cy0*-cross + cyy*dy + cyx*dx

			event[:angle] = atan2 dyp, dxp
			event
		end

		def compound_linear xx, xy, yx, yy
			@xx, @xy, @xz, @yx, @yy, @yz = [
				xx * @xx + xy * @yx,
				xx * @xy + xy * @yy,
				xx * @xz + xy * @yz,
				yx * @xx + yy * @yx,
				yx * @xy + yy * @yy,
				yx * @xz + yy * @yz,
			]
		end

		def translate dx, dy
			raise ArgumentError, 'dx and dy must be numbers' unless dx.is_a?(Numeric) && dy.is_a?(Numeric)
			@xz += dx
			@yz += dy
		end

		def horizontal_flip
			compound_linear -1, 0, 0, 1
		end

		def vertical_flip
			compound_linear 1, 0, 0, -1
		end

		def rotate angle
			raise ArgumentError, 'angle must be a number' unless angle.is_a? Numeric
			warn 'Are you using degrees as angle unit instead of radians?' if angle != 0 && angle % 45 == 0
			c = cos angle
			s = sin angle
			compound_linear c, -s, s, c
		end

		def scale sx, sy = sx
			raise ArgumentError, 'sx and sy must be numbers' unless sx.is_a?(Numeric) && sy.is_a?(Numeric)
			compound_linear sx, 0, 0, sy
		end

		def beat_translate delta_beat
			raise ArgumentError, 'delta_beat must be a number' unless delta_beat.is_a? Numeric
			warn 'Rational is recommended over Float for delta_beat' if delta_beat.is_a? Float
			@t1 += delta_beat.to_r
		end
	end

	class TipPointStart

		def initialize x = 0, y = 0, relative_time = 0.0, relative: true, speed: nil,
				relative_beat: nil, beat_speed: nil
			@x = x
			@y = y
			@relative_time = relative_time
			@relative = relative
			@speed = speed
			@relative_beat = relative_beat
			@beat_speed = beat_speed
			check
		end

		def check
			if !@x.is_a?(Numeric) || !@y.is_a?(Numeric)
				raise ArgumentError, 'x and y must be numbers'
			end
			@x = @x.to_f
			@y = @y.to_f
			%i[@relative_time @speed @relative_beat @beat_speed].each do |key|
				value = instance_variable_get key
				raise ArgumentError, "cannot specify both #@time_key and #{key}" if @time_key && value&.!=(0)
				@time_key = key if value&.!=(0)
			end
			@time_key ||= :@relative_time
		end

		def get_start_placeholder start_event
			raise ArgumentError, "start_event is not tip-pointable" unless start_event.tip_pointable?
			result = Event.new :placeholder, start_event.beat, start_event.bpm_changes
			if @relative
				result[:x] = start_event[:x] + @x
				result[:y] = start_event[:y] + @y
			else
				result[:x] = @x
				result[:y] = @y
			end
			case @time_key
			when :@relative_time
				raise ArgumentError, "relative_time must be a number" unless @relative_time.is_a? Numeric
				raise ArgumentError, "relative_time must be non-negative" if @relative_time < 0
				result.offset = -@relative_time.to_f
			when :@speed
				raise ArgumentError, "speed must be a number" unless @speed.is_a? Numeric
				raise ArgumentError, "speed must be positive" if @speed <= 0
				result.offset = -Math.hypot(result[:x] - start_event[:x], result[:y] - start_event[:y]) / @speed
			when :@relative_beat
				raise ArgumentError, "relative_beat must be a number" unless @relative_beat.is_a? Numeric
				raise ArgumentError, "relative_beat must be non-negative" if @relative_beat < 0
				warn "Rational is recommended over Float for relative_beat" if @relative_beat.is_a? Float
				result.beat -= @relative_beat.to_r
			when :@beat_speed
				raise ArgumentError, "beat_speed must be a number" unless @beat_speed.is_a? Numeric
				raise ArgumentError, "beat_speed must be positive" if @beat_speed <= 0
				delta_beat = Math.hypot(result[:x] - start_event[:x], result[:y] - start_event[:y]) / @beat_speed
				result.beat -= delta_beat.to_r # a little weird, but fine
			end
			result[:tip_point] = start_event[:tip_point]
			result
		end
	end

	COLORS = {
		easy: '#3eb9fd',
		normal: '#f19e56',
		hard: '#e75e74',
		master: '#8c68f3',
		special: '#f156ee'
	}.freeze

	DIRECTIONS = {
		right: 0.0,
		up_right: Math::PI / 4,
		up: Math::PI / 2,
		up_left: Math::PI * 3 / 4,
		left: Math::PI,
		down_left: -Math::PI * 3 / 4,
		down: -Math::PI / 2,
		down_right: -Math::PI / 4
	}
	{
		right: %i[r],
		up_right: %i[ur ru],
		up: %i[u],
		up_left: %i[ul lu],
		left: %i[l],
		down_left: %i[dl ld],
		down: %i[d],
		down_right: %i[dr rd]
	}.each do |direction_name, aliases|
		aliases.each { DIRECTIONS[_1] = DIRECTIONS[direction_name] }
	end
	DIRECTIONS.freeze

	singleton_class.attr_reader :charts
	@charts = {}

	attr_reader :events

	def self.open name, &block
		result = @charts[name] ||= new name
		result.instance_eval &block if block
		result
	end

	def initialize name
		@name = name
		init_chart_info
		init_state
		init_bookmarks
	end

	def init_chart_info
		@difficulty_name = ''
		@difficulty_color = '#000000'
		@difficulty = ''
		@difficulty_sup = ''
		@title = ''
		@artist = ''
		@charter = ''
		@events = []
	end

	def init_bookmarks
		@bookmarks = {}
	end

	def init_state
		@current_beat = nil
		@bpm_changes = nil
		@tip_point_mode_stack = [:none]
		@current_tip_point_stack = []
		@current_tip_point_group_stack = []
		@tip_point_peak = 0
		@current_duplicate = 0
		@tip_point_start_to_add_stack = [nil]
		@groups = [@events]
	end

	def to_sunniesnow **opts
		result = Sunniesnow::Chart.new **opts
		result.title = @title
		result.artist = @artist
		result.charter = @charter
		result.difficulty_name = @difficulty_name
		result.difficulty_color = @difficulty_color
		result.difficulty = @difficulty
		result.difficulty_sup = @difficulty_sup
		@events.each { result.events.push _1.to_sunniesnow }
		result
	end

	def output_json **opts
		to_sunniesnow(**opts).to_json
	end

	def inspect
		"#<Sunniesnow::Charter #@name>"
	end

	def time_at beat = @current_beat
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.time_at beat
	end

	def backup_beat
		{current_beat: @current_beat, bpm_changes: @bpm_changes}
	end

	def restore_beat backup
		@current_beat = backup[:current_beat]
		@bpm_changes = backup[:bpm_changes]
	end

	def backup_state
		{
			current_beat: @current_beat,
			bpm_changes: @bpm_changes,
			tip_point_mode_stack: @tip_point_mode_stack.dup,
			current_tip_point_stack: @current_tip_point_stack.dup,
			current_tip_point_group_stack: @current_tip_point_group_stack.dup,
			current_duplicate: @current_duplicate,
			tip_point_start_to_add_stack: @tip_point_start_to_add_stack.dup,
			groups: @groups.dup
		}
	end

	def restore_state backup
		@current_beat = backup[:current_beat]
		@bpm_changes = backup[:bpm_changes]
		@tip_point_mode_stack = backup[:tip_point_mode_stack]
		@current_tip_point_stack = backup[:current_tip_point_stack]
		@current_tip_point_group_stack = backup[:current_tip_point_group_stack]
		@current_duplicate = backup[:current_duplicate]
		@tip_point_start_to_add_stack = backup[:tip_point_start_to_add_stack]
		@groups = backup[:groups]
		nil
	end

	def event type, duration_beats = nil, **properties
		raise OffsetError.new __method__ unless @bpm_changes
		event = Event.new type, @current_beat, duration_beats, @bpm_changes, **properties
		@groups.each { _1.push event }
		return event unless event.tip_pointable?
		case @tip_point_mode_stack.last
		when :chain
			push_tip_point_start event
			@tip_point_start_to_add_stack[-1] = nil
		when :drop
			push_tip_point_start event
			@current_tip_point_stack[-1] = @tip_point_peak
			@tip_point_peak += 1
		when :none
			# pass
		end
		event
	end

	def push_tip_point_start start_event
		start_event[:tip_point] = @current_tip_point_stack.last.to_s
		tip_point_start = @tip_point_start_to_add_stack.last&.get_start_placeholder start_event
		return unless tip_point_start
		@groups.each do |group|
			group.push tip_point_start
			break if group.equal?(@current_tip_point_group_stack.last) && @tip_point_mode_stack.last != :drop
		end
	end

	def tip_point mode, *args, preserve_beat: true, **opts, &block
		@tip_point_mode_stack.push mode
		if mode == :none
			@tip_point_start_to_add_stack.push nil
			@current_tip_point_stack.push nil
		else
			@tip_point_start_to_add_stack.push TipPointStart.new *args, **opts
			@current_tip_point_stack.push @tip_point_peak
			@tip_point_peak += 1
		end
		result = group preserve_beat: do
			@current_tip_point_group_stack.push @groups.last
			instance_eval &block
		end
		@tip_point_start_to_add_stack.pop
		@tip_point_mode_stack.pop
		@current_tip_point_stack.pop
		@current_tip_point_group_stack.pop
		result
	end

	# Below are methods intended to be used in the DSL

	def title title
		raise ArgumentError, 'title must be a string' unless title.is_a? String
		@title = title
	end

	def artist artist
		raise ArgumentError, 'artist must be a string' unless artist.is_a? String
		@artist = artist
	end

	def charter charter
		raise ArgumentError, 'charter must be a string' unless charter.is_a? String
		@charter = charter
	end

	def difficulty_name difficulty_name
		raise ArgumentError, 'difficulty_name must be a string' unless difficulty_name.is_a? String
		@difficulty_name = difficulty_name
	end

	def difficulty_color difficulty_color
		@difficulty_color = case difficulty_color
		when Symbol
			COLORS[difficulty_color]
		when /^#[0-9a-fA-F]{6}$/
			difficulty_color
		when /^#[0-9a-fA-F]{3}$/
			_, r, g, b = difficulty_color.chars
			"##{r}#{r}#{g}#{g}#{b}#{b}"
		when /^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/
			r, g, b = $1, $2, $3
			sprintf '#%02x%02x%02x', r.to_i, g.to_i, b.to_i
		when Integer
			sprintf '#%06x', difficulty_color % 0x1000000
		else
			raise ArgumentError, 'unknown format of difficulty_color'
		end
	end

	def difficulty difficulty
		@difficulty = difficulty.to_s
	end

	def difficulty_sup difficulty_sup
		@difficulty_sup = difficulty_sup.to_s
	end

	def offset offset
		raise ArgumentError, 'offset must be a number' unless offset.is_a? Numeric
		@current_beat = 0r
		@bpm_changes = BpmChangeList.new offset.to_f
	end

	def bpm bpm
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.add @current_beat, bpm
	end

	def beat delta_beat = 0
		raise OffsetError.new __method__ unless @current_beat
		case delta_beat
		when Integer, Rational
			@current_beat += delta_beat.to_r
		when Float
			warn 'float beat is not recommended'
			@current_beat += delta_beat.to_r
		else
			raise ArgumentError, 'invalid delta_beat'
		end
	end
	alias b beat

	def beat! beat = @current_beat
		raise OffsetError.new __method__ unless @current_beat
		case beat
		when Integer, Rational
			@current_beat = beat.to_r
		when Float
			warn 'float beat is not recommended'
			@current_beat = beat.to_r
		else
			raise ArgumentError, 'invalid beat'
		end
	end
	alias b! beat!

	def tap x, y, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :tap, x: x.to_f, y: y.to_f, text: text.to_s
	end
	alias t tap

	def hold x, y, duration_beats, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric) || !duration_beats.is_a?(Numeric)
			raise ArgumentError, 'x, y, and duration must be numbers'
		end
		if duration_beats <= 0
			raise ArgumentError, 'duration must be positive'
		end
		if duration_beats.is_a? Float
			warn 'Rational is recommended over Float for duration_beats'
		end
		event :hold, duration_beats.to_r, x: x.to_f, y: y.to_f, text: text.to_s
	end
	alias h hold

	def drag x, y
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :drag, x: x.to_f, y: y.to_f
	end
	alias d drag

	def flick x, y, direction, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		if direction.is_a? Symbol
			direction = DIRECTIONS[direction]
			raise ArgumentError, "unknown direction #{direction}" unless direction
		elsif direction.is_a? Numeric
			warn 'Are you using degrees as angle unit instead of radians?' if direction != 0 && direction % 45 == 0
			direction = direction.to_f
		else
			raise ArgumentError, 'direction must be a symbol or a number'
		end
		event :flick, x: x.to_f, y: y.to_f, angle: direction, text: text.to_s
	end
	alias f flick

	def bg_note x, y, duration_beats = 0, text = nil
		if text.nil?
			if duration_beats.is_a? String
				text = duration_beats
				duration_beats = 0
			else
				text = ''
			end
		end
		if !x.is_a?(Numeric) || !y.is_a?(Numeric) || !duration_beats.is_a?(Numeric)
			raise ArgumentError, 'x, y, and duration_beats must be numbers'
		end
		if duration_beats < 0
			raise ArgumentError, 'duration must be non-negative'
		end
		if duration_beats.is_a? Float
			warn 'Rational is recommended over Float for duration_beats'
		end
		event :bg_note, duration_beats.to_r, x: x.to_f, y: y.to_f, text: text.to_s
	end

	def big_text duration_beats = 0, text
		unless duration_beats.is_a? Numeric
			raise ArgumentError, 'duration_beats must be a number'
		end
		if duration_beats < 0
			raise ArgumentError, 'duration must be non-negative'
		end
		if duration_beats.is_a? Float
			warn 'Rational is recommended over Float for duration_beats'
		end
		event :big_text, duration_beats.to_r, text: text.to_s
	end

	%i[grid hexagon checkerboard diamond_grid pentagon turntable hexagram].each do |method_name|
		define_method method_name do |duration_beats = 0|
			unless duration_beats.is_a? Numeric
				raise ArgumentError, 'duration_beats must be a number'
			end
			if duration_beats < 0
				raise ArgumentError, 'duration must be non-negative'
			end
			if duration_beats.is_a? Float
				warn 'Rational is recommended over Float for duration_beats'
			end
			event method_name, duration_beats.to_r
		end
	end

	def duplicate events, new_tip_points: true
		result = []
		events.each do |event|
			next if event.type == :placeholder && !new_tip_points
			result.push event = event.dup
			if event[:tip_point] && new_tip_points
				event[:tip_point] = "#@current_duplicate #{event[:tip_point]}"
			end
			@groups.each { _1.push event }
		end
		@current_duplicate += 1 if new_tip_points
		result
	end

	def transform events, &block
		raise ArgumentError, 'no block given' unless block
		events = [events] if events.is_a? Event
		transform = Transform.new
		transform.instance_eval &block
		events.each { transform.apply _1 }
	end

	def group preserve_beat: true, &block
		raise ArgumentError, 'no block given' unless block
		@groups.push result = []
		beat_backup = backup_beat unless preserve_beat
		instance_eval &block
		restore_beat beat_backup unless preserve_beat
		@groups.delete_if { result.equal? _1 }
		result
	end

	def remove *events
		events.each { |event| @groups.each { _1.delete event } }
	end

	%i[chain drop none].each do |mode|
		define_method "tip_point_#{mode}" do |*args, **opts, &block|
			tip_point mode, *args, **opts, &block
		end
		alias_method "tp_#{mode}", "tip_point_#{mode}"
	end

	def mark name
		@bookmarks[name] = backup_state
		name
	end

	def at name, preserve_beat: false, update_mark: false, &block
		raise ArgumentError, 'no block given' unless block
		raise ArgumentError, "unknown bookmark #{name}" unless bookmark = @bookmarks[name]
		backup = backup_state
		restore_state bookmark
		result = group &block
		mark name if update_mark
		beat_backup = backup_beat if preserve_beat
		restore_state backup
		restore_beat beat_backup if preserve_beat
		result
	end

	def check(
		notes_in_bound: true,
		bg_notes_in_bound: true
	)
		out_of_bound_events = [] if notes_in_bound || bg_notes_in_bound
		@events.each do |event|
			if %i[tap hold drag flick].include?(event.type) && notes_in_bound || event.type == :bg_note && bg_notes_in_bound
				if event[:x] < -100-1e-10 || event[:x] > 100+1e-10 || event[:y] < -50-1e-10 || event[:y] > 50+1e-10
					out_of_bound_events.push event
				end
			end
		end
		if notes_in_bound || bg_notes_in_bound
			if out_of_bound_events.empty?
				puts "===== All notes are in bound ====="
			else
				puts "===== Out-of-bound notes ====="
				out_of_bound_events.each do |event|
					p event
					puts "at time #{event.time}"
					puts 'defined at:'
					puts event.backtrace
				end
			end
		end
	end

end
