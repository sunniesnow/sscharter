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
			difficulty_sup 'Test difficulty sup'
		end
		chart = Charter.charts[__method__]
		chart.instance_exec method :assert_equal do |t|
			t.call 'Test Title', @title
			t.call 'Test Artist', @artist
			t.call 'Test Charter', @charter
			t.call 'Test difficulty name', @difficulty_name
			t.call '#521108', @difficulty_color
			t.call 'Test difficulty', @difficulty
			t.call 'Test difficulty sup', @difficulty_sup
		end
	end

	def test_chart_metadata_defaults
		Charter.open __method__ do
		end
		chart = Charter.charts[__method__]
		chart.instance_exec method :assert_equal do |t|
			t.call '', @title
			t.call '', @artist
			t.call '', @charter
			t.call '', @difficulty_name
			t.call '#000000', @difficulty_color
			t.call '', @difficulty
			t.call '', @difficulty_sup
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
		chart.hold (x2 = rand 100), (y2 = rand 100), (duration2 = rand(100) + 1), (text2 = Random.bytes 10)
		chart.drag (x3 = rand 100), (y3 = rand 100)
		chart.flick (x4 = rand 100), (y4 = rand 100), (direction = rand*PI*2), (text4 = Random.bytes 10)
		events = chart.events
		assert_equal events.map(&:type), %i[tap hold drag flick]
		assert_equal events.map { [_1[:x], _1[:y]] }, [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
		assert_equal events.map { _1[:text] }, [text1, text2, nil, text4]
	end

	def test_flick_directions
		chart = Charter.open __method__ do
			offset rand
			bpm rand * 300
		end
		chart.flick (x = rand 100), (y = rand 100), :right
		chart.flick x, y, :down_left
		chart.flick x, y, :u
		chart.flick x, y, :ur
		chart.flick x, y, :l
		chart.flick x, y, :ld
		events = chart.events
		ground_truth = [0, -3*PI/4, PI/2, PI/4, PI, -3*PI/4]
		events.zip ground_truth do |event, true_angle|
			assert_in_delta (event[:angle] - true_angle).modulo(PI*2), 0, 1e-8
		end
	end

	def test_group
		chart = Charter.open __method__ do
			offset rand
			bpm rand * 300
		end
		events = chart.events

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
		events = chart.events

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

		group4 = chart.tip_point_chain (x = rand 100), (y = rand 100), beat_speed: (beat_speed = 90+rand*10) do
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
		events = chart.events

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
		events = chart.events

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
		events = chart.events

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

		group3 = chart.tip_point_chain rand(100), rand(100), rand do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		tip_point3 = group3.first[:tip_point]
		assert_equal group3.map { _1[:tip_point] }, [tip_point3]*3

		group4 = chart.duplicate group3
		assert_equal events, [*group1, *group2, *group3, *group4]
		tip_point4 = group4.first[:tip_point]
		assert_equal group4.map { _1[:tip_point] }, [tip_point4]*3
		assert_operator tip_point3, :!=, tip_point4

		group5 = chart.duplicate group3, new_tip_points: false
		assert_equal events, [*group1, *group2, *group3, *group4, *group5]
		assert_equal group5.map { _1[:tip_point] }, [tip_point3]*2

		group6 = chart.tip_point_drop rand(100), rand(100), rand do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		tip_point6_1, tip_point6_2 = group6.map { _1[:tip_point] }.uniq!
		group7 = chart.duplicate group6, new_tip_points: false
		assert_equal events, [*group1, *group2, *group3, *group4, *group5, *group6, *group7]
		assert_equal group7.map { _1[:tip_point] }, [tip_point6_1, tip_point6_2]
	end

	def test_offset_in_groups
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300
		delta = rand
		events = chart.events

		group1 = chart.group preserve_beat: false do
			t rand(100), rand(100)
			b 1
			offset time_at + delta
			bpm bpm
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		group2 = chart.group do
			t rand(100), rand(100)
			b 1
			offset time_at + delta
			bpm bpm
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		assert_equal events.length, 4
		assert_equal group1[0].time, group2[0].time
		assert_equal group1[1].time, group2[1].time
		assert_in_delta group1[1].time, offset + 60/bpm + delta, 1e-8
	end

	def test_nested_tip_points
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		chain2 = nil
		chain1 = chart.tip_point_chain 0, 0, 0 do
			t rand(100), rand(100)
			b 1
			chain2 = tip_point_chain rand(100), rand(100), 1 do
				t rand(100), rand(100)
				b 1
			end
			t rand(100), rand(100)
			b 1
		end
		assert_equal chain1.length, 5
		assert_equal chain2.length, 2
		assert_equal chain1.map(&:type), %i[tap placeholder tap placeholder tap]
		tp1, tp2, tp3, tp4, tp5 = chain1.map { _1[:tip_point] }
		assert_equal tp1, tp2
		assert_equal tp2, tp5
		assert_equal tp3, tp4
		assert_operator tp1, :!=, tp3
		
		drop1 = nil
		chain3 = chart.tip_point_chain 0, 0, 0 do
			t rand(100), rand(100)
			b 1
			drop1 = tip_point_drop rand(100), rand(100), 1 do
				t rand(100), rand(100)
				b 1
				t rand(100), rand(100)
				b 1
			end
			t rand(100), rand(100)
			b 1
		end
		assert_equal chain3.length, 7
		assert_equal drop1.length, 4
		assert_equal chain3.map(&:type), %i[tap placeholder tap placeholder tap placeholder tap]
		tp1, tp2, tp3, tp4, tp5, tp6, tp7 = chain3.map { _1[:tip_point] }
		assert_equal tp1, tp2
		assert_equal tp2, tp7
		assert_equal tp3, tp4
		assert_equal tp5, tp6
		assert_operator tp1, :!=, tp3
		assert_operator tp3, :!=, tp5
		assert_operator tp1, :!=, tp5

		group1 = nil
		chain4 = chart.tip_point_chain 0, 0, 0 do
			t rand(100), rand(100)
			b 1
			group1 = tip_point_none do
				t rand(100), rand(100)
				b 1
			end
			t rand(100), rand(100)
			b 1
		end
		assert_equal chain4.length, 4
		assert_equal group1.length, 1
		assert_equal chain4.map(&:type), %i[tap placeholder tap tap]
		tp1, tp2, tp3, tp4 = chain4.map { _1[:tip_point] }
		assert_equal tp1, tp2
		assert_equal tp2, tp4
		assert_nil tp3
	end

	def test_bg_note
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		event1 = chart.bg_note x = rand(100), y = rand(100), text = Random.bytes(10)
		assert_equal event1.type, :bg_note
		assert_equal event1[:text], text
		assert_equal event1.duration_beats, 0

		event2 = chart.bg_note x = rand(100), y = rand(100), duration = rand(10) + 1, text = Random.bytes(10)
		assert_equal event2[:text], text
		assert_equal event2.duration_beats, duration

		event3 = chart.bg_note x = rand(100), y = rand(100), duration = rand(10) + 1
		assert_equal event3[:text], ''
		assert_equal event3.duration_beats, duration

		event4 = chart.bg_note x = rand(100), y = rand(100)
		assert_equal event4[:text], ''
		assert_equal event4.duration_beats, 0
	end

	def test_remove
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		group1 = chart.group do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		group2 = chart.group do
			t rand(100), rand(100)
			b 1
			f rand(100), rand(100), rand*PI*2
			b 2
		end
		assert_equal chart.events.length, 4
		chart.remove *group1
		assert_equal chart.events.length, 2
		assert_equal chart.events, group2
	end

	def test_group_nested_in_tip_point_chain
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		group2 = nil
		group1 = chart.tip_point_chain rand, rand, rand do
			group2 = group do
				t rand(100), rand(100)
			end
			t rand(100), rand(100)
		end
		assert_equal chart.events.length, 3
		assert_equal group1.length, 3
		assert_equal group2.length, 1
		assert_equal group1.first, group2.first
	end

	def test_group_nested_in_tip_point_drop
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		group2 = nil
		group1 = chart.tip_point_drop rand, rand, rand do
			group2 = group do
				t rand(100), rand(100)
			end
			t rand(100), rand(100)
		end
		assert_equal chart.events.length, 4
		assert_equal group1.length, 4
		assert_equal group2.length, 2
		assert_equal group1.first(2), group2
	end

	def test_group_nested_in_tip_point_chain_twice
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		group1 = group2 = group3 = note1 = note2 = note3 = nil
		chart.tip_point_chain rand, rand, rand do
			group2 = tp_chain rand, rand, rand do
				group3 = group do
					note3 = t rand(100), rand(100)
				end
				note2 = t rand(100), rand(100)
			end
			group1 = group do
				note1 = t rand(100), rand(100)
			end
		end
		assert_equal chart.events.length, 5
		assert_equal note1[:tip_point], chart.events[4][:tip_point]
		assert_equal note2[:tip_point], note3[:tip_point]
		assert_equal note3[:tip_point], group2[1][:tip_point]
		assert_equal group3, [note3]
		assert_equal group1, [note1]
	end

	def test_remove_and_duplicate
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		group1 = chart.group do
			notes = chart.group do
				t rand(100), rand(100)
				t rand(100), rand(100)
			end
			chart.remove notes.last
		end
		group2 = chart.duplicate group1
		assert_equal chart.events.length, 2
		assert_equal chart.events, [*group1, *group2]
	end

	def test_mark
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		note1 = note2 = current_beat = last_beat = nil
		group1 = chart.tp_chain rand, rand, rand do
			note1 = t rand(100), rand(100)
			last_beat = b 1
			mark :test1
		end
		group2 = chart.at :test1, preserve_beat: true do
			note2 = t rand(100), rand(100)
			current_beat = b 1
		end
		note3 = chart.t rand(100), rand(100)
		assert_equal group1.length, 3
		assert_equal group2, [note2]
		assert_equal note1[:tip_point], note2[:tip_point]
		assert_equal note2.beat, last_beat
		assert_equal note3.beat, current_beat

		note4 = nil
		chart.mark :test2
		group4 = chart.at :test2 do
			note4 = t rand(100), rand(100)
			b 1
		end
		note5 = chart.t rand(100), rand(100)
		assert_equal group4, [note4]
		assert_equal note4.beat, current_beat
		assert_equal note5.beat, current_beat
	end

	def test_mark_and_tp_drop
		chart = Charter.open __method__
		chart.offset offset = rand
		chart.bpm bpm = rand * 300

		note1 = note2 = note3 = nil
		group1 = chart.tp_drop rand, rand, rand do
			note1 = t rand(100), rand(100)
			b 1
			mark :test1
		end
		group2 = chart.at :test1 do
			note2 = t rand(100), rand(100)
			b 1
		end
		group3 = chart.tp_chain rand, rand, rand do
			note3 = t rand(100), rand(100)
			b 1
		end
		assert_equal group1.length, 4
		assert_equal [note1, note2, note3].map { _1[:tip_point] }.uniq.length, 3
	end

end
