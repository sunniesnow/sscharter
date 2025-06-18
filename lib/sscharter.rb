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
			include Comparable

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
			@list.sort!
			self
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
		right: %i[r],
		up_right: %i[ur ru],
		up: %i[u],
		up_left: %i[ul lu],
		left: %i[l],
		down_left: %i[dl ld],
		down: %i[d],
		down_right: %i[dr rd]
	}.each_with_object({
		right: 0.0,
		up_right: Math::PI / 4,
		up: Math::PI / 2,
		up_left: Math::PI * 3 / 4,
		left: Math::PI,
		down_left: -Math::PI * 3 / 4,
		down: -Math::PI / 2,
		down_right: -Math::PI / 4
	}) do |(direction_name, aliases), directions|
		aliases.each { directions[_1] = directions[direction_name] }
	end.freeze
	
	DIRECTIONS.freeze

	class << self
		# A hash containing all the charts opened by {::open}.
		# The keys are the names of the charts, and the values are the {Sunniesnow::Charter} objects.
		# @return [Hash<String, Sunniesnow::Charter>]
		attr_reader :charts
	end
	@charts = {}

	# An array of events.
	# @return [Array<Sunniesnow::Charter::Event>]
	attr_reader :events

	# Create a new chart or open an existing chart for editing.
	# The +name+ is used to check whether the chart already exists.
	# If a new chart needs to be created, it is added to {.charts}.
	#
	# The given +block+ will be evaluated in the context of the chart
	# (inside the block, +self+ is the same as the return value, a {Charter} instance).
	# This method is intended to be called at the top level of a Ruby script
	# to open a context for writing a Sunniesnow chart using the DSL.
	#
	# In the examples in the documentation of other methods,
	# it is assumed that they are run inside a block passed to this method.
	#
	# @param name [String] the name of the chart.
	# @return [Sunniesnow::Charter] the chart.
	# @example
	#   Sunniesnow::Charter.open 'master' do
	#     # write the chart here
	#   end
	def self.open name, &block
		result = @charts[name] ||= new name
		result.instance_eval &block if block
		result
	end

	# Create a new chart.
	# Usually you should use {.open} instead of this method.
	# @param name [String] the name of the chart.
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
		@tip_point_start_stack = [nil]
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
			tip_point_start_stack: @tip_point_start_stack.dup,
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
			if @tip_point_start_to_add_stack.last
				@current_tip_point_stack[-1] = @tip_point_peak
				@tip_point_peak += 1
			end
			push_tip_point_start event
			@tip_point_start_to_add_stack[-1] = nil
		when :drop
			@current_tip_point_stack[-1] = @tip_point_peak
			@tip_point_peak += 1
			push_tip_point_start event
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
			@tip_point_start_stack.push nil
			@tip_point_start_to_add_stack.push nil
			@current_tip_point_stack.push nil
		else
			if args.empty? && opts.empty?
				unless @tip_point_start_stack.last
					raise TipPointError, 'cannot omit tip point arguments at top level or inside tip_point_none'
				end
				@tip_point_start_stack.push @tip_point_start_stack.last.dup
			else
				@tip_point_start_stack.push TipPointStart.new *args, **opts
			end
			@tip_point_start_to_add_stack.push @tip_point_start_stack.last
			@current_tip_point_stack.push nil
		end
		result = group preserve_beat: do
			@current_tip_point_group_stack.push @groups.last
			instance_eval &block
		end
		@tip_point_start_stack.pop
		@tip_point_start_to_add_stack.pop
		@tip_point_mode_stack.pop
		@current_tip_point_stack.pop
		@current_tip_point_group_stack.pop
		result
	end

	# @!group DSL methods

	# Set the title of the music for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	# @see Sunniesnow::Chart#title
	# @param title [String] the title of the music.
	# @return [String] the title of the music, the same as the argument +title+.
	# @raise [ArgumentError] if +title+ is not a String.
	def title title
		raise ArgumentError, 'title must be a string' unless title.is_a? String
		@title = title
	end

	# Set the artist of the music for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	# @see Sunniesnow::Chart#artist
	# @param artist [String] the artist of the music.
	# @return [String] the artist of the music, the same as the argument +artist+.
	# @raise [ArgumentError] if +artist+ is not a String.
	def artist artist
		raise ArgumentError, 'artist must be a string' unless artist.is_a? String
		@artist = artist
	end

	# Set the name of the chart author for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	# @see Sunniesnow::Chart#charter
	# @param charter [String] the name of the charter.
	# @return [String] the name of the chart author, the same as the argument +charter+.
	# @raise [ArgumentError] if +charter+ is not a String.
	def charter charter
		raise ArgumentError, 'charter must be a string' unless charter.is_a? String
		@charter = charter
	end

	# Set the name of the difficulty for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	# @see Sunniesnow::Chart#difficulty_name
	# @param difficulty_name [String] the name of the difficulty.
	# @return [String] the name of the difficulty, the same as the argument +difficulty_name+.
	# @raise [ArgumentError] if +difficulty_name+ is not a String.
	def difficulty_name difficulty_name
		raise ArgumentError, 'difficulty_name must be a string' unless difficulty_name.is_a? String
		@difficulty_name = difficulty_name
	end

	# Set the color of the difficulty for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	#
	# The argument +difficulty_color+ can be a color name (a key of {COLORS}),
	# an RGB color in hexadecimal format (e.g. +'#8c68f3'+, +'#8CF'+),
	# an RGB color in decimal format (e.g. +'rgb(140, 104, 243)'+),
	# or an integer representing an RGB color (e.g. +0x8c68f3+).
	# @see Sunniesnow::Chart#difficulty_color
	# @param difficulty_color [Symbol, String, Integer] the color of the difficulty.
	# @return [String] the color of the difficulty in hexadecimal format (e.g. +'#8c68f3'+).
	# @raise [ArgumentError] if +difficulty_color+ is not a valid color format.
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

	# Set the difficulty level for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	#
	# The argument +difficulty+ should be a string representing the difficulty level.
	# Anything other than a string will be converted to a string using +to_s+.
	# @see Sunniesnow::Chart#difficulty
	# @param difficulty [String] the difficulty level.
	# @return [String] the difficulty level (converted to a string).
	def difficulty difficulty
		@difficulty = difficulty.to_s
	end

	# Set the difficulty superscript for the chart.
	# This will be reflected in the return value of {#to_sunniesnow}.
	#
	# The argument +difficulty_sup+ should be a string representing the difficulty superscript.
	# Anything other than a string will be converted to a string using +to_s+.
	# @see Sunniesnow::Chart#difficulty_sup
	# @param difficulty_sup [String] the difficulty superscript.
	# @return [String] the difficulty superscript (converted to a string).
	def difficulty_sup difficulty_sup
		@difficulty_sup = difficulty_sup.to_s
	end

	# Set the offset.
	# This is the time in seconds of the zeroth beat.
	# This method must be called before any other methods that require a beat,
	# or an {OffsetError} will be raised.
	#
	# After calling this method, the current beat (see {#beat} and {#beat!}) is set to zero,
	# and a new BPM needs to be set using {#bpm}.
	# Only after that can the time of any positive beat be calculated.
	#
	# Though not commonly useful, this method can be called multiple times in a chart.
	# A new call of this method does not affect the events and BPM changes set before.
	# Technically, each event is associated with a BPM change list (see {Event#bpm_changes}),
	# and each call of this method creates a new BPM change list,
	# which is used for the events set after.
	# @param offset [Numeric] the offset in seconds.
	# @return [BpmChangeList] the BPM changes.
	# @see BpmChangeList
	# @raise [ArgumentError] if +offset+ is not a number.
	# @example
	#   offset 0.1
	#   p time_at # Outputs 0.1, which is the offset
	#   offset 0.2
	#   p time_at # Outputs 0.2, which is the updated offset by the second call
	def offset offset
		raise ArgumentError, 'offset must be a number' unless offset.is_a? Numeric
		@current_beat = 0r
		@bpm_changes = BpmChangeList.new offset.to_f
	end

	# Set the BPM starting at the current beat.
	# This method must be called after {#offset}.
	# The method can be called multiple times,
	# which is useful when the music changes its tempo from time to time.
	#
	# Internally, this simply calls {BpmChangeList#add} on the BPM changes created by {#offset}.
	# @param bpm [Numeric] the BPM.
	# @raise [OffsetError] if {#offset} has not been called.
	# @return [BpmChangeList] the BPM changes.
	def bpm bpm
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.add @current_beat, bpm
	end

	# Increments the current beat by the given delta set by +delta_beat+.
	# It is recommended that +delta_beat+ be a Rational or an Integer for accuracy.
	# Float will be converted to Rational, and a warning will be issued
	# when a Float is used.
	#
	# This method is also useful for inspecting the current beat.
	# If the method is called without an argument, it simply returns the current beat.
	# For this purpose, this method is equivalent to {#beat!}.
	#
	# This method must be called after {#offset}.
	# @param delta_beat [Rational, Integer] the delta to increment the current beat by.
	# @raise [OffsetError] if {#offset} has not been called.
	# @return [Rational] the new current beat.
	# @see #beat!
	# @example Increment the current beat and inspect it
	#   offset 0.1; bpm 120
	#   p b       # Outputs 0, this is the initial value
	#   p b 1     # Outputs 1, because it is incremented by 1 when it was 0
	#   p b 1/2r  # Outputs 3/2, because it is incremented by 3/2 when it was 1
	#   p time_at # Outputs 0.85, which is offset + 60s / BPM * beat
	# @example Time the notes
	#   offset 0.1; bpm 120
	#   t 0, 0; b 1
	#   t 50, 0; b 1
	#   # Now there are two tap notes, one at beat 0, and the other at beat 1
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

	# Sets the current beat to the given value.
	# It is recommended that +beat+ be a Rational or an Integer for accuracy.
	# Float will be converted to Rational, and a warning will be issued.
	#
	# When called without an argument, this method does nothing and returns the current beat.
	# For this purpose, this method is equivalent to {#beat}.
	#
	# This method must be called after {#offset}.
	# @param beat [Rational, Integer] the new current beat.
	# @raise [OffsetError] if {#offset} has not been called.
	# @return [Rational] the new current beat.
	# @see #beat
	# @example Set the current beat and inspect it
	#   offset 0.1; bpm 120
	#   p b!      # Outputs 0, this is the initial value
	#   p b! 1    # Outputs 1, because it is set to 1
	#   p b! 1/2r # Outputs 1/2, because it is set to 1/2
	#   p time_at # Outputs 0.35, which is offset + 60s / BPM * beat
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

	# Creates a tap note at the given coordinates with the given text.
	# The coordinates +x+ and +y+ must be numbers.
	# The argument +text+ is the text to be displayed on the note
	# (it is converted to a string via +to_s+ if it is not a string).
	#
	# Technically, this adds an event of type +:tap+ to the chart at the current time
	# with properties containing the information provided by +x+, +y+, and +text+.
	# @param x [Numeric] the x-coordinate of the note.
	# @param y [Numeric] the y-coordinate of the note.
	# @param text [String] the text to be displayed on the note.
	# @return [Event] the event representing the tap note.
	# @raise [ArgumentError] if +x+ or +y+ is not a number.
	# @example
	#   offset 0.1; bpm 120
	#   t 0, 0, 'Hello'
	#   t 50, 0, 'world'
	#   # Now there are two simultaneous tap notes at (0, 0) and (50, 0)
	#   # with texts 'Hello' and 'world' respectively
	def tap x, y, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :tap, x: x.to_f, y: y.to_f, text: text.to_s
	end
	alias t tap

	# Creates a hold note at the given coordinates with the given duration and text.
	# The coordinates +x+ and +y+ must be numbers.
	# The argument +duration_beats+ is the duration of the hold note in beats.
	# It needs to be a positive Rational or Integer.
	# If it is a Float, it will be converted to a Rational, and a warning will be issued.
	# The argument +text+ is the text to be displayed on the note
	# (it is converted to a string via +to_s+ if it is not a string).
	#
	# Technically, this adds an event of type +:hold+ to the chart at the current time
	# with properties containing the information provided by +x+, +y+, +duration_beats+, and +text+.
	# @param x [Numeric] the x-coordinate of the note.
	# @param y [Numeric] the y-coordinate of the note.
	# @param duration_beats [Rational, Integer] the duration of the hold note in beats.
	# @param text [String] the text to be displayed on the note.
	# @return [Event] the event representing the hold note.
	# @raise [ArgumentError] if +x+, +y+, or +duration_beats+ is not a number,
	#   or if +duration_beats+ is not positive.
	# @example
	#   offset 0.1; bpm 120
	#   h 0, 0, 1, 'Hello'
	#   h 50, 0, 2, 'world'
	#   # Now there are two hold notes at (0, 0) and (50, 0)
	#   # with durations 1 and 2 beats and texts 'Hello' and 'world' respectively
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

	# Creates a drag note at the given coordinates.
	# The coordinates +x+ and +y+ must be numbers.
	#
	# Technically, this adds an event of type +:drag+ to the chart at the current time
	# with properties containing the information provided by +x+ and +y+.
	# @param x [Numeric] the x-coordinate of the note.
	# @param y [Numeric] the y-coordinate of the note.
	# @return [Event] the event representing the drag note.
	# @raise [ArgumentError] if +x+ or +y+ is not a number.
	# @example
	#   offset 0.1; bpm 120
	#   d 0, 0
	#   d 50, 0
	#   # Now there are two drag notes at (0, 0) and (50, 0)
	def drag x, y
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :drag, x: x.to_f, y: y.to_f
	end
	alias d drag

	# Creates a flick note at the given coordinates with the given direction and text.
	# The coordinates +x+ and +y+ must be numbers.
	# The argument +direction+ is the direction of the flick note in radians or a symbol.
	# If it is a symbol, it should be one of the keys of {DIRECTIONS}
	# (which are +:right+, +:up_right+, etc., abbreviated as +:r+, +:ur+ etc.).
	# If it is a number, it should be a number representing the angle in radians,
	# specifying the angle rorated anticlockwise starting from the positive x-direction.
	# The argument +text+ is the text to be displayed on the note
	# (it is converted to a string via +to_s+ if it is not a string).
	#
	# Technically, this adds an event of type +:flick+ to the chart at the current time
	# with properties containing the information provided by +x+, +y+, +direction+, and +text+.
	# @param x [Numeric] the x-coordinate of the note.
	# @param y [Numeric] the y-coordinate of the note.
	# @param direction [Numeric, Symbol] the direction of the flick note in radians or a symbol.
	# @param text [String] the text to be displayed on the note.
	# @return [Event] the event representing the flick note.
	# @raise [ArgumentError] if +x+ or +y+ is not a number,
	#   if +direction+ is not a symbol or a number,
	#   or if the direction is a symbol that does not represent a known direction.
	# @example
	#   offset 0.1; bpm 120
	#   f 0, 0, :r, 'Hello'
	#   f 50, 0, Math::PI / 4, 'world'
	#   # Now there are two flick notes at (0, 0) and (50, 0)
	#   # with directions right and up right and texts 'Hello' and 'world' respectively
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

	# Creates a background note at the given coordinates with the given duration and text.
	# The coordinates +x+ and +y+ must be numbers.
	# The argument +duration_beats+ is the duration of the background note in beats.
	# It needs to be a non-negative Rational or Integer.
	# If it is a Float, it will be converted to a Rational, and a warning will be issued.
	# The argument +text+ is the text to be displayed on the note
	# (it is converted to a string via +to_s+ if it is not a string).
	#
	# Both the +duration_beats+ and the +text+ arguments are optional.
	# When there are three arguments given in total,
	# the method determines whether the third is +duration_beats+ or +text+ based on its type.
	#
	# Technically, this adds an event of type +:bg_note+ to the chart at the current time
	# with properties containing the information provided by +x+, +y+, +duration_beats+, and +text+.
	# @param x [Numeric] the x-coordinate of the note.
	# @param y [Numeric] the y-coordinate of the note.
	# @param duration_beats [Rational, Integer] the duration of the background note in beats.
	# @param text [String] the text to be displayed on the note.
	# @return [Event] the event representing the background note.
	# @raise [ArgumentError] if +x+, +y+, or +duration_beats+ is not a number,
	#   or if +duration_beats+ is negative.
	# @example
	#   offset 0.1; bpm 120
	#   bg_note 0, 0, 1, 'Hello' # duration is 1, text is 'Hello'
	#   bg_note 50, 0, 'world'   # duration is 0, text is 'world'
	#   bg_note -50, 0, 2        # duration is 2, text is ''
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

	# Creates a big text.
	# The argument +duration_beats+ is the duration of the big text in beats.
	# It needs to be a non-negative Rational or Integer.
	# If it is a Float, it will be converted to a Rational, and a warning will be issued.
	# The argument +text+ is the text to be displayed.
	#
	# Technically, this adds an event of type +:big_text+ to the chart at the current time
	# with properties containing the information provided by +duration_beats+ and +text+.
	# @param duration_beats [Rational, Integer] the duration of the big text in beats.
	# @param text [String] the text to be displayed.
	# @return [Event] the event representing the big text.
	# @raise [ArgumentError] if +duration_beats+ is not a number or is negative.
	# @example
	#   offset 0.1; bpm 120
	#   big_text 1, 'Hello, world!' # duration is 1, text is 'Hello, world!'
	#   b 1
	#   big_text 'Goodbye!'         # duration is 0, text is 'Goodbye!'
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

	# @!macro [attach] bg_pattern
	#   @!method $1(duration_beats = 0)
	#   Creates a $2 background pattern.
	#   The argument +duration_beats+ is the duration of the background pattern in beats.
	#   It needs to be a non-negative Rational or Integer.
	#   If it is a Float, it will be converted to a Rational, and a warning will be issued.
	#
	#   Technically, this adds an event of type +:bg_pattern+ to the chart at the current time
	#   with properties containing the information provided by +duration_beats+.
	#   @param duration_beats [Rational, Integer] the duration of the background pattern in beats.
	#   @return [Event] the event representing the background pattern.
	#   @raise [ArgumentError] if +duration_beats+ is not a number or is negative.
	#   @example
	#     offset 0.1; bpm 120
	#     $1 1 # duration is 1
	#     b 1
	#     $1 0 # duration is 0
	# @!parse bg_pattern :grid, 'grid'
	# @!parse bg_pattern :hexagon, 'hexagon'
	# @!parse bg_pattern :checkerboard, 'checkerboard'
	# @!parse bg_pattern :diamond_grid, 'diamond grid'
	# @!parse bg_pattern :pentagon, 'pentagon'
	# @!parse bg_pattern :turntable, 'turntable'
	# @!parse bg_pattern :hexagram, 'hexagram'
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

	# Duplicate all events in a given array.
	# This method is useful when you want to duplicate a set of events.
	# The argument +events+ is an array of events to be duplicated.
	# The argument +new_tip_points+ is a boolean indicating whether to create new tip points.
	# If it is +true+, new tip points will be created for the duplicated events.
	# If it is +false+, each duplicated event shares the same tip point as the original event.
	# @param events [Array<Event>] the events to be duplicated.
	# @param new_tip_points [Boolean] whether to create new tip points for the duplicated events.
	# @return [Array<Event>] the duplicated events.
	# @example Duplicate a note
	#   offset 0.1; bpm 120
	#   duplicate [t 0, 0]
	# @example Duplicate notes that share tip points with the original notes
	#   offset 0.1; bpm 120
	#   duplicate tp_chain(0, 100, 1) { t 0, 0 }
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

	# Transform all events in a given array in time and/or space.
	# Space transformation does not affect background patterns.
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

	# @!endgroup

end
