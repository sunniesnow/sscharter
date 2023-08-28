module Sunniesnow::Utils

	refine Array do
		# If there no match, return the next index.
		# Less than all: return 0. Greater than all: return array.length.
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
end
