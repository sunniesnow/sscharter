# frozen_string_literal: true

require 'json'

class Sunniesnow::Chart

	using Sunniesnow::Utils

	attr_accessor :title, :artist, :charter
	attr_accessor :difficulty_name, :difficulty_color, :difficulty
	attr_reader :events

	def initialize
		@title = ''
		@artist = ''
		@charter = ''
		@difficulty_name = ''
		@difficulty_color = '#000000'
		@difficulty = ''
		@events = []
	end

	def to_json *args
		{
			title: @title,
			artist: @artist,
			charter: @charter,
			difficultyName: @difficulty_name,
			difficultyColor: @difficulty_color,
			difficulty: @difficulty,
			events: @events
		}.to_json
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
