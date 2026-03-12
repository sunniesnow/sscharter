# frozen_string_literal: true

class Sunniesnow::Charter

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

	# @!group DSL Methods

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

	# @!parse
	#   # @!macro [attach] bg_pattern
	#   #   @!method $1(duration_beats = 0)
	#   #   Creates a $2 background pattern.
	#   #   The argument +duration_beats+ is the duration of the background pattern in beats.
	#   #   It needs to be a non-negative Rational or Integer.
	#   #   If it is a Float, it will be converted to a Rational, and a warning will be issued.
	#   #
	#   #   Technically, this adds an event of type +:$1+ to the chart at the current time
	#   #   with properties containing the information provided by +duration_beats+.
	#   #   @param duration_beats [Rational, Integer] the duration of the background pattern in beats.
	#   #   @return [Event] the event representing the background pattern.
	#   #   @raise [ArgumentError] if +duration_beats+ is not a number or is negative.
	#   #   @example
	#   #     offset 0.1; bpm 120
	#   #     $1 1 # duration is 1
	#   #     b 1
	#   #     $1 0 # duration is 0
	#   bg_pattern :grid, 'grid'
	#   bg_pattern :hexagon, 'hexagon'
	#   bg_pattern :checkerboard, 'checkerboard'
	#   bg_pattern :diamond_grid, 'diamond grid'
	#   bg_pattern :pentagon, 'pentagon'
	#   bg_pattern :turntable, 'turntable'
	#   bg_pattern :hexagram, 'hexagram'
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

	# @!endgroup

end
