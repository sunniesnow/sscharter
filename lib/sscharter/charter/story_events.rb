# frozen_string_literal: true

require 'set'

class Sunniesnow::Charter

	using Sunniesnow::Utils

	IMAGE_LAYER_ABOVE = %i[none background bg_pattern hud fx judgement_line bg_notes notes circles tip_points fx_front].freeze

	IMAGE_LAYER_ABOVE_SET = IMAGE_LAYER_ABOVE.to_set.freeze

	COORDINATE_SYSTEMS = %i[canvas chart].freeze

	COORDINATE_SYSTEMS_SET = COORDINATE_SYSTEMS.to_set.freeze

	# @!group DSL Methods

	# Creates an image event.
	# @param filename [String]
	# @param x [Numeric]
	# @param y [Numeric]
	# @param duration_beats [Integer, Rational]
	# @param width [Numeric]
	# @param height [Numeric?]
	# @param above [IMAGE_LAYER_ABOVE_SET?]
	# @param coordinate_system [COORDINATE_SYSTEMS_SET?]
	# @param mirrorable [Boolean?]
	# @return [Event]
	def image filename, x, y, duration_beats, width, height = nil, above: nil, coordinate_system: nil, mirrorable: nil
		raise ArgumentError, 'filename must be a string' unless filename.is_a? String
		raise ArgumentError, 'x and y must be numbers' unless x.is_a?(Numeric) && y.is_a?(Numeric)
		raise ArgumentError, 'duration_beats must be a number' unless duration_beats.is_a? Numeric
		raise ArgumentError, 'duration_beats must be non-negative' if duration_beats < 0
		raise ArgumentError, 'width must be a number' unless width.is_a? Numeric
		raise ArgumentError, 'height must be a number' if !height.nil? && !height.is_a?(Numeric)
		raise ArgumentError, "unknown coordinate_system #{coordinate_system}" if !coordinate_system.nil? && !%i[chart screen].include?(coordinate_system)
		warn 'Rational is recommended over Float for duration_beats' if duration_beats.is_a? Float
		raise ArgumentError, "invalid above: #{above}" if !above.nil? && !IMAGE_LAYER_ABOVE_SET.include?(above)
		raise ArgumentError, "invalid coordinate_system: #{coordinate_system}" if !coordinate_system.nil? && !COORDINATE_SYSTEMS_SET.include?(coordinate_system)
		raise ArgumentError, "mirrorable must be a boolean" unless [nil, true, false].include? mirrorable
		additional_properties = {}
		additional_properties[:above] = above.snake_to_camel if above
		additional_properties[:coordinate_system] = coordinate_system.snake_to_camel if coordinate_system
		additional_properties[:mirrorable] = mirrorable unless mirrorable.nil?
		additional_properties[:height] = height.to_f if height
		event :image, duration_beats.to_r, filename: filename, x: x.to_f, y: y.to_f, width: width.to_f, **additional_properties
	end

	# TODO: other story events

	# @!endgroup

end
