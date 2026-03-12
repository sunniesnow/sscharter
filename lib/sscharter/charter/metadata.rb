# frozen_string_literal: true

class Sunniesnow::Charter

	# Aliases for some colors that can be used with {#difficulty_color}.
	COLORS = {
		easy: '#3eb9fd',
		normal: '#f19e56',
		hard: '#e75e74',
		master: '#8c68f3',
		special: '#f156ee'
	}.freeze

	# @note Internal API.
	# @return [void]
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

	# @!group DSL Methods

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

	# @!endgroup

end
