# frozen_string_literal: true

class Sunniesnow::Charter

	# The project directory.
	PROJECT_DIR = File.expand_path(ENV['SSCHARTER_PROJECT_DIR'] ||= Dir.pwd).freeze

	# @!scope class
	# A hash containing all the charts opened by {::open}.
	# The keys are the names of the charts, and the values are the {Sunniesnow::Charter} objects.
	# @return [Hash{String => Sunniesnow::Charter}]
	singleton_class.attr_reader :charts
	@charts = {}

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
	# @return [Charter] the chart.
	# @yieldself [Charter] the chart, the same as the return value.
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
		init_beat_state
		init_group_state
		init_bookmarks
	end

	# See {Sunniesnow::Chart#initialize} for the arguments.
	# @return [Sunniesnow::Chart]
	# @overload to_sunniesnow live_reload_port: 31108, production: false
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

	# @return [String]
	def output_json *args, **opts
		to_sunniesnow(**opts).to_json *args
	end

	# @return [String]
	def inspect
		"#<Sunniesnow::Charter #@name>"
	end

end

require_relative 'charter/metadata'
require_relative 'charter/beat'
require_relative 'charter/event'
require_relative 'charter/group'
require_relative 'charter/events_manip'
require_relative 'charter/basic_events'
require_relative 'charter/tip_point'
require_relative 'charter/story_events'
require_relative 'charter/check'
