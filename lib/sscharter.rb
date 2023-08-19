# frozen_string_literal: true

require_relative 'sscharter/version'
require_relative 'sscharter/utils'
require_relative 'sscharter/chart'

class Sunniesnow::Charter

	using Sunniesnow::Utils

	class OffsetError < StandardError
		def initialize method_name
			super "offset must be set before using #{method_name}"
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
			if index < 0
				raise ArgumentError, 'beat is before the first bpm change'
			end
			bpm = @list[index]
			@offset + (beat - bpm.beat) / bpm.bps
		end

		def [] index
			@list[index]
		end
	end

	class Event
		attr_accessor :beat, :offset, :duration_beats, :properties
		attr_reader :type, :bpm_changes

		def initialize type, beat, duration_beats = nil, bpm_changes, **properties
			@beat = beat
			@duration_beats = duration_beats
			@type = type
			@bpm_changes = bpm_changes
			@properties = properties
			@offset = 0.0
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
	end

	# Implements homography
	class Transform
		include Math
		attr_reader :xx, :xy, :xz, :yx, :yy, :yz, :zx, :zy, :zz
		
		def initialize
			@xx = @yy = @zz = 1.0
			@xy = @xz = @yx = @yz = @zx = @zy = 0.0
		end

		def apply event
			return unless x = event[:x]
			return unless y = event[:y]
			rx = xx*x + xy*y + xz
			ry = yx*x + yy*y + yz
			d = zx*x + zy*y + zz
			event[:x] = rx / d
			event[:y] = ry / d
			if angle = event[:angle]
				dx, dy = cos(angle), sin(angle)
				event[:angle] = atan2(yx*dx + yy*dy, xx*dx + xy*dy)
			end
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
			c = cos angle
			s = sin angle
			compound_linear c, -s, s, c
		end

		def scale sx, sy = sx
			compound_linear sx, 0, 0, sy
		end
	end

	COLORS = {
		easy: '#3eb9fd',
		normal: '#f19e56',
		hard: '#e75e74',
		master: '#8c68f3',
		special: '#f156ee'
	}

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

	singleton_class.attr_reader :charts
	@charts = {}

	def initialize name, &block
		@name = name
		init_chart_info
		init_state
		self.class.charts[name] = self
		instance_eval &block if block
	end

	def init_chart_info
		@difficulty_name = ''
		@difficulty_color = '#000000'
		@difficulty = ''
		@title = ''
		@artist = ''
		@charter = ''
		@events = []
	end

	def init_state
		@current_offset = nil
		@current_beat = nil
		@bpm_changes = nil
		@tip_point_mode = :none
		@current_tip_point = 0
		@current_duplicate = 0
		@tip_point_start_to_add = nil
		@groups = [@events]
	end

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
			"##{r.to_i.to_s 16}#{g.to_i.to_s 16}#{b.to_i.to_s 16}"
		when Integer
			sprintf '#%06x', difficulty_color % 0x1000000
		else
			raise ArgumentError, 'unknown format of difficulty_color'
		end
	end

	def difficulty difficulty
		@difficulty = difficulty.to_s
	end

	def offset offset
		raise ArgumentError, 'offset must be a number' unless offset.is_a? Numeric
		@current_offset = offset.to_f
		@current_beat = 0r
		@bpm_changes = BpmChangeList.new @current_offset
	end

	def bpm bpm
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.add @current_beat, bpm
	end

	def beat delta_beat
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

	def beat! beat
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

	def time_at beat
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.time_at beat
	end

	def tip_point_chain x = 0, y = 0, relative_time = 0.0,
			relative: false, speed: nil, preserve_beat: true,
			&block
		raise ArgumentError, 'no block given' unless block
		@tip_point_mode = :chain
		set_tip_point_start_to_add x, y, relative, relative_time, speed
		result = group preserve_beat: preserve_beat, &block
		clear_tip_point
		@current_tip_point += 1
		result
	end
	alias tp_chain tip_point_chain

	def tip_point_drop x = 0, y = 0, relative_time = 0.0,
			relative: true, speed: nil, preserve_beat: true,
			&block
		raise ArgumentError, 'no block given' unless block
		@tip_point_mode = :drop
		set_tip_point_start_to_add x, y, relative, relative_time, speed
		result = group preserve_beat: preserve_beat, &block
		clear_tip_point
		result
	end
	alias tp_drop tip_point_drop

	def group preserve_beat: true, &block
		raise ArgumentError, 'no block given' unless block
		@groups.push result = []
		last_beat = @current_beat
		instance_eval &block
		beat! last_beat unless preserve_beat
		@groups.delete_if { result.equal? _1 }
		result
	end

	def set_tip_point_start_to_add x, y, relative, relative_time, speed
		raise ArgumentError, 'cannot specify both relative_time and speed' if relative_time != 0 && speed
		@tip_point_start_to_add = [x, y, relative, relative_time, speed]
	end

	def clear_tip_point
		@tip_point_start_to_add = nil
		@tip_point_mode = :none
	end

	def event type, duration_beats = nil, has_tip_point: false, **properties
		raise OffsetError.new __method__ unless @bpm_changes
		event = Event.new type, @current_beat, duration_beats, @bpm_changes, **properties
		@groups.each { _1.push event }
		return event unless has_tip_point
		if @tip_point_start_to_add && properties[:x]
			x, y, relative, relative_time, speed = @tip_point_start_to_add
			tip_point_start = Event.new :placeholder, @current_beat, @bpm_changes, tip_point: @current_tip_point.to_s
			if relative
				tip_point_start[:x] = properties[:x] + x
				tip_point_start[:y] = properties[:y] + y
			else
				tip_point_start[:x] = x
				tip_point_start[:y] = y
			end
			if speed
				tip_point_start.offset = -Math.hypot(tip_point_start[:x] - properties[:x], tip_point_start[:y] - properties[:y]) / speed
			else
				tip_point_start.offset = -relative_time
			end
			@groups.each { _1.push tip_point_start }
		end
		case @tip_point_mode
		when :chain
			event[:tip_point] = @current_tip_point.to_s
			@tip_point_start_to_add = nil
		when :drop
			event[:tip_point] = @current_tip_point.to_s
			@current_tip_point += 1
		when :none
			# pass
		end
		event
	end

	def transform events, &block
		raise ArgumentError, 'no block given' unless block
		transform = Transform.new
		transform.instance_eval &block
		events.each { transform.apply _1 }
	end

	def duplicate events
		result = []
		events.each do |event|
			result.push event = event.dup
			if event[:tip_point]
				event[:tip_point] = "#@current_duplicate #{event[:tip_point]}"
			end
			@groups.each { _1.push event }
		end
		result
	end

	def tap x, y, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :tap, x: x.to_f, y: y.to_f, has_tip_point: true, text: text.to_s
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
		event :hold, duration_beats.to_r, has_tip_point: true, x: x.to_f, y: y.to_f, text: text.to_s
	end
	alias h hold

	def drag x, y
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :drag, has_tip_point: true, x: x.to_f, y: y.to_f
	end
	alias d drag

	def flick x, y, direction
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		if direction.is_a? Symbol
			direction = DIRECTIONS[direction]
		elsif direction.is_a? Numeric
			warn 'Are you using degrees as angle unit instead of radians?' if direction != 0 && direction % 45 == 0
			direction = direction.to_f
		else
			raise ArgumentError, 'direction must be a symbol or a number'
		end
		event :flick, has_tip_point: true, x: x, y: y, angle: direction
	end
	alias f flick

	def bg_note x, y, duration_beats = 0, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :bg_note, duration_beats.to_r, x: x.to_f, y: y.to_f, text: text.to_s
	end

	def big_text duration_beats = 0, text
		event :big_text, duration_beats.to_r, text: text.to_s
	end

	%i[grid hexagon checkerboard diamond_grid pentagon turntable].each do |method_name|
		define_method method_name do |duration_beats = 0|
			event method_name, duration_beats.to_r
		end
	end

	def to_sunniesnow
		result = Sunniesnow::Chart.new
		result.title = @title
		result.artist = @artist
		result.charter = @charter
		result.difficulty_name = @difficulty_name
		result.difficulty_color = @difficulty_color
		result.difficulty = @difficulty
		@events.each { result.events.push _1.to_sunniesnow }
		result
	end

	def output_json
		to_sunniesnow.to_json
	end

end
