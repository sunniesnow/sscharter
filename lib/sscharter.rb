# frozen_string_literal: true

require_relative 'sscharter/version'
require_relative 'sscharter/utils'
require_relative 'sscharter/chart'

class Sunniesnow::Charter

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
		attr_accessor :beat, :offset, :duration_beats
		attr_reader :type, :bpm_changes, :properties

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
			time = time
			properties = @properties.transform_keys &:snake_to_camel
			properties[:duration] = end_time - time if @duration_beats
			Sunniesnow::Event.new time, @type, **properties
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

	def initialize name, &block
		@name = name
		init_chart_info
		init_state
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
		@tip_point_start_to_add = nil
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
		@bpm_changes = []
	end

	def bpm bpm
		raise OffsetError.new __method__ unless @bpm_changes
		@bpm_changes.push BpmChange.new @current_offset, @current_beat, bpm
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
			relative: false, speed: nil, preserve_beat: false,
			&block
		unless block
			raise ArgumentError, 'no block given'
		end
		@tip_point_mode = :chain
		last_beat = @current_beat
		set_tip_point_start_to_add x, y, relative, relative_time, speed
		instance_eval &block
		@tip_point_mode = :none
		@current_tip_point += 1
		beat! last_beat unless preserve_beat
	end
	alias tp_chain tip_point_chain

	def tip_point_drop x = 0, y = 0, relative_time = 0.0,
			relative: true, speed: nil, preserve_beat: false,
			&block
		unless block
			raise ArgumentError, 'no block given'
		end
		@tip_point_mode = :drop
		last_beat = @current_beat
		set_tip_point_start_to_add x, y, relative, relative_time, speed
		instance_eval &block
		@tip_point_mode = :none
		beat! last_beat unless preserve_beat
	end
	alias tp_drop tip_point_drop

	def set_tip_point_start_to_add x, y, relative, relative_time, speed
		if relative_time != 0 && speed
			raise ArgumentError, 'cannot specify both relative_time and speed'
		end
		@tip_point_start_to_add = [x, y, relative, relative_time, speed]
	end

	def event type, duration_beats = nil, **properties
		raise OffsetError.new __method__ unless @bpm_changes
		event = Event.new type, @current_beat, duration_beats, @bpm_changes, **properties
		if @tip_point_start_to_add && properties[:x]
			x, y, relative, relative_time, speed = @tip_point_start_to_add
			tip_point_start = Event.new :placeholder, @current_beat, @bpm_changes, tip_point: @current_tip_point
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
			@events.push tip_point_start
		end
		case @tip_point_mode
		when :chain
			event[:tip_point] = @current_tip_point
			@tip_point_start_to_add = nil
		when :drop
			event[:tip_point] = @current_tip_point
			@current_tip_point += 1
		when :none
			# pass
		end
		@events.push event
		event
	end

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

	def flick x, y, direction
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		if direction.is_a? Symbol
			direction = DIRECTIONS[direction]
		elsif direction.is_a? Numeric
			warn 'Are you using degrees as angle unit instead of radians?' if direction % 45 == 0
			direction = direction.to_f
		else
			raise ArgumentError, 'direction must be a symbol or a number'
		end
		event :flick, x: x, y: y, direction: direction
	end
	alias f flick

	def bg_note x, y, text = ''
		if !x.is_a?(Numeric) || !y.is_a?(Numeric)
			raise ArgumentError, 'x and y must be numbers'
		end
		event :bg_note, x: x.to_f, y: y.to_f, text: text.to_s
	end

end
