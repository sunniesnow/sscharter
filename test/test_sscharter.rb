# frozen_string_literal: true

require "test_helper"

class TestSscharter < Minitest::Test

	include Sunniesnow
	include Math

	def test_that_it_has_a_version_number
		refute_nil Charter::VERSION
	end

	def test_chart_metadata
		Charter.open __method__ do
			title 'Test Title'
			artist 'Test Artist'
			charter 'Test Charter'
			difficulty_name 'Test difficulty name'
			difficulty_color '#521108'
			difficulty 'Test difficulty'
		end
		chart = Charter.charts[__method__]
		chart.instance_exec method :assert_equal do |t|
			t.call 'Test Title', @title
			t.call 'Test Artist', @artist
			t.call 'Test Charter', @charter
			t.call 'Test difficulty name', @difficulty_name
			t.call '#521108', @difficulty_color
			t.call 'Test difficulty', @difficulty
		end
	end

	def test_difficulty_colors
		chart = Charter.open __method__

		Charter::COLORS.each do |(key, value)|
			chart.difficulty_color key
			assert_equal value, chart.instance_variable_get(:@difficulty_color)
		end

		r, g, b = Array.new(3) { rand 256 }
		chart.difficulty_color sprintf '#%02x%02x%02x', r, g, b
		assert_equal sprintf('#%02x%02x%02x', r, g, b), chart.instance_variable_get(:@difficulty_color)

		r, g, b = Array.new(3) { rand 16 }
		chart.difficulty_color sprintf '#%x%x%x', r, g, b
		assert_equal sprintf('#%x%x%x%x%x%x', r,r,g,g,b,b), chart.instance_variable_get(:@difficulty_color)

		r, g, b = Array.new(3) { rand 256 }
		chart.difficulty_color sprintf 'rgb(%d,%d,%d)', r, g, b
		assert_equal sprintf('#%02x%02x%02x', r, g, b), chart.instance_variable_get(:@difficulty_color)

		rgb = rand 0x1000000
		chart.difficulty_color sprintf '#%06x', rgb
		assert_equal sprintf('#%06x', rgb), chart.instance_variable_get(:@difficulty_color)

		assert_raises(ArgumentError) { chart.difficulty_color 'invalid' }
	end

	def test_offset_and_beat
		chart = Charter.open __method__
		assert_raises(Charter::OffsetError) { chart.beat 0 }
		assert_raises(Charter::OffsetError) { chart.beat! 0 }
		assert_raises(Charter::OffsetError) { chart.bpm 120 }
		assert_raises(Charter::OffsetError) { chart.time_at 0 }
		assert_raises(Charter::OffsetError) { chart.event :placeholder }

		chart.offset offset = rand
		assert_equal offset, chart.instance_variable_get(:@current_offset)
		assert_equal 0r, chart.instance_variable_get(:@current_beat)
		chart.beat 10
		assert_equal 10r, chart.instance_variable_get(:@current_beat)
		chart.beat 20
		assert_equal 30r, chart.instance_variable_get(:@current_beat)
		chart.beat! 100
		assert_equal 100r, chart.instance_variable_get(:@current_beat)
		chart.offset rand
		assert_equal 0r, chart.instance_variable_get(:@current_beat)
	end

	def test_bpm_change
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		bps = bpm / 60
		assert_equal offset, chart.time_at

		chart.beat beat1 = rand(100)
		assert_in_delta offset + beat1/bps, chart.time_at, 1e-8

		chart.bpm new_bpm = bpm * rand
		new_bps = new_bpm / 60
		chart.beat beat2 = rand(100)
		assert_in_delta offset + beat1/bps + beat2/new_bps, chart.time_at, 1e-8

		test_beat = rand beat1
		assert_in_delta offset + test_beat/bps, chart.time_at(test_beat), 1e-8

		test_beat = rand beat2
		assert_in_delta offset + beat1/bps + test_beat/new_bps, chart.time_at(beat1 + test_beat), 1e-8
	end

	def test_notes
		chart = Charter.open __method__ do
			offset rand
			bpm rand * 300
		end
		chart.tap (x1 = rand 100), (y1 = rand 100), (text1 = Random.bytes 10)
		chart.hold (x2 = rand 100), (y2 = rand 100), (duration2 = rand 100), (text2 = Random.bytes 10)
		chart.drag (x3 = rand 100), (y3 = rand 100)
		chart.flick (x4 = rand 100), (y4 = rand 100), (direction = rand*PI*2), (text4 = Random.bytes 10)
		events = chart.instance_variable_get :@events
		assert_equal events.map(&:type), %i[tap hold drag flick]
		assert_equal events.map { [_1[:x], _1[:y]] }, [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
		assert_equal events.map { _1[:text] }, [text1, text2, nil, text4]
	end

	def test_group
		chart = Charter.open __method__ do
			offset rand
			bpm rand * 300
		end
		events = chart.instance_variable_get :@events

		group1 = chart.group do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		assert_equal events.length, 2
		assert_equal chart.instance_variable_get(:@current_beat), 3
		assert_equal group1, events

		group2 = chart.group preserve_beat: false do
			h rand(100), rand(100), rand(10) + 1
			b 1
			d rand(100), rand(100)
			b 2
		end
		assert_equal events.map(&:beat), [0, 1, 3, 4]
		assert_equal chart.instance_variable_get(:@current_beat), 3
		assert_equal [*group1, *group2], events
	end

	def test_tip_point_chain
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		events = chart.instance_variable_get :@events

		group1 = chart.tip_point_chain (x = rand 100), (y = rand 100), (t1 = rand) do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		assert_equal events.length, 3
		assert_equal events, group1
		refute_nil tp_spawn = group1.find { _1.type == :placeholder }
		refute_nil chain_head = group1.find { _1.type != :placeholder }
		assert_equal chain_head.type, :tap
		assert_in_delta tp_spawn[:x], chain_head[:x] + x, 1e-8
		assert_in_delta tp_spawn[:y], chain_head[:y] + y, 1e-8
		assert_in_delta tp_spawn.time, offset - t1, 1e-8

		group2 = chart.tip_point_chain (x = rand 100), (y = rand 100), rand, relative: false do
			t rand(100), rand(100)
			b 1
			d rand(100), rand(100)
			b 2
		end
		assert_equal events.length, 6
		assert_equal events, [*group1, *group2]
		refute_nil tp_spawn = group2.find { _1.type == :placeholder }
		assert_in_delta tp_spawn[:x], x, 1e-8
		assert_in_delta tp_spawn[:y], y, 1e-8

		x1, x2 = rand(100), rand(100)
		group3 = chart.tip_point_chain (x = rand 100), (y = rand 100), speed: (speed = rand*100) do
			f x1, x2, rand*PI*2
			b 1
		end
		assert_equal events.length, 8
		assert_equal events, [*group1, *group2, *group3]
		refute_nil tp_spawn = group3.find { _1.type == :placeholder }
		refute_nil chain_head = group3.find { _1.type != :placeholder }
		assert_equal chain_head.type, :flick
		assert_in_delta tp_spawn[:x], x1 + x, 1e-8
		assert_in_delta tp_spawn[:y], x2 + y, 1e-8
		assert_in_delta chain_head.time - tp_spawn.time, hypot(x, y)/speed, 1e-8

		group4 = chart.tip_point_chain (x = rand 100), (y = rand 100), beat_speed: (beat_speed = rand*100) do
			h rand(100), rand(100), rand(10) + 1
			b 1
		end
		assert_equal events.length, 10
		assert_equal events, [*group1, *group2, *group3, *group4]
		refute_nil tp_spawn = group4.find { _1.type == :placeholder }
		refute_nil chain_head = group4.find { _1.type != :placeholder }
		assert_equal chain_head.type, :hold
		assert_in_delta chain_head.time - tp_spawn.time, hypot(x,y)/beat_speed/bpm*60, 1e-8

		assert_raises ArgumentError do
			chart.tip_point_chain rand(100), rand(100), rand + 1, speed: rand*100, preserve_beat: false do
			end
		end
	end

	def test_tip_point_drop
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		events = chart.instance_variable_get :@events

		group1 = chart.tip_point_drop (x = rand 100), (y = rand 100), (t1 = rand) do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		assert_equal events.length, 4
		tp_spawns = group1.select { _1.type == :placeholder }
		assert_equal tp_spawns.length, 2
		assert_in_delta tp_spawns[0].time, offset - t1, 1e-8
		assert_in_delta tp_spawns[1].time, offset - t1 + 60/bpm, 1e-8
	end

	def test_transform
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		events = chart.instance_variable_get :@events

		x1, y1, x2, y2 = Array.new(4) { rand 100 }
		angle = rand*PI*2
		group1 = chart.group do
			t x1, y1
			b 1
			f x2, y2, angle
			b 2
		end
		tap, flick = events
		assert_equal [tap.type, tap[:x], tap[:y]], [:tap, x1, y1]
		assert_equal [flick.type, flick[:x], flick[:y], flick[:angle]], [:flick, x2, y2, angle]

		chart.transform(group1) { horizontal_flip }
		assert_equal tap[:x], -x1
		assert_equal flick[:x], -x2
		assert_in_delta (flick[:angle] + angle).modulo(PI*2), PI, 1e-8

		chart.transform(group1) { vertical_flip }
		assert_equal tap[:y], -y1
		assert_equal flick[:y], -y2
		assert_in_delta (flick[:angle] - angle).modulo(PI*2), PI, 1e-8

		chart.transform(group1) { rotate PI }
		assert_in_delta tap[:x], x1, 1e-8
		assert_in_delta tap[:y], y1, 1e-8
		assert_in_delta flick[:x], x2, 1e-8
		assert_in_delta flick[:y], y2, 1e-8
		assert_in_delta (flick[:angle] - angle + PI).modulo(PI*2), PI, 1e-8

		rotate_angle = (rand*0.8+0.1)*PI*2
		chart.transform(group1) { rotate rotate_angle }
		assert_in_delta tap[:x], x1*cos(rotate_angle) - y1*sin(rotate_angle), 1e-8
		assert_in_delta tap[:y], x1*sin(rotate_angle) + y1*cos(rotate_angle), 1e-8
		assert_in_delta flick[:x], x2*cos(rotate_angle) - y2*sin(rotate_angle), 1e-8
		assert_in_delta flick[:y], x2*sin(rotate_angle) + y2*cos(rotate_angle), 1e-8
		assert_in_delta (flick[:angle] - angle).modulo(PI*2), rotate_angle, 1e-8

		chart.transform(group1) { rotate -rotate_angle }
		scale_x, scale_y = rand + 0.5, rand + 0.5
		chart.transform(group1) { scale scale_x, scale_y }
		assert_in_delta tap[:x], scale_x * x1
		assert_in_delta tap[:y], scale_y * y1
		assert_in_delta flick[:x], scale_x * x2
		assert_in_delta flick[:y], scale_y * y2
		assert_in_delta tan(flick[:angle])/tan(angle), scale_y/scale_x, 1e-8

		delta_beat = rand 100
		chart.transform(group1) { beat_translate delta_beat }
		assert_equal tap.beat, delta_beat
		assert_equal flick.beat, delta_beat + 1
	end

	def test_duplicate
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		events = chart.instance_variable_get :@events

		group1 = chart.group do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		group2 = chart.duplicate group1
		assert_equal events.length, 4
		assert_equal events, [*group1, *group2]

		tap1, flick1 = group1
		tap2, flick2 = group2
		tap2[:x] += 1
		assert_equal tap1[:x] + 1, tap2[:x]

		group3 = chart.tip_point_drop do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		group4 = chart.duplicate group3
		assert_equal events, [*group1, *group2, *group3, *group4]
		tap3, flick3 = group3
		tap4, flick4 = group4
		assert_equal tap3[:tip_point], flick3[:tip_point]
		assert_equal tap4[:tip_point], flick4[:tip_point]
		assert_operator tap3[:tip_point], :!=, tap4[:tip_point]
	end

end
