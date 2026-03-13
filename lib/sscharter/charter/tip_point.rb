# frozen_string_literal: true

class Sunniesnow::Charter

	# @note Internal API.
	class TipPointStart

		# @param relative [Boolean] whether the position at which a created tip point appears specified by the arguments +x+ and +y+
		#   is relative to the first note it visits or absolute.
		# @param x [Numeric] the x-coordinate of the position at which a created tip point appears, whether relative or absolute.
		# @param y [Numeric] the y-coordinate of the position at which a created tip point appears, whether relative or absolute.
		# @overload initialize x, y, relative_time, relative: true
		#   @param relative_time [Numeric]
		#   The time at which a created tip point appears is the time of the first note it visits minus +relative_time+.
		# @overload initialize x, y, speed:, relative: true
		#   @param speed [Numeric]
		#   The time at which a created tip point appears is the time of the first note it visits minus
		#   the distance between the note and the position where the tip point appears divided by +speed+.
		# @overload initialize x, y, relative_beat:, relative: true
		#   @param relative_beat [Rational, Integer]
		#   The beat at which a created tip point appears is the beat of the first note it visits minus +relative_beat+.
		# @overload initialize x, y, beat_speed:, relative: true
		#   @param beat_speed [Numeric]
		#   The beat at which a created tip point appears is the beat of the first note it visits minus
		#   the distance between the note and the position where the tip point appears divided by +beat_speed+.
		def initialize x, y, relative_time = nil, relative: true, speed: nil, relative_beat: nil, beat_speed: nil
			@x = x
			@y = y
			@relative_time = relative_time
			@relative = relative
			@speed = speed
			@relative_beat = relative_beat
			@beat_speed = beat_speed
			check
		end

		# Checks that the parameters passed to {#initialize} is one of the valid overloads.
		# @return [void]
		# @raise [ArgumentError] if checks fail.
		def check
			if !@x.is_a?(Numeric) || !@y.is_a?(Numeric)
				raise ArgumentError, 'x and y must be numbers'
			end
			@x = @x.to_f
			@y = @y.to_f
			%i[@relative_time @speed @relative_beat @beat_speed].each do |key|
				value = instance_variable_get key
				next unless value
				raise ArgumentError, "cannot specify both #@time_key and #{key}" if @time_key
				@time_key = key
			end
			raise ArgumentError, "must specify one of relative_time, speed, relative_beat, beat_speed" unless @time_key
		end

		# @param start_event [Event]
		# @return [Event]
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

	# @note Internal API.
	# @param start_event [Event]
	# @return [void]
	def push_tip_point_start start_event
		start_event[:tip_point] = @current_tip_point_stack.last.to_s
		tip_point_start = @tip_point_start_to_add_stack.last&.get_start_placeholder start_event
		return unless tip_point_start
		@groups.each do |group|
			group.push tip_point_start
			break if group.equal?(@current_tip_point_group_stack.last) && @tip_point_mode_stack.last != :drop
		end
		nil
	end

	# @note Internal API.
	# @yieldself [Sunniesnow::Charter] the same as +self+.
	def tip_point mode, *args, preserve_beat: true, **opts, &block
		@tip_point_mode_stack.push mode
		if mode == :none
			@tip_point_start_stack.push nil
			@tip_point_start_to_add_stack.push nil
			@current_tip_point_stack.push nil
		else
			if args.empty? && opts.empty?
				unless @tip_point_start_stack.last
					raise ArgumentError, 'cannot omit tip point arguments at top level or inside tip_point_none'
				end
				@tip_point_start_stack.push @tip_point_start_stack.last.dup
			else
				@tip_point_start_stack.push TipPointStart.new *args, **opts
			end
			@tip_point_start_to_add_stack.push @tip_point_start_stack.last
			@current_tip_point_stack.push nil
		end
		result = group preserve_beat: preserve_beat do
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

	# @!group DSL Methods

	# @!parse
	#   # @!macro [attach] tip_point_mode
	#   #   @!method tip_point_$1 x, y, relative_time = nil, relative: true, speed: nil, relative_beat: nil, beat_speed: nil, preserve_beat: true, &block
	#   #   $2
	#   #   There are four overloads of this method for different ways to specify the time at which the tip point appears,
	#   #   and there is another overload that totally omits the arguments for specifying
	#   #   when and where the tip point appears and can only be used inside another tip point block.
	#   #   This method is otherwise the same as {#group}.
	#   #
	#   #   If the methods {#tp_chain}, {#tp_drop}, and {#tp_none} are nested in +block+,
	#   #   only the innermost one takes effect.
	#   #   @example Nested tip points
	#   #     offset 0.1; bpm 120
	#   #     tp_chain 0, 100, 1 do
	#   #       t 0, 0, 'A'; b 1 # tip point from above
	#   #       tp_drop -100, 0, 1 do
	#   #         t 25, 25, 'B'; b 1 # tip point from left
	#   #         t 50, 25, 'C'; b 1 # tip point from left
	#   #       end
	#   #       tp_none do
	#   #         t 75, 50, 'D'; b 1 # no tip point
	#   #       end
	#   #       t 100, 0, 'E'; b 1 # same tip point as note A
	#   #     end
	#   #   @param preserve_beat [Boolean] whether the {#current_beat} will be reset to the value before executing +block+ after it is executed.
	#   #   @param relative [Boolean] whether the position at which a created tip point appears specified by the arguments +x+ and +y+
	#   #     is relative to the first note it visits or absolute.
	#   #   @param x [Numeric] the x-coordinate of the position at which a created tip point appears, whether relative or absolute.
	#   #   @param y [Numeric] the y-coordinate of the position at which a created tip point appears, whether relative or absolute.
	#   #   @return [Array<Event>] the events created inside +block+, similar to {#group}.
	#   #   @raise [ArgumentError]
	#   #   @yieldself [Charter] the same as +self+.
	#   #   @overload tip_point_$1 x, y, relative_time, relative: true, preserve_beat: true, &block
	#   #     @param relative_time [Numeric]
	#   #     The time at which a created tip point appears is the time of the first note it visits minus +relative_time+.
	#   #   @overload tip_point_$1 x, y, speed:, relative: true, preserve_beat: true, &block
	#   #     @param speed [Numeric]
	#   #     The time at which a created tip point appears is the time of the first note it visits minus
	#   #     the distance between the note and the position where the tip point appears divided by +speed+.
	#   #   @overload tip_point_$1 x, y, relative_beat:, relative: true, preserve_beat: true, &block
	#   #     @param relative_beat [Rational, Integer]
	#   #     The beat at which a created tip point appears is the beat of the first note it visits minus +relative_beat+.
	#   #   @overload tip_point_$1 x, y, beat_speed:, relative: true, preserve_beat: true, &block
	#   #     @param beat_speed [Numeric]
	#   #     The beat at which a created tip point appears is the beat of the first note it visits minus
	#   #     the distance between the note and the position where the tip point appears divided by +beat_speed+.
	#   #   @overload tip_point_$1 preserve_beat: true, &block
	#   #     This overload can only be used inside another tip point block,
	#   #     and it creates a tip point with the same parameters as the one created by the outer block.
	#   tip_point_mode :chain, 'Create a tip point to connect the notes created inside +block+.'
	#   tip_point_mode :drop, 'A tip point is created for each note created inside +block+.'
	#   alias tp_chain tip_point_chain
	#   alias tp_drop tip_point_drop
	#   alias tp_none tip_point_none
	# @!method tip_point_none preserve_beat: true, &block
	#   Notes created inside +block+ will not be visited by any tip point.
	#   This method is otherwise the same as {#group}.
	#   @yieldself [Charter] the same as +self+.
	#   @return [Array<Event>] the events created inside +block+, similar to {#group}.
	%i[chain drop none].each do |mode|
		define_method "tip_point_#{mode}" do |*args, **opts, &block|
			tip_point mode, *args, **opts, &block
		end
		alias_method "tp_#{mode}", "tip_point_#{mode}"
	end

	# @!endgroup

end
