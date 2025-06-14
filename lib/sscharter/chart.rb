# frozen_string_literal: true

require 'json'

# A class to represent a chart.
# Basically a wrapper around the metadata and events ({Sunniesnow::Event}) of a chart.
# The main method is {#to_json}, which converts the chart to a JSON string
# that is actually recognizable by Sunniesnow.
class Sunniesnow::Chart

	using Sunniesnow::Utils

	# The schema URL for the output JSON.
	# This will be set as the `$schema` property in the generated JSON.
	SCHEMA = 'https://sunniesnow.github.io/schema/chart-1.0.json'

	# The title of the music.
	# This is one of the metadata of the chart which will be reflected in the generated JSON.
	# Also, see
	# {chart file specifications}[https://sunniesnow.github.io/doc/chart.html#title]
	# for more info.
	attr_accessor :title
	
	attr_accessor :artist
	attr_accessor :charter
	attr_accessor :difficulty_name
	attr_accessor :difficulty_color
	attr_accessor :difficulty
	attr_accessor :difficulty_sup

	# An array of Sunniesnow::Event.
	attr_reader :events

	# @param [Integer] live_reload_port The port to use for live reload.
	#   It is useless if +production+ is +true+.
	# @param [Boolean] production Whether the chart is in production or not.
	#   If +true+, the generated JSON (see {#to_json}) will not contain
	#   necessary information for sscharter integration in Sunniesnow
	#   (such as the live reload feature and reverse search feature).
	def initialize live_reload_port: 31108, production: false
		@title = ''
		@artist = ''
		@charter = ''
		@difficulty_name = ''
		@difficulty_color = '#000000'
		@difficulty = ''
		@difficulty_sup = ''
		@events = []
		@live_reload_port = live_reload_port
		@production = production
	end

	##
	# Convert to JSON.
	# A Sunniesnow chart is always a JSON file in the level file.
	# This method is used to generate that JSON file.
	def to_json *args
		hash = {
			'$schema': SCHEMA,
			title: @title,
			artist: @artist,
			charter: @charter,
			difficultyName: @difficulty_name,
			difficultyColor: @difficulty_color,
			difficulty: @difficulty,
			difficultySup: @difficulty_sup,
			events: @events
		}
		hash[:sscharter] = {
			version: Sunniesnow::Charter::VERSION,
			port: @live_reload_port
		} unless @production
		hash.to_json
	end
end

class Sunniesnow::Event
	
	attr_accessor :time, :type
	attr_reader :properties

	def initialize time, type, **properties
		@time = time
		@type = type
		@properties = properties
	end

	def [] key
		@properties[key]
	end

	def []= key, value
		@properties[key] = value
	end

	def to_json *args
		{time: @time, type: @type, properties: @properties}.to_json
	end
end
