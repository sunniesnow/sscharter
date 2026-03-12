# frozen_string_literal: true

class Sunniesnow::Charter

	using Sunniesnow::Utils

	class OffsetError < StandardError
		# @param method_name [Symbol]
		def initialize method_name
			super "offset must be set before using #{method_name}"
		end
	end

	class BpmChangeList

		class BpmChange

			# @return [Rational]
			attr_accessor :beat

			# @return [Float]
			attr_accessor :bps

			# @param beat [Rational]
			# @param bpm [Float]
			def initialize beat, bpm
				@beat = beat
				@bps = bpm / 60.0
			end

			# @return [Float]
			def bpm
				@bps * 60.0
			end

			# @param bpm [Float]
			# @return [Float]
			def bpm= bpm
				@bps = bpm / 60.0
			end

			# @param other [BpmChange]
			# @return [-1,0,1]
			def <=> other
				@beat <=> other.beat
			end
		end

		# @return [Float]
		attr_accessor :offset

		# @param offset [Float]
		def initialize offset
			@offset = offset
			@list = []
		end

		# @param beat [Rational]
		# @param bpm [Float]
		# @return [BpmChangeList] +self+.
		def add beat, bpm
			if index = @list.bsearch_index { beat <=> _1.beat }
				@list[index].bpm = bpm
			else
				@list.push BpmChange.new beat, bpm
				@list.sort!
			end
			self
		end

		# @param beat [Rational]
		# @return [Float]
		def time_at beat
			index = @list.bisect(right: true) { _1.beat <=> beat }
			raise ArgumentError, 'beat is before the first bpm change' if index < 0
			bpm = @list[index]
			(0...index).sum @offset + (beat - bpm.beat) / bpm.bps do |i|
				bpm = @list[i]
				(@list[i+1].beat - bpm.beat) / bpm.bps
			end
		end

		# @param beat [Rational]
		# @return [Float]
		def bps_before beat
			raise ArgumentError, 'beat is before or at the first bpm change' if beat <= @list.first.beat
			@list[@list.bisect(right: false) { _1.beat <=> beat } - 1].bps
		end

		# @param beat [Rational]
		# @return [Float]
		def bps_after beat
			raise ArgumentError, 'beat is before the first bpm change' if beat < @list.first.beat
			@list[@list.bisect(right: true) { _1.beat <=> beat }].bps
		end

		# @param index [Integer]
		# @return [BpmChange?]
		def [] index
			@list[index]
		end
	end

	# @note Internal API.
	# @!parse
	#   class BeatState < Data
	#     # @return [Rational]
	#     attr_reader :current_beat
	#     # @return [BpmChangeList]
	#     attr_reader :bpm_changes
	#   end
	BeatState = Data.define :current_beat, :bpm_changes

	module Metronomic

		# @return [Float]
		attr_accessor :offset

		# @return [Integer, Rational]
		attr_accessor :beat

		# @return [Integer, Rational, nil]
		attr_accessor :duration_beats

		# @return [BpmChangeList]
		attr_reader :bpm_changes

		# @return [Float]
		# @param delta_beat [Integer, Rational]
		def time_at_relative_beat delta_beat
			@offset + @bpm_changes.time_at(@beat + delta_beat)
		end

		# @return [Float]
		def time
			time_at_relative_beat 0
		end

		# @return [Float]
		def end_time
			time_at_relative_beat @duration_beats || 0
		end

		# @note Internal API.
		# @return BeatState
		def beat_state
			BeatState.new @beat, @bpm_changes
		end

		# @param other [Metronomic]
		# @return [-1,0,1]
		def <=> other
			@beat <=> other.beat
		end
	end

	# Including this module adds the ability to keep track of the current beat and set BPM changes at the current beat.
	# It provides methods {#beat} and {#beat!} to navigate through the beats.
	#
	# The examples shown in the documentation below assume that +self+ is a {Charter} instance.
	module BeatSeries

		# It is +nil+ if the offset has not been set by {Charter#offset} yet.
		# @return [Rational?]
		attr_accessor :current_beat

		# It is +nil+ if the offset has not been set by {Charter#offset} yet.
		# @return [BpmChangeList?]
		attr_reader :bpm_changes

		# @!group DSL Methods

		# Set the BPM starting at the current beat.
		# This method must be called after {Charter#offset}.
		# The method can be called multiple times,
		# which is useful when the music changes its tempo from time to time.
		#
		# Internally, this simply calls {BpmChangeList#add} on the BPM changes created by {Charter#offset}.
		# @param bpm [Numeric] the BPM.
		# @raise [OffsetError] if {Charter#offset} has not been called.
		# @return [BpmChangeList] the BPM changes.
		def bpm bpm
			raise OffsetError.new __method__ unless @bpm_changes
			@bpm_changes.add @current_beat, bpm
		end

		# Increments the current beat by the given delta set by +delta_beat+.
		# It is recommended that +delta_beat+ be a Rational or an Integer for accuracy.
		# Float will be converted to Rational, and a warning will be issued
		# when a Float is used.
		#
		# This method is also useful for inspecting the current beat.
		# If the method is called without an argument, it simply returns the current beat.
		# For this purpose, this method is equivalent to {#beat!}.
		#
		# This method must be called after {Charter#offset}.
		# @param delta_beat [Rational, Integer] the delta to increment the current beat by.
		# @raise [OffsetError] if {Charter#offset} has not been called.
		# @return [Rational] the new current beat.
		# @see #beat!
		# @example Increment the current beat and inspect it
		#   offset 0.1; bpm 120
		#   p b       # Outputs 0, this is the initial value
		#   p b 1     # Outputs 1, because it is incremented by 1 when it was 0
		#   p b 1/2r  # Outputs 3/2, because it is incremented by 3/2 when it was 1
		#   p time_at # Outputs 0.85, which is offset + 60s / BPM * beat
		# @example Time the notes
		#   offset 0.1; bpm 120
		#   t 0, 0; b 1
		#   t 50, 0; b 1
		#   # Now there are two tap notes, one at beat 0, and the other at beat 1
		def beat delta_beat = 0
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

		# Sets the current beat to the given value.
		# It is recommended that +beat+ be a Rational or an Integer for accuracy.
		# Float will be converted to Rational, and a warning will be issued.
		#
		# When called without an argument, this method does nothing and returns the current beat.
		# For this purpose, this method is equivalent to {#beat}.
		#
		# This method must be called after {Charter#offset}.
		# @param beat [Rational, Integer] the new current beat.
		# @raise [OffsetError] if {Charter#offset} has not been called.
		# @return [Rational] the new current beat.
		# @see #beat
		# @example Set the current beat and inspect it
		#   offset 0.1; bpm 120
		#   p b!      # Outputs 0, this is the initial value
		#   p b! 1    # Outputs 1, because it is set to 1
		#   p b! 1/2r # Outputs 1/2, because it is set to 1/2
		#   p time_at # Outputs 0.35, which is offset + 60s / BPM * beat
		def beat! beat = @current_beat
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

		# @!endgroup

		# @param beat [Rational]
		# @return [Float]
		# @raise [OffsetError] if {Charter#offset} has not been called.
		def time_at beat = @current_beat
			raise OffsetError.new __method__ unless @bpm_changes
			@bpm_changes.time_at beat
		end

		# @note Internal API.
		# @return [BeatState]
		def current_beat_state
			BeatState.new @current_beat, @bpm_changes
		end

		# @note Internal API.
		# @param backup [BeatState]
		# @return [void]
		def restore_beat_state backup
			@current_beat = backup.current_beat
			@bpm_changes = backup.bpm_changes
			nil
		end
	end

	include BeatSeries

	# @note Internal API.
	# @return [void]
	def init_beat_state
		@current_beat = nil
		@bpm_changes = nil
	end

	# @!group DSL Methods

	# Set the offset.
	# This is the time in seconds of the zeroth beat.
	# This method must be called before any other methods that require a beat,
	# or an {OffsetError} will be raised.
	#
	# After calling this method, the current beat (see {#beat} and {#beat!}) is set to zero,
	# and a new BPM needs to be set using {#bpm}.
	# Only after that can the time of any positive beat be calculated.
	#
	# Though not commonly useful, this method can be called multiple times in a chart.
	# A new call of this method does not affect the events and BPM changes set before.
	# Technically, each event is associated with a BPM change list (see {Event#bpm_changes}),
	# and each call of this method creates a new BPM change list,
	# which is used for the events set after.
	# @param offset [Numeric] the offset in seconds.
	# @return [BpmChangeList] the BPM changes.
	# @see BpmChangeList
	# @raise [ArgumentError] if +offset+ is not a number.
	# @example
	#   offset 0.1
	#   p time_at # Outputs 0.1, which is the offset
	#   offset 0.2
	#   p time_at # Outputs 0.2, which is the updated offset by the second call
	def offset offset
		raise ArgumentError, 'offset must be a number' unless offset.is_a? Numeric
		@current_beat = 0r
		@bpm_changes = BpmChangeList.new offset.to_f
	end

	# @!endgroup

end
