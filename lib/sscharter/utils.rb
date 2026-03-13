# frozen_string_literal: true

# @note Internal API.
module Sunniesnow::Utils

	refine Array do
		# Do a binary search. If there is a match, return the index of the match.
		# Otherwise, if +right+, return the index of the last element that is less than the value;
		# otherwise, return the index of the first element that is greater than the value.
		def bisect value = nil, right: false, &compare_function
			if value && compare_function
				raise ArgumentError, "Cannot specify both value and compare_function"
			end
			compare_function ||= ->e { e <=> value }
			low = 0
			high = length
			while low < high
				mid = low + high >> 1
				compare = compare_function.(self[mid])
				if compare == 0
					return mid
				elsif compare < 0
					low = mid + 1
				else
					high = mid
				end
			end
			right ? high - 1 : low
		end
	end

	refine String do
		def snake_to_camel
			result = self.split('_').map!(&:capitalize).join
			result[0] = result[0].downcase
			result
		end
	end

	refine Symbol do
		def snake_to_camel
			to_s.snake_to_camel.to_sym
		end
	end

	if Object.const_defined? :Data # Ruby 3.2
		Data = Data
	else
		class Data < Struct
			def self.define *fields, &block
				new *fields do
					fields.each { undef_method "#{_1}=" }
					class_eval &block if block
				end
			end
		end
	end
end
