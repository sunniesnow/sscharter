# frozen_string_literal: true

require 'json'

class Sunniesnow::Chart

	using Sunniesnow::Utils

	attr_accessor :title, :artist, :charter
	attr_accessor :difficulty_name, :difficulty_color, :difficulty, :difficulty_sup
	attr_reader :events

	def initialize live_reload_port: 31108, production: false, live_restart: false
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
		@live_restart = live_restart
	end

	def to_json *args
		hash = {
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
			port: @live_reload_port,
			liveRestart: @live_restart
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
