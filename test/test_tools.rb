# frozen_string_literal: true

require 'test_helper'

class TestSscharter < Minitest::Test

	include Sunniesnow::Tools
	include Math

	def test_line_length
		assert_in_delta path('M 0 0 L 3 4').length, 5.0, 1e-6
	end

	def test_arc_length
		assert_in_delta path('M 0 0 A 4 4 0 0 1 4 4').length, PI*2, 1e-1
	end

	def test_quadratic_bezier_length
		assert_in_delta path('M 0 0 Q 2 4 4 0').length, 5.91577, 1e-1
	end
end
