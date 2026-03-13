# frozen_string_literal: true

require 'test_helper'
require 'tempfile'
require 'open3'

class TestSscharter < Minitest::Test

	REAL_CHARTS_SKIP_IF = {
		# some syntax is considered error in YACC but not in Prism
		lucky_clover_master: -> { RUBY_VERSION < '3.4' },
	}

	def compare_basic_objects expected, got
		expected = expected.to_f if expected.is_a? Integer
		got = got.to_f if got.is_a? Integer
		assert_equal expected.class, got.class
		case expected
		when Hash
			assert_equal expected.keys.sort, got.keys.sort
			expected.each { |key, value| compare_basic_objects value, got[key] }
		when Array
			assert_equal expected.size, got.size
			expected.zip(got) { |expected_item, got_item| compare_basic_objects expected_item, got_item }
		when Float
			assert_in_delta expected, got, 1e-9
		else
			assert_equal expected, got
		end
	end

	def compare_charts expected, got
		%i[title artist charter difficultyName difficultyColor difficulty].each do |key|
			assert_equal expected[key], got[key], "Mismatch for key: #{key}"
		end
		# difficultySup is not present for old charts
		assert_equal expected[:difficultySup], got[:difficultySup] if expected[:difficultySup]

		assert_equal expected[:events].size, got[:events].size
		tip_points_map_expected = {}
		tip_points_map_got = {}
		expected[:events].zip got[:events] do |expected_event, got_event|
			expected_tip_point = expected_event[:properties]&.[] :tipPoint
			got_tip_point = got_event[:properties]&.[] :tipPoint
			if expected_tip_point
				refute_nil got_tip_point
				if tip_points_map_expected[expected_tip_point]
					assert_equal tip_points_map_got[got_tip_point], expected_tip_point, "Mismatch for tip point: #{expected_tip_point}"
					assert_equal tip_points_map_expected[expected_tip_point], got_tip_point, "Mismatch for tip point: #{expected_tip_point}"
				else
					tip_points_map_expected[expected_tip_point] = got_tip_point
					tip_points_map_got[got_tip_point] = expected_tip_point
				end
				expected_event[:properties].delete :tipPoint
				got_event[:properties].delete :tipPoint
			else
				assert_nil got_tip_point
			end
			compare_basic_objects expected_event, got_event
		end
	end

	Dir.glob File.join __dir__, 'real_charts', '*.rb' do |file|
		name = File.basename(file, '.rb').to_sym
		define_method "test_#{name}" do
			skip if REAL_CHARTS_SKIP_IF[name]&.()
			got = Tempfile.create do |got_file|
				# Use open3 to suppress output
				Open3.capture2 'ruby', '-I', File.expand_path('../lib', __dir__), '-e', <<-'RUBY', '--', file, got_file.path
					require 'sscharter'
					load ARGV[0]
					chart = Sunniesnow::Charter.charts.values.first.to_sunniesnow production: true
					File.write ARGV[1], JSON.generate(chart)
				RUBY
				JSON.load got_file, symbolize_names: true, create_additions: false
			end
			expected = JSON.load_file file.sub(/\.rb$/, '.json'), symbolize_names: true
			compare_charts expected, got
		end
	end

end
