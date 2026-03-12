# frozen_string_literal: true

class Sunniesnow::Charter

	using Sunniesnow::Utils

	class Event
		include Metronomic

		# The types ({#type}) of events that
		# should be considered possibly visited by a tip point from the charting perspective.
		# They affect {#tip_pointable?} and suggests whether this event should be visited by a tip point
		# if it is created inside blocks in {Charter#tip_point_chain} and {Charter#tip_point_drop}.
		# For this reason, although placeholder events can be visited by a tip point from a technical perspective,
		# it is not included in this list.
		TIP_POINTABLE_TYPES = %i[tap hold flick drag drag_flick].freeze

		TIP_POINTABLE_TYPES_SET = TIP_POINTABLE_TYPES.to_set.freeze

		# @return [Symbol]
		attr_accessor :type

		# @return [Hash{Symbol => Numeric, String}]
		attr_accessor :properties

		# @return [TimeDependent]
		attr_accessor :time_dependent

		# @return [Array<String>]
		attr_reader :backtrace

		# @param type [Symbol]
		# @param beat [Rational]
		# @param duration_beats [Rational?]
		# @param bpm_changes [BpmChangeList]
		# @param properties [Hash{Symbol => Numeric, String}]
		def initialize type, beat, duration_beats = nil, bpm_changes, **properties
			@beat = beat
			@duration_beats = duration_beats
			@type = type
			@bpm_changes = bpm_changes
			@properties = properties
			@time_dependent = TimeDependent.new beat, bpm_changes
			@offset = 0.0
			@backtrace = caller.filter { _1.sub! /^#{PROJECT_DIR}\//, '' }
		end

		# @return [Numeric, String]
		# @param key [Symbol]
		def [] key
			@properties[key]
		end

		# @return [Numeric, String]
		# @param key [Symbol]
		# @param value [Numeric, String]
		def []= key, value
			@properties[key] = value
		end

		# @return [Sunniesnow::Event]
		def to_sunniesnow
			t = time
			properties = @properties.transform_keys &:snake_to_camel
			properties[:duration] = end_time - t if @duration_beats
			result = Sunniesnow::Event.new t, @type.snake_to_camel, **properties
			result.time_dependent = @time_dependent.to_sunniesnow unless @time_dependent.empty?
			result
		end

		# @return [Event]
		# TODO: use +initialize_copy+.
		def dup
			result = super
			result.properties = @properties.dup
			result.time_dependent = @time_dependent.dup
			result
		end

		# Suggests whether this event should be visited by a tip point
		# if it is created inside blocks in {Charter#tip_point_chain} and {Charter#tip_point_drop}.
		# @return [Boolean]
		def tip_pointable?
			TIP_POINTABLE_TYPES_SET.include? @type
		end

		# @return [String]
		def inspect
			"#<#@type at #@beat#{@duration_beats && " for #@duration_beats"} offset #@offset: " +
			@properties.map { |k, v| "#{k}=#{v.inspect}" }.join(', ') + '>'
		end
	end

	class TimeDependent
		class DataPoint
			include Metronomic

			# @return [Float, String]
			attr_accessor :value

			# @param beat [Rational]
			# @param bpm_changes [BpmChangeList]
			# @param value [Float, String]
			def initialize beat, bpm_changes, value
				@offset = 0.0
				@beat = beat
				@bpm_changes = bpm_changes
				@value = value
			end

			# @return [Hash]
			def to_sunniesnow
				{time: time, value: @value}
			end
		end

		class PiecewiseData
			include Metronomic

			# @return [Array<DataPoint>]
			attr_accessor :data_points

			# @param beat [Rational]
			# @param bpm_changes [BpmChangeList]
			def initialize beat, bpm_changes
				@offset = 0.0
				@beat = beat
				@bpm_changes = bpm_changes
			end

			# @param beat [Rational]
			# @param value [Float, String]
			# @return [DataPoint]
			def data_point beat, value
				DataPoint.new(beat, @bpm_changes, value).tap { (@data_points ||= []).push _1 }
			end

			# @return [Boolean]
			def interpolable?
				raise NotImplementedError
			end

			# @return [PiecewiseData]
			# TODO: use +initialize_copy+.
			def dup
				super.tap { _1.data_points = @data_points&.map &:dup }
			end

			# @return [Hash]
			def to_sunniesnow
				return {} unless @data_points
				data_points = @data_points.map &:to_sunniesnow
				data_points.sort_by! { _1[:time] }
				data_points.each { _1[:time] += @offset }
				{dataPoints: data_points}
			end
		end

		# Represents a piecewise linear function defined by some data points.
		class InterpolablePiecewiseData < PiecewiseData

			# @return [Float]
			attr_accessor :speed

			# @return [Float]
			attr_accessor :beat_speed

			# @param value [Float]
			def speed= value
				@speed = value
				@beat_speed = nil
			end

			# @param value [Float]
			def beat_speed= value
				@beat_speed = value
				@speed = nil
			end

			# @return [true]
			def interpolable?
				true
			end

			# @return [Hash]
			def to_sunniesnow
				speed = @speed || @beat_speed && @bpm_changes.bps_before(@data_points&.min_by(&:beat)&.beat || @beat) * @beat_speed
				super.tap { _1[:speed] = speed if speed }
			end
		end

		# Represents a piecewise constant function defined by some data points.
		class UninterpolablePiecewiseData < PiecewiseData
			# @return [Integer, Float, String]
			attr_accessor :value

			# @return [false]
			def interpolable?
				false
			end

			# @return [Hash]
			def to_sunniesnow
				super.tap { _1[:value] = @value if @value }
			end
		end

		include BeatSeries

		# @return [Hash{INTERPOLABLE_SET, UNINTERPOLABLE_SET => PiecewiseData}]
		attr_accessor :data

		# @param beat [Rational]
		# @param bpm_changes [BpmChangeList]
		def initialize beat, bpm_changes
			@current_beat = beat
			@bpm_changes = bpm_changes
			@data = Hash.new { |h, k| h[k] = (INTERPOLABLE_SET.include?(k) ? InterpolablePiecewiseData : UninterpolablePiecewiseData).new beat, bpm_changes }
		end

		# @param key [Symbol]
		# @return [PiecewiseData?]
		def [] key
			@data.has_key?(key) ? @data[key] : nil
		end

		INTERPOLABLE = %i[
			x y opacity size scale_x scale_y skew_x skew_y rotation text tint_red tint_green tint_blue
			circle_opacity circle_scale_x circle_scale_y circle_skew_x circle_skew_y circle_rotation
			circle_tint_red circle_tint_green circle_tint_blue
			width height anchor_x anchor_y
		].freeze

		INTERPOLABLE_SET = INTERPOLABLE.to_set.freeze

		UNINTERPOLABLE = %i[z blend_mode circle_blend_mode text].freeze

		UNINTERPOLABLE_SET = UNINTERPOLABLE.to_set.freeze

		BLEND_MODES = %i[
			normal add multiply screen darken lighten erase color_dodge color_burn linear_burn linear_dodge
			linear_light hard_light soft_light pin_light difference exclusion overlay saturation color luminosity
			normal_npm add_npm screen_npm none subtract divide vivid_light hard_mix negation min max
		].freeze

		BLEND_MODES_SET = BLEND_MODES.to_set

		UNINTERPOLABLE_TYPES = {
			blend_mode: BLEND_MODES_SET,
			circle_blend_mode: BLEND_MODES_SET,
			test: String
		}.tap { _1.default = Numeric }.freeze

		# @!group DSL Methods

		# @!parse
		#   # @!macro [attach] interpolable_property
		#   #   @!method $1 data_value = nil, speed: nil, s: nil
		#   #   @return [DataPoint, Float]
		#   #   @overload $1 data_value
		#   #     @param data_value [Numeric]
		#   #     @return [DataPoint]
		#   #   @overload $1 speed:
		#   #     @param speed [Numeric]
		#   #     @return [Float]
		#   #   @overload $1 s:
		#   #     This overload is the same as the +speed:+ overload, but with a shorter name for convenience.
		#   #     @param s [Numeric]
		#   #     @return [Float]
		#   interpolable_property x
		#   interpolable_property y
		#   interpolable_property opacity
		#   interpolable_property size
		#   interpolable_property scale_x
		#   interpolable_property scale_y
		#   interpolable_property skew_x
		#   interpolable_property skew_y
		#   interpolable_property rotation
		#   interpolable_property text
		#   interpolable_property tint_red
		#   interpolable_property tint_green
		#   interpolable_property tint_blue
		#   interpolable_property circle_opacity
		#   interpolable_property circle_scale_x
		#   interpolable_property circle_scale_y
		#   interpolable_property circle_skew_x
		#   interpolable_property circle_skew_y
		#   interpolable_property circle_rotation
		#   interpolable_property circle_tint_red
		#   interpolable_property circle_tint_green
		#   interpolable_property circle_tint_blue
		#   interpolable_property width
		#   interpolable_property height
		#   interpolable_property anchor_x
		#   interpolable_property anchor_y
		INTERPOLABLE.each do |property|
			define_method property do |data_value = nil, speed: nil, s: nil|
				raise ArgumentError, 'cannot specify both speed and s' if !speed.nil? && !s.nil?
				speed = s if speed.nil?
				raise ArgumentError, 'must specify one and only one of data_value and speed' if [data_value, speed].compact.size != 1
				if !data_value.nil?
					raise ArgumentError, "#{property} must be a number" unless data_value.is_a? Numeric
					@data[property].data_point @current_beat, data_value.to_f
				else
					raise ArgumentError, "speed must be a number" unless speed.is_a? Numeric
					@data[property].speed = speed.to_f
				end
			end
		end

		# @!parse
		#   # @!macro [attach] uninterpolable_property
		#   #   @!method $1 data_value = nil, value: nil, v: nil
		#   #   @return [DataPoint, $2]
		#   #   @overload $1 data_value
		#   #     @param data_value [$2]
		#   #     @return [DataPoint]
		#   #   @overload $1 value:
		#   #     @param value [$2]
		#   #     @return [$2]
		#   #   @overload $1 v:
		#   #     This overload is the same as the +value:+ overload, but with a shorter name for convenience.
		#   #     @param v [$2]
		#   #     @return [$2]
		#   uninterpolable_property z, Numeric
		#   uninterpolable_property blend_mode, BLEND_MODES_SET
		#   uninterpolable_property circle_blend_mode, BLEND_MODES_SET
		#   uninterpolable_property text, String
		UNINTERPOLABLE.each do |property|
			define_method property do |data_value = nil, value: nil, v: nil|
				raise ArgumentError, "cannot specify both value and v" if !value.nil? && !v.nil?
				value = v if value.nil?
				raise ArgumentError, "must specify one and only one of data_value and value" if [data_value, value].compact.size != 1
				if !data_value.nil?
					raise ArgumentError, "wrong data type for data_value of #{property}" unless UNINTERPOLABLE_TYPES[property] === data_value
					@data[property].data_point @current_beat, data_value
				else
					raise ArgumentError, "wrong data type for value of #{property}" unless UNINTERPOLABLE_TYPES[property] === value
					@data[property].value = value
				end
			end
		end

		# @!endgroup

		# @return [Boolean]
		def empty?
			@data.empty?
		end

		# @return [TimeDependent]
		# TODO: use +initialize_copy+.
		def dup
			result = super
			result.data = @data.transform_values { _1.dup }
			result.data.default_proc = @data.default_proc
			result
		end

		# @return [Hash]
		def to_sunniesnow
			result = @data.transform_keys &:snake_to_camel
			result.transform_values! &:to_sunniesnow
			%i[blendMode circleBlendMode].each do |key|
				next unless result.has_key? key
				result[key][:dataPoints]&.each { _1[:value] = _1[:value].to_s.tr ?_, ?- }
				result[key][:value] = result[key][:value].to_s.tr ?_, ?- if result[key][:value]
			end
			result
		end
	end

	# An array of events.
	# @return [Array<Event>]
	attr_reader :events

	# @note Internal API.
	# @param type [Symbol]
	# @param duration_beats [Integer, Rational, nil]
	# @param properties [Hash{Symbol => Numeric, String}]
	# @return [Event]
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

	# @!group DSL Methods

	# @yieldself [TimeDependent]
	# @param events [Array<Event>, Event]
	# @param goto_beat [Boolean]
	# @param preserve_beat [Boolean]
	# @return [Array<Event>]
	def time_dependent events, goto_beat: true, preserve_beat: false, &block
		raise ArgumentError, 'no block given' unless block
		events = [events] if events.is_a? Event
		beat_backup = current_beat_state if !goto_beat || !preserve_beat
		events.each do |event|
			event.time_dependent.restore_beat_state goto_beat ? event.beat_state : beat_backup
			event.time_dependent.instance_eval &block
		end
		restore_beat_state preserve_beat ? events.last.time_dependent.current_beat_state : beat_backup
		events
	end
	alias td time_dependent

	# @!endgroup

end
