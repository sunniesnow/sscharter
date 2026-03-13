# frozen_string_literal: true

Integer.alias_method :/, :quo
include Math

Sunniesnow::Charter.open 'special' do

title '４２２'
artist 'flicknote'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '422'

offset 1.0
bpm 188

@last_events = []

#==========
# Intro
#==========
tp_drop 0, 12, 1, preserve_beat: false do
	t -4, -4; b 1/12
	t 2, -4; b 1/12
	t 6, -4; b 5/6
end
tp_chain 0, 12, 1 do
	t -8, -4; b 1
	t -6, 0; b 1
	t -2, 1; b 1
	t 2, 2; b 1

	t 6, 4; b 3
end
tp_drop 0, 12, 1 do
	t 2, -4; b 1/2
	t -4, -4; b 1/2

	b 1/12
	t -2, -4; b 1/12
	t 6, -4; b 11/6
	t -2, -4; b -2
end
tp_chain 0, 12, 1 do
	t -8, -4; b 1
	t -6, -2; b 1
	t -3, 0; b 1
	t 0, 3; b 1

	t 4, 4; b 2
	t 7, -1; b -2
end
tp_drop 0, 12, 1 do
	t 3, -4; b 2
	t 8, -4; b 2-1/8
	t -2, -4; b 1/8-1/12
	t 2, -4; b 1/12

	t 6, -4
end
tp_chain 0, 12, 1, preserve_beat: false do
	t -6, -4; b 1
	t -7, -1; b 1
	t -2, 0; b 1
	t -3, 3; b 1

	t -7, 4; b 1
	t -8, 1; b 1
	t -4, 0; b 1
	t 0, -2; b 1
end

b 1
t 3, -2; b 1
t 4, 1; b 1+1/16
t 6, 3; b 1-1/16

b 1/24
t 8, 4; b 2-1/24
t 4, 1; b 2

tp_drop 0, 8, 1 do
	t 8, -4
	24.times do |i|
		prog = i/24
		x1, x2, y = -4-prog**2*4, 4+(1-(1-prog)**2)*4, -4+prog**1.5*8
		x = x1 + (x2-x1)*(i%4)/4
		t x2, y if i%4 == 0
		t x, y; b 1/4
	end
end
tp_drop 0, -8, 1 do
	cur = 0
	([1/4]*4 + [1/6]*6).each do |delta_beat|
		prog = cur/2
		x1, x2 = 1+4*(prog-1/2)**2, -12+prog*2
		y = 4 - prog**1.5*8
		x = x1 + (x2-x1)*(cur%(1/2)*2)
		t 8, y-1 if cur%(1/2) == 0
		t x, y; b delta_beat
		cur += delta_beat
	end
end

#==========
# Theme 1
#==========
group preserve_beat: false do
	2.times do |i|
		bg_note -2, 4, 14, 'Eve'; b 1
		bg_note 0, 4, 13, 'ry'; b 1
		bg_note 2, 4, 12, 'time'; b 2
		bg_note -3, -4, 10, 'that'; b 1
		bg_note -1, -4, 9, 'I'; b 1
		bg_note 1, -4, 8, 'see'; b 2
		bg_note 3, -4, 6, 'you'; b 24
	end
end
tp_drop 0, 16, 1 do
	f -1, -4, :ul; f 3, -4, :ul
end
def pattern second = false; group do
tp_drop 0, 16, 1 do
	tp_chain do
		4.times do |i|
			x, y = 8-(i/4)**2*8, -4+i
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
		t -3.3, -1.1; b 1/6
		t -0.0, -0.1; b 1/6
		t 3.6, 0.4; b 1/6
		t -5.7, 0.4; b 1/6
		t -2.6, 1.3; b 1/12
		t 1.0, 1.9; b 1/12
		t 5.3, 2.1; b 1/6
	end
end
def pattern2 second = false; group do
	tp_chain -8, 0, 1 do
		8.times do |i|
			angle = PI/2 - PI*i/8
			x, y = -7+14*cos(angle), 3*sin(angle)
			i.zero? ? f(x, y, :r) : d(x, y); b 1/4
		end
	end
	tp_chain 0, -8, 1 do
		b -1/2
		t 3.8, 3.2; b 1/2

		f 6.4, 3.9, :r; b 1/4
	end
	tp_drop 8, -8, 1 do
		(-1..6).each do |i|
			x, y = -6 + 3/2 * (i/6-1/2)**2*4 - 2*(-1)**i, 3-i
			t x, y if second || i != -1; b 1/4 unless i == 6
		end
	end
	tp_drop -8, 8, 1 do
		9.times do |i|
			x, y = 6 - 2 * (i/6-1/2)**2*4 + 2*(-1)**i, -4+i
			t x, y; b 1/4 unless i == 8
		end
	end
end; end
pattern2

notes1 = tp_chain 0, 12, 1 do
	t 0.2, -3.9; b 1/4
	t -3.4, -3.2; b 1/4
	t 1.1, -2.1; b 1/4
	t -2.3, -1.3; b 1/4
	t 3.3, -1.1; b 1/6
	t 0.0, -0.1; b 1/6
	t -3.6, 0.4; b 1/6
	t 5.7, 0.4; b 1/6
	t 2.6, 1.3; b 1/12
	t -1.0, 1.9; b 1/12
	t -5.3, 2.1; b 1/6
end
transform pattern2 true do
	horizontal_flip
end
next if second

transform duplicate notes1 do
	beat_translate 8
	horizontal_flip
end
b 2
tp_chain -8, 0, 1 do
	9.times do |i|
		angle = PI/2 - PI*i/8
		x, y = -7+14*cos(angle), 3*sin(angle)
		case i
		when 0 then f(x, y, :r); b 1/4
		when 8 then t(x, y)
		else d(x, y); b 1/4
		end
	end
end
tp_chain 0, -8, 1 do
	b -1
	t 1, 4; b 1/2
	t 5, 3; b 1/2
end

notes = tp_chain 8, 0, 1 do
	5.times do |i|
		x, y = 6 + 2*(-1)**i - 2*(i/4)**2, 1-i
		t x, y; b 1/4 unless i == 4
	end
end
transform duplicate notes do
	beat_translate 1
	horizontal_flip
	translate 0, -1
end
transform duplicate notes do
	beat_translate 2
	translate -2, 3
end
transform duplicate notes do
	beat_translate 3
	horizontal_flip
	translate 2, 2
end
b 3
end; end
pattern

tp_drop 0, 16, 1 do
	[
		5, 3, 2, 4,
		1, 2, 3, 1,
		[0,5], 4, 1, 2,
		4, 3, 1, 2
	].each do |positions|
		positions = [positions] unless positions.is_a? Array
		positions.each do |pos|
			t -8 + pos/5*16, -4
		end
		b 1/4
	end
end

tp_drop 0, 16, 1 do
	[
		[0, 6], *(1..6), *(1..5), [0, 6], *(1..6), *(1..5)
	].each do |positions|
		positions = [positions] unless positions.is_a? Array
		positions.each do |pos|
			t 8 - pos/6*16, -4
		end
		b 1/6
	end
	f 8/3, -4, :ur; f 8, -4, :ur
end

transform(pattern true) { horizontal_flip }

group preserve_beat: false do
	hexagon 1/2; b 4
	hexagon 1/2; b 4
	hexagon 1/2; b 3/2
	hexagon 1/2; b 5/2
	turntable 1/2; b 2
	turntable 1/2; b 2
end
def pattern x0, y0, reverse = false, counts = [2, 2], last = false
	s = reverse ? -1 : 1
	tp_chain -s*8, 0, 1 do
		cur = 0
		counts.each do |count|
			count.times do |i|
				x, y = x0 + s*(2*(1-(1-cur)**2) + (i-(count-1)/2)*8/count), y0 + cur*4
				t x, y; b 1/2/count
				cur += 1/2/count
			end
		end
		x, y = x0 + s*(2-(counts.last-1)*4/counts.last), y0 + 4
		if last
			tp_drop -8*s, 8, 1 do
				t x, y
			end
		else
			t x, y
		end
	end
end
tp_chain -8, 0, 1 do
	5.times do |i|
		x, y = -7 + 2*(1-(1-i/4)**2), -4 + i
		i==0 || i==4 ? t(x, y) : d(x, y); b 1/4 if i != 4
	end
end
pattern 4, -3, true
pattern -6, 0
pattern 5, -1, true

pattern -4, -4
pattern 6, -3, true
pattern -5, -1
pattern 5, 0, true

notes = group do
	pattern -5, -1
	pattern 5, 0, true
	pattern -4, -4
	pattern 6, -3, true, [2, 3]

	pattern -5, 0, false, [3, 3]
	pattern 5, -1, true
	pattern -5, -4, false, [3, 3]
	pattern 6, -4, true, [2, 2], true
end
transform(notes) { vertical_flip }

#==========
# Interlude 1
#==========
grid 30
tp_drop 8, -8, 1, preserve_beat: false do
	16.times do |i|
		t 6, 0 unless i.zero?; b 1/2
		t 4, -2; b 1/2
	end
end
f -4, 4, :dr
t -8, 4; b 1/16
d -7, 3; b 1/6-1/16
d -6, 2; b 5/6
t -2, 1; b 1/2
t -4, 0; b 1/2
d -5, -2; b 1/2
t -4, -4; b 1/2
d -2, -3; b 1/2
t 0, -2; b 1/2

d 1, 0; b 1/2
t 2, 2; b 1
t -2, 4; b 1
t -1, 0; b 1/2
d -3, -1; b 1/2
d -4, 1; b 1/4
d -5, 2; b 1/4

f -6, 3, :l; b 1/2
d -8, 2; b 1/2
t -7, 0; b 1/2
t -5, -1; b 1
t -1, 0; b 1/2
d -3, -1; b 1/2
t -2, -3; b 1/2

d 0, -2; b 1/2
t 1, 0; b 1/2
t 2, 2; b 1/2
t 1, 4; b 1/2
t -1, 3; b 1/2
t -3, 4; b 1/2
t -5, 3; b 1/2
t -7, 2; b 1/2

tp_drop -8, -8, 1, preserve_beat: false do
	16.times do |i|
		t -6, 0; b 1/2 unless i == 14 || i == 15
		note = t -4, -2; b 1/2
		@last_events.push note if i == 14 || i == 15
	end
end
t 6, 0; b 1/2
d 4, 1; b 1/2
t 2, 2; b 1/2
t 0, 1; b 1
t 2, -3; b 1
t 6, -4; b 1/2

b 1/2
t 8, -1; b 1/4
t 6, 0; b 1/4
t 8, 1; b 1/2
t 4, 2; b 1
t -1, 4; b 1/2
t 1, 3; b 1/2
t 3, 2; b 1/2

f 5, 3, :r; b 1/2
d 7, 2; b 1/2
d 8, 0; b 1/2
t 7, -2; b 1/2
d 5, -3; b 1/2
t 3, -4; b 1/2
d 2, -2; b 1/2
t 0, -1; b 1/2

d 1, 1; b 1/2
t 2, 3; b 1/2
t 4, 2; b 1/2
t 6, 1; b 1/2
t 8, 2; b 1/2
t 7, 4; b 3/2

grid 32
tp_drop 8, -8, 1, preserve_beat: false do
	16.times do |i|
		t 6, 0; b 1/2
		t 4, -2; b 1/2
	end
end
f -6, 2, :ur; b 1/2
d -4, 4; b 1/2
d -2, 3; b 1/2
t -1, 1; b 1/2
d -3, 0; b 1/2
d -5, 1; b 1/2
t -6, -1; b 1/2
d -4, -2; b 1/2

d -2, -1; b 1/2
t -1, 1; b 3/2
t 0, -3; b 1/2
d 1, -1; b 1/4
d 2, 0; b 1/4
d 3, 1; b 1/4
d 2, 2; b 1/4
t 1, 3; b 1/2

f -1, 2, :l; b 1/2
d -3, 3; b 1/2
d -5, 2; b 1/2
t -7, 3; b 1
t -4, 4; b 1/2
t -3, 2; b 1/2
t -4, 0; b 1/2

b 1/2
t -8, -3; b 1/2
8.times do |i|
	t -3-(-1)**i, -4+i; b 1/4
end
4.times do |i|
	t -5-(-1)**i, 4-i; b 1/4
end

tp_drop -8, -8, 1, preserve_beat: false do
	16.times do |i|
		t -6, 0; b 1/2
		t -4, -2; b 1/2
	end
end
def pattern reverse_start = false; group do
	t 2, reverse_start ? 2 : -2; b 1/2
	t 0, 0; b 1/2
	t -2, 2; b 1/4
	t -4, 1; b 1/4
	t -2, 0; b 1/4
	t -4, -1; b 1/4
end; end
notes = group do
	pattern
	transform(pattern) { horizontal_flip }
end
transform(notes) { translate 4, 2 }

notes = group do
	pattern true
	transform(pattern) { horizontal_flip }
end
transform(notes) { translate 4, -2 }

4.times do |i|
	notes = group do
		i.zero? ? f(4, -4, :l) : d(4, -4); b 1/4
		d 2, -4; b 1/4
		d 0, -4; b 1/4
		d -2, -4; b 1/4
	end
	transform(notes) do
		rotate -PI/2*i
		translate 2, 0
	end
end

t 6, -4; b 3/4
t 5, 0; b 3/4
t 1, -1; b 1/2
t 0, 1; b 1
t 4, 2; b 1

#==========
# Interlude 2
#==========
(-8..8).step(1/2) do |x|
	bg_note x, -4, 48
end
notes = group do
group preserve_beat: false do
	b 2
	bg_note -3, 4, 14, 'I'; b 2
	bg_note -1, 4, 12, 'do'; b 1
	bg_note 1, 4, 11, "n't"; b 1
	bg_note 3, 4, 10, 'know'; b 2
	bg_note -2, 2, 8, 'what'; b 1
	bg_note 0, 2, 7, 'to'; b 1
	bg_note 2, 2, 6, 'say'
end
tp_drop 0, 16, 1, preserve_beat: false do
	f 2, -4, :ur
	f 8, -4, :ur; b 4
	mark :piano
end
tp_drop 12, 0, 1, preserve_beat: false do
	t -8, 3; b 3/2
	t -8, -1; b 5/2
	mark :kick
end
tp_drop -12, 0, 1 do
	b 2
	t 8, 2; b 2
	mark :snare
end

at :piano, update_mark: true do
	b 4
end
at :kick, update_mark: true do
	b 3/2
	t -8, 2; b 3/2
	t -8, -2; b 1
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, 0; b 2
end

at :piano, update_mark: true do
	d -5, -4; d -2, -4; d 6, -4; b 1/4
	d 3, -4; b 1/4
	d -1, -4; b 1/4
	d -4, -4; b 1/4
	d 7, -4; b 1/4
	d 4, -4; b 1/4
	d 1, -4; b 1/4
	d -2, -4; b 1/4
	d -5, -4; d 2, -4; d 6, -4; b 1/2
	d 3, -4; b 1/4
	d 0, -4; b 1/4
	d -3, -4; b 1/6
	d -1, -4; b 1/6
	d 1, -4; b 1/6
	d 3, -4; b 1/6
	d 5, -4; b 1/6
	d 7, -4; b 1/6
end
at :kick, update_mark: true do
	t -8, 3; b 3/2
	t -8, -2; b 5/2
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, 1; b 2
end

at :piano, update_mark: true do
	d -7, -4; d -4, -4; d 0, -4; d 4, -4; b 2
	d -3, -4; d 1, -4; d 3, -4; d 7, -4; b 2
end
at :kick, update_mark: true do
	b 1
	t -8, 3; b 3/2
	t -8, -2; b 1
	t -8, 1; b 1/2
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, -1; b 2
end

group preserve_beat: false do
	b 2
	bg_note -3, 4, 14, 'I'; b 2
	bg_note -1, 4, 12, 'do'; b 1
	bg_note 1, 4, 11, "n't"; b 1
	bg_note 3, 4, 10, 'know'; b 2
	bg_note -2, 2, 8, 'what'; b 1
	bg_note 0, 2, 7, 'to'; b 1
	bg_note 2, 2, 6, 'think'
end
at :piano, update_mark: true do
	d -7, -4; d -2, -4; d 2, -4; d 6, -4; b 4
end
tp_drop -12, 0, 1, preserve_beat: false do
	t 8, -2; b 3/2
	t 8, 2; b 5/2
	mark :kick
end
tp_drop 12, 0, 1 do
	b 2
	t -8, 0; b 2
	mark :snare
end

at :piano, update_mark: true do
	b 4
end
at :kick, update_mark: true do
	b 1
	t 8, -3; b 2
	t 8, 1; b 1
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t -8, 2; b 2
end

at :piano, update_mark: true do
	d -5, -4; d -2, -4; d 6, -4; b 2
	d -3, -4; d 1, -4; d 4, -4; d 7, -4; b 2
end
at :kick, update_mark: true do
	t 8, 3; b 3/2
	t 8, -1; b 5/2
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t -8, 1; b 2
end

at :piano, update_mark: true do
	d -7, -4; d -4, -4; d 0, -4; d 4, -4; b 2
	d -5, -4; d -1, -4; d 2, -4; d 5, -4; b 2
end
at :kick, update_mark: true do
	b 1/2
	t 8, -2; b 1
	t 8, 3; b 3/2
	t 8, -3; b 1/2
	t 8, 2; b 1/4
	t 8, 0; b 1/4
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t -8, 1; b 2
end

group preserve_beat: false do
	b 2
	bg_note -2, 4, 10, 'What'; b 2
	bg_note 0, 4, 8, 'made'; b 2
	bg_note 2, 4, 6, 'me'; b 2
	bg_note -2, 2, 4, 'feel'; b 1
	bg_note 0, 2, 3, 'this'; b 1
	bg_note 2, 2, 2, 'way'
end
at :piano, update_mark: true do
	d -7, -4; d -2, -4; d 3, -4; d 7, -4; b 4
end
tp_drop 12, 0, 1, preserve_beat: false do
	t -8, -1; b 3/2
	t -8, 1; b 5/2
	mark :kick
end
tp_drop -12, 0, 1 do
	b 2
	t 8, 2; b 2
	mark :snare
end

at :piano, update_mark: true do
	b 4
end
at :kick, update_mark: true do
	b 1/2
	t -8, 3; b 1/2
	t -8, -2; b 3/2
	t -8, 1; b 3/2
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, 0; b 2
end

at :piano, update_mark: true do
	d -7, -4; d -3, -4; d 1, -4; d 5, -4; b 1/2
	d -5, -4; b 1/4
	d -1, -4; b 1/4
	d 7, -4; b 1/4
	d -6, -4; b 1/4
	d -2, -4; b 1/4
	d 2, -4; b 1/4
	d 6, -4; b 1/4
	d -7, -4; b 1/4
	d -4, -4; b 1/4
	d 0, -4; b 1/4
	d 4, -4; b 1/4
	d 7, -4; b 1/4
	d -5, -4; b 1/6
	d -2, -4; b 1/6
	d 1, -4; b 1/6
end
at :kick, update_mark: true do
	t -8, 2; b 3/2
	t -8, -1; b 5/2
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, 3; b 2
end

at :piano, update_mark: true do
	d -6, -4; d -3, -4; d 3, -4; d 6, -4; b 2
	d -7, -4; d -3, -4; d 1, -4; b 1
	d -5, -4; d -1, -4; d 2, -4; d 4, -4; b 1
end
at :kick, update_mark: true do
	b 1/2
	t -8, 3; b 1
	t -8, -2; b 3/2
	t -8, 1; b 1
end
at :snare, update_mark: true, preserve_beat: true do
	b 2
	t 8, 0; b 2
end

diamond_grid 17
group preserve_beat: false do
	b -2
	bg_note -4.5, 4, 22, 'What'; b 1
	bg_note -3, 4, 21, 'is'; b 1
	bg_note -1.5, 4, 20, 'go'; b 4
	bg_note 0, 4, 16, 'ing'; b 4
	bg_note 1.5, 4, 12, 'on'; b 4
	bg_note 3, 4, 8, 'my'; b 4
	bg_note 4.5, 4, 4, 'mind'; b 4
end
at :piano do
	d -7, -4; d -2, -4; d 4, -4; d 7, -4
end
end
current_beat = b
notes.each do |note|
	next unless %i[drag flick].include? note.type
	b! note.beat
	(1..3).each do |i|
		bg_note note[:x], note[:y] + i, 1-i/3
	end
end
b! current_beat

group preserve_beat: false do
	6.times do |i|
		x = -7 + i/5*14
		y = [3, 2, 1, 1, 2, 3][i]
		tp_drop 0, 8, 1, preserve_beat: false do
			h x, y, 4*(6-i)-2
			if i.zero?
				tp_none { d x, y }
			else
				tp_none do
					4.times do |j|
						d x+cos(PI/2*j), y+sin(PI/2*j)
					end
				end
			end
			b 4*(6-i)-2+i/6
			t x, y; b 1
			t x*5/6, y*1/2
		end
		8.times do |j|
			x1, y1 = x + cos(2*PI*j/8), y + sin(2*PI*j/8)
			bg_note x1, y1
		end
		b 4
	end
end
tp_drop 0, -8, 1, preserve_beat: false do
	cur = 0
	([1]*22 + [3/4, 1/4, 1/2, 1/4, 1/4, 0]).each do |delta_beat|
		x, y = 0, 4 - 8*(1-(1-cur/24)**3)
		if cur >= 22
			d x, y
		else
			t x, y
			d x, y if cur % 4 == 2
		end
		b delta_beat
		cur += delta_beat
	end
end

tp_chain -8, 0, 1 do
	b 5/2
	t -7.1, -3.5; b 1/2
	t -5.8, -1.8; b 1/2
	t -4.9, 0.2; b 1/2

	d -4.2, 2.0
end
tp_chain -8, 0, 1 do
	b 2
	9.times do |i|
		angle = 2*PI*i/8
		x, y = -6 + 2.6*cos(angle) + 2*i/8, -2 + 3.1*sin(angle) + 3*i/8
		i.zero? ? t(x, y) : d(x, y); b 1/4 unless i == 8
	end
end

tp_chain 8, 0, 1 do
	17.times do |i|
		next b 1/4 if i.zero?
		prog = i/16
		x, y = 7*(2-sqrt(1+12*(prog-1/2)**2)) + 1.4*prog, -2+2*sin(PI+7/2*PI*prog)+prog
		d x, y; b 1/4 unless i == 16
	end
end

tp_chain 8, 0, 1 do
	cur = 0
	([1/2]*3 + [1/4]*10 + [0]).each do |delta_beat|
		prog = cur/4
		if prog > 0
			angle = PI/2 + prog*2*PI
			x, y = 1.4 + 2.4*cos(angle) + 2.8*prog, -1 + 2.4*sin(angle) + 0.6*prog
			d x, y
		end
		b delta_beat
		cur += delta_beat
	end
end

tp_chain 8, 0, 1 do
	([1/4]*8 + [1/6]*12 + [0]).each_with_index do |delta_beat, i|
		next b delta_beat if i.zero?
		prog = i/20
		x = 4.2 - 10*(2-sqrt(1+12*(prog-1/2)**2)) + 2.8*prog
		y = -1 + (2+prog)*cos(3*PI*prog) + 7*prog**4
		d x, y; b delta_beat
	end
end

big_text 4, 'Ohh'
b 4

#==========
# Theme 2
#==========
group preserve_beat: false do
	b 2
	bg_note -2, 4, 12, 'Eve'; b 1
	bg_note 0, 4, 11, 'ry'; b 1
	bg_note 2, 4, 10, 'time'; b 2
	bg_note -3, -4, 8, 'that'; b 1
	bg_note -1, -4, 7, 'I'; b 1
	bg_note 1, -4, 6, 'see'; b 2
	bg_note 3, -4, 4, 'you'; b 2
end
tp_drop 0, -8, 1 do
	f -1, 3, :dl
end
tp_drop -8, 0, 1 do
	7.times do |i|
		prog = i/6
		x, y = -6+8*(prog-1/2)**2, 4-8*prog
		case i
		when 0 then f(x, y, :dl); b 1/4
		when 6 then t(x, y)
		else d(x, y); b 1/4
		end
	end
end
tp_drop 8, 0, 1 do
	b -1/2
	t 1.6, 4; b 1/2
	t 7.2, 1.9; b 1/4
	t 4.1, 1.2; b 1/4
	t 1.5, 0.3; b 1/4
	t 5.0, -0.4; b 1/4
end
tp_drop -8, 0, 1 do
	t -2.4, 0.8; b 1/4
	t -5, 0.3; b 1/4
	t -7.6, -0.6
end
tp_drop 8, 0, 1 do
	t 4.9, -4.0; b 1/4
	t 2.1, -3.5; b 1/4
end
tp_chain 0, -8, 1 do
	t -1, -3; b 1/6
	t -2.5, -2; b 1/6
	t -1, -1; b 1/6

	t 0.5, 0
end
tp_drop -8, 0, 1 do
	t -5.8, 4.0; b 1/4
	t -2.3, 3.3; b 1/4
end
tp_drop 8, 0, 1 do
	t 1.2, 2.7; b 1/4
	t 4.3, 2.9; b 1/4
end
tp_drop -8, 0, 1 do
	t -7.9, 2.4; b 1/4
	t -4.5, 1.5; b 1/4
	t -1.1, 1.0
end
tp_drop 8, 0, 1 do
	t 5.7, 1.3; b 1/4
	t 2.5, -0.0; b 1/4
end
tp_drop -8, 0, 1 do
	t -3.4, -0.7; b 1/4
end
tp_drop 8, 0, 1 do
	t 0.1, -1.5; b 1/4
end
tp_drop -8, 0, 1 do
	t -6.6, -2.2; b 1/4
end
tp_drop 8, 0, 1 do
	t 3, -4; b 1/4
	t 7.2, -3.8
end
tp_drop -8, 0, 1 do
	t -8, 3.1; b 1/4
	t -4.6, 2.5; b 1/4
end
tp_chain 0, 8, 1 do
	t -1, 2; b 1/6
	t 0.5, 1; b 1/6
	t -1, 0; b 1/6

	t -2.5, -1
end
tp_drop 8, 0, 1 do
	t 1.8, -1.5; b 1/4
	t 4.6, -0.3; b 1/4
	t 7.8, 0.7; b 1/4
	t 3.9, 1.6; b 1/4
end
tp_drop -8, 0, 1 do
	t -7.9, 0.2; b 1/4
	t -3.0, 0.6; b 1/4
	t -6.6, -2.0
end
tp_drop 8, 0, 1 do
	t 8.0, 3.9; b 1/4
	t 4.0, 3.4; b 1/4
	t 0.4, 2.7; b 1/4
end
tp_drop -8, 0, 1 do
	t -5.1, 2.1; b 1/4
	t -1.3, 1.1; b 1/4
end
tp_drop 8, 0, 1 do
	t 2.6, 0.0; b 1/4
end
tp_drop -8, 0, 1, preserve_beat: false do
	t -7.7, -0.5
end
tp_drop 8, 0, 1 do
	t 7.4, -1.1; b 1/4
	t 4.2, -1.7; b 1/4
end
tp_drop -8, 0, 1 do
	t -2.2, -2.5; b 1/4
end
tp_drop 8, 0, 1 do
	t 3.1, -3.4; b 1/4

	t 7.7, -3.9
end
tp_drop -8, 0, 1 do
	t -7.0, 3.6; b 1/4
	t -3.1, 3.2; b 1/4
end
tp_drop 8, 0, 1 do
	t 0.7, 3.0; b 1/4
	t 4.4, 3.5; b 1/4
end
tp_chain 0, 8, 1 do
	t -1, 1; b 1/6
	t -2.5, 0; b 1/6
	t -1, -1; b 1/6
	t 0.5, -2
end
tp_drop -8, 0, 1 do
	t -6.7, -1.1; b 1/4
	t -3.1, -2.2; b 1/4
end
tp_drop 8, 0, 1 do
	t 8, 2
end
tp_chain 0, -8, 1 do
	6.times do |i|
		t -3+1.5*i, 3-i; b 1/6
	end
	t 3, -3; b 1/4
end
tp_drop 8, 0, 1 do
	t -0.9, -4; b 1/4
end
tp_drop -8, 0, 1 do
	t -6.7, -3.0; b 1/4
	t -3.3, -1.2; b 1/4

	group preserve_beat: false do
		b 1
		bg_note -3, 4, 11, 'Can'; b 1
		bg_note -1, 4, 10, 'not'; b 1
		bg_note 1, 4, 9, 'pro'; b 1
		bg_note 3, 4, 8, 'cess'; b 2
		bg_note -2, -4, 6, 'that'; b 2
		bg_note 0, -4, 4, 'fee'; b 2
		bg_note 2, -4, 2, 'ling'; b 2
	end
	t -8.0, 0.2
end
tp_drop 8, 0, 1 do
	t 7.8, -0.3; b 1/4
end
tp_drop -8, 0, 1 do
	t -4.8, 2.6; b 1/4
end
tp_drop 8, 0, 1 do
	t 0.7, 2.9; b 1/4
	t 4.2, 3.5; b 1/4
end
tp_chain 0, 8, 1 do
	t -1, 1; b 1/6
	t 0.5, 0; b 1/6
	t -1, -1; b 1/6
	t -2.5, -2
end
tp_drop 8, 0, 1 do
	t 7, -4; b 1/4
	t 3, -3; b 1/4
end
tp_drop 0, 8, 1 do
	9.times do |i|
		prog = i/8
		x, y = -4 + 4*((prog-1/3)**2-1/9)*3 + [0,-3,0,3][i%4], -4 + i
		t x, y; b 1/4 unless i==8
	end
end

tp_drop 8, 0, 1 do
	t 5.6, 3.5; b 1/4
end
tp_drop -8, 0, 1 do
	t -1.0, 1.7; b 1/4
end
tp_drop 8, 0, 1 do
	t 2.8, 0.9; b 1/4
end
tp_drop -8, 0, 1 do
	t -3.9, -0.5; b 1/4
end
tp_drop 8, 0, 1 do
	t -0.4, -1.6; b 1/4
	t 4.1, -1.4; b 1/4
	t 7.4, 0.2
end
tp_drop -8, 0, 1 do
	t -7, -4; b 1/4
	t -3, -3; b 1/4
end
tp_drop 0, 8, 1 do
	9.times do |i|
		prog = i/8
		x, y = 4 - 4*((prog-1/3)**2-1/9)*3 + [0,3,0,-3][i%4], -4 + i
		t x, y; b 1/4 unless i==8
	end
end

tp_drop -8, 0, 1 do
	t -6.6, 2.8; b 1/2
	t -3.4, 1.2
end
tp_drop 8, 0, 1 do
	t 5.2, 3.4; b 1/2
	t 7.6, -0.1
end
tp_drop -8, 0, 1 do
	t -1.5, -1.4; b 1/2
	t -2.4, -4.0
end
tp_drop 8, 0, 1 do
	t 6.8, -3.1; b 1/2
end
tp_drop -8, 0, 1 do
	t -7.9, -3.4; b 1/4
	t -4.0, -2.5; b 1/4
end
tp_drop 8, 0, 1 do
	t 1.7, -1.3; b 1/4
end
tp_drop -8, 0, 1 do
	t -6.4, -0.8; b 1/4
	t -1.2, 0.6; b 1/4
end
tp_drop 8, 0, 1 do
	t 2.9, 2.6; b 1/4
end
tp_drop -8, 0, 1 do
	t -7.8, 2.3
	t -3.1, 3.8; b 1/2
end

b 4

grid 16
group preserve_beat: false do
	b 1
	bg_note -2, 4, 11, 'Do'; b 1
	bg_note 0, 4, 10, 'not'; b 1
	bg_note 2, 4, 9, 'know'; b 1
	bg_note -2, -4, 8, 'what'; b 2
	bg_note 0, -4, 6, 'to'; b 2
	bg_note 2, -4, 4, 'do'; b 4
end
tp_drop -8, 0, 1, preserve_beat: false do
	f -4, 4, :l; b 1/2
	t -4, 2; b 1/2
	t -4, 0; b 1/2
	t -4, -2; b 1/2
end
tp_drop 8, 0, 1 do
	f 4, -4, :r; b 3/4
	t 4, -2; b 1/2
	t 4, 0; b 1/2
	t 4, 2; b 1/4
end
notes = tp_drop -8, 0, 1, preserve_beat: false do
	t -4, -4; b 1/2
	t -6, 0; b 1/2
	t -4, 4
end
transform(duplicate notes) { rotate PI }
tp_chain 0, -8, 1 do
	b 1/4
	t 0, -2; b 1/2
	t 0, 2; b 1/4
end
tp_chain 0, -8, 1 do
	b 1/4
	d 2, -2; b 1/4
	d 0, 0; b 1/4
	d 2, 2; b 1/4
end

tp_drop 8, 0, 1, preserve_beat: false do
	t 4, 4; b 1/2
	t 4, 2; b 1/2
	t 4, 0; b 1/2
	t 2, -2; b 1/6
	tp_chain 0, 8, 1 do
		t 0, 0; b 1/3
	end
end
tp_drop -8, 0, 1 do
	t -4, -4; b 3/4
	t -4, -2; b 1/2
	t -4, 0; b 1/4+1/3
	t -2, 2; b 1/6
end
notes = tp_drop 8, 0, 1, preserve_beat: false do
	t 4, -4; b 1/2
	t 6, 0; b 1/2
	t 4, 4
end
transform(duplicate notes) { rotate PI }
tp_chain 0, -8, 1 do
	b 1/4
	t 0, -2; b 1/2
	t 0, 2; b 1/4
end
tp_chain 0, -8, 1 do
	b 1/4
	d -2, -2; b 1/4
	d 0, 0; b 1/4
	d -2, 2; b 1/4
end

tp_drop -8, 0, 1, preserve_beat: false do
	t -4, 4; b 1/2
	t -4, 2; b 1/2
	t -4, 0; b 1/2
	t -4, -2; b 1/2
end
tp_drop 8, 0, 1 do
	t 4, -4; b 1/4
	t 3, -3; b 1/2
	t 3, -1; b 1/2
	t 3, 1; b 1/2
	t 3, 3; b 1/4
end
notes = tp_drop 8, 0, 1, preserve_beat: false do
	t 6, 4; b 1/2
	t 7, 2; b 1/2
	t 8, 0; b 1/2
	t 7, -2; b 1/2
	t 6, -4
end
transform(duplicate notes) { rotate PI }

tp_chain 0, -8, 1 do
	b 1/4
	t 0, -3; b 1/2
	t 0, -1; b 1/2
	t 0, 1; b 1/2
	t 0, 3; b 1/4
end
tp_drop 8, 0, 1, preserve_beat: false do
	b 1/4
	t 2, -3; b 1/2
	t 2, -1; b 1/4+1/3
	t 2, 2; b 1/6
end
tp_drop -8, 0, 1 do
	b 1/2
	t -2, -2; b 1/2
	t -2, 0; b 1/6
	tp_chain 0, -8, 1 do
		t 0, 1; b 1/3
	end
end
notes = tp_drop 8, 0, 1 do
	t 4, 3; b 3/4
end
transform(duplicate notes) { rotate PI }
tp_drop 0, 8, 1 do
	t 3, -2; b 1/4
	t 0, -1; b 1/4
	t -3, 0; b 1/4
	t 2, 0; b 1/6
	t 0, 1; b 1/6
	t -2, 2; b 1/6
	t 2, 2; b 1/6
	t 0, 3; b 1/6
	t -2, 4; b 1/6
end

group preserve_beat: false do
	b 1
	big_text 4+1/2, '422'
	bg_note -5, 4, 13, 'Four'; b 1
	bg_note -3, 4, 12, 'hun'; b 1
	bg_note -1, 4, 11, 'dred'; b 1
	bg_note 1, 4, 10, 'twen'; b 3/2
	bg_note 3, 4, 7+3/2, 'ty'; b 3/2
	bg_note 5, 4, 7, 'two'; b 1
end
tp_drop -8, 0, 1 do
	t -4, 3
end
tp_drop 8, 0, 1 do
	t 4, 3; b 1/4
	t 2.9, 1.6; b 1/4
end
tp_drop -8, 0, 1 do
	t -2.5, 0.1; b 1/4
end
tp_drop 8, 0, 1 do
	t 1.7, -0.7; b 1/4
end
tp_drop -8, 0, 1 do
	t -0.3, -2.2; b 1/4
	t 2.3, -3.2; b 1/4
end
tp_drop 8, 0, 1 do
	t 5.1, -3.8; b 1/4
	t 7.9, -3.4; b 1/4
end
notes = group do
	tp_chain 0, 100, 1, preserve_beat: false do
		t -70.1, 27.3; b 1/4
		d -81.1, 10.0; b 1/4
		t -87.4, -14.9; b 1/4
		d -61.3, -8.6; b 1/4
		t -36.7, -12.1; b 1/4
	end
	tp_chain 0, 100, 1 do
		t -42.1, 39.6; b 1/2
		t -49.9, 11.9; b 1/2
		t -69.1, -33.8; b 1/4
	end
	(1..3).each do |i|
		x, y = -36.7+(45.3+36.7)*i/4, -12.1+(33.6+12.1)*i/4
		d x, y; b 1/4
	end

	tp_chain 100, 0, 1, preserve_beat: false do
		t -12.8, 31.4; b 1/4
		d 4.9, 42.8; b 1/4+1/6
		t 16.2, 19.5; b 1/3
		t -3.9, -3.2; b 1/3
		t -25.7, -18.4; b 1/6
		f 20.0, -28.7, :r; b 3/2
	end
	tp_chain 100, 0, 1 do
		t 45.3, 33.6; b 1/2
		t 75.4, 38.4; b 1/3
		t 62.2, 1.2; b 1/3
		t 34.8, -19.3; b 1/3
		f 80.8, -29.4, :r; b 3/2
	end
end
transform notes do
	scale 1/12.5
end

grid 15/2
tp_drop 0, 14, 1 do
	t -7, -4; t -3, -4; t 3, -4; t 7, -4; b 1/4
	6.times do |i|
		t 5-i*2, -4; b 1/4
		t 7-i*2, -4; b 1/4
	end
	5.times do |i|
		t -5+i*2, -4; b 1/4
		t -1+i*2, -4; b 1/4
	end
	t 5, -4; b 1/4
	t 7, -4; b 1/4
	t 3, -4; b 1/4
	t 5, -4; b 1/6
	t 1, -4; b 1/6
	t 3, -4; b 1/6
	t -1, -4; t 1, -4; t -5, -4; t 5, -4; b 1/2
end
f -3, -2, :ul; f -6, -3, :ul
f 3, -2, :ur; f 6, -3, :ur; b 3/2

#==========
# Finale
#==========
finale1 = group do
tp_drop 0, 8, 1 do
	t -2.0, -3.8; b 1/4
	t 0.9, -2.8; b 1/4
	t 3.7, -2.0; b 1/4
	t 6.7, -1.6; b 1/4
	t -4.1, -1.5; b 1/4
	t -1.6, -0.3; b 1/4
	t 2.1, 0.6; b 1/4
	t 5.0, 0.8; b 1/4
	t -1.4, 1.4; b 1/6
	t 0.5, 1.8; b 1/6
	t 2.2, 1.8; b 1/6
	t 3.9, 1.7; b 1/4
	t -4.1, 2.1; b 1/4
	t -7.3, 2.2; b 1/4
	t -4.9, 3.5; b 1/4
	t -0.7, 3.4; b 1/4
	t 2.7, 3.2; b 1/4
end

tp_drop 0, -8, 1 do
	t 5.9, 2.0; b 1/4
	t 2.4, 1.1; b 1/4
	t -3.5, 0.0; b 1/6
	t -1.6, 0.2; b 1/6
	t 0.0, -0.1; b 1/6
	t 1.6, -0.6; b 1/4
	t -6.8, -1.4; b 1/4
	t -3.4, -1.2; b 1/4
	t -0.3, -1.5; b 1/4
	t 3.7, -2.8; b 1/6
	t 2.0, -3.3; b 1/6
	t 0.0, -3.3; b 1/6
	t -1.9, -3.0; b 1/4
	t 3.6, -0.3; b 1/4
	t 6.8, 0.8; b 1/6
	t 5.0, 1.2; b 1/6
	t 3.2, 1.2; b 1/6
	t 1.2, 0.9; b 1/4
	t -3.3, 1.6; b 1/4
end

tp_drop 0, 8, 1 do
	t -6.8, 2.9; b 1/4
	t -3.4, 3.1; b 1/4
	t -0.3, 2.8; b 1/4
	t 2.5, 3.6; b 1/4
	t -4.8, 0.7; b 1/4
	t -1.4, 0.4; b 1/4
	t 1.9, 1.3; b 1/4
	t 5.2, 2.2; b 1/4
	t 2.8, -0.2; b 1/4
	t -0.3, -0.7; b 1/4
	t -4.1, -1.5; b 1/6
	t -2, -1.7; b 1/12
	t -0.8, -2.1; b 1/12
	t 0.5, -1.7; b 1/6
	t 2.4, -1.5; b 1/4
	t -6.8, -3.0; b 1/4
	t -3.6, -3.7; b 1/4
	t -0.1, -3.6; b 1/4
end

tp_drop 0, -8, 1 do
	t 4.3, -2; b 1/4
	t 0.8, -0.6; b 1/4
	t -2.1, -0.6; b 1/4
	t -5.6, -1.1; b 1/4
	t 6.9, 0.3; b 1/4
	t 3.3, 1.0; b 1/4
	t -0.4, 1.0; b 1/4
	t -3.9, 0.6; b 1/4
	t 4.4, 3.0; b 1/6
	t 2.4, 3.2; b 1/6
	t 0.5, 3.1; b 1/6
	t -1.3, 2.7; b 1/4
	t 4.2, 1.2; b 1/4
	t 8.0, 0.8; b 1/4
	t 3.1, -0.5; b 1/4
	t -0.8, 0.0; b 1/4
	t -4.7, 1.3; b 1/4
end

tp_drop 0, 8, 1 do
	t 5.6, -1.7; b 1/4
	t 1.2, -2.2; b 1/4
	t -1.8, -2.4; b 1/4
	t -5.5, -3.0; b 1/4
	t 7.4, -3.8; b 1/4
	t 2.8, -3.6; b 1/4
	t -0.0, -3.0; b 1/4
	t -4.7, -1.9; b 1/4
	t 3.4, -0.9; b 1/4
	t -0.0, -0.9; b 1/4
	t -3.3, -0.5; b 1/4
	t -6.9, 0.3; b 1/4
	t 6.9, 1.3; b 1/4
	t 2.2, 0.3; b 1/4
	t -1.4, 0.5; b 1/4
	t -4.5, 0.9; b 1/4
end

tp_drop 0, -8, 1 do
	t -0.1, 2.2; b 1/6
	t 1.6, 2.6; b 1/6
	t 3.3, 2.8; b 1/6
	t 5.1, 2.6; b 1/4
	t -3.5, 1.8; b 1/4
	t -6.3, 1.6; b 1/4
	t -3.0, 0.4; b 1/4
	t 0.5, 0.2; b 1/4
	t 4.4, 1.0; b 1/4
	t -5.1, -0.7; b 1/4
	t -1.2, -1.2; b 1/4
	t 3.0, -1.5; b 1/4
	t 6.3, -1.5; b 1/4
	t -3.1, -2.3; b 1/4
	t 1.2, -2.8; b 1/4
	t 4.3, -3.1; b 1/4
	t 7.9, -2.9; b 1/4
end

tp_drop 0, 8, 1 do
	t 0.9, -1.1; b 1/4
	t 4.9, -0.4; b 1/4
	t -0.8, 0.1; b 1/6
	t 0.9, 0.4; b 1/12
	t 2.2, 0.6; b 1/12
	t 3.3, 1.0; b 1/6
	t 4.7, 1.7; b 1/4
	t -3.3, 1.3; b 1/4
	t -0.9, 2.6; b 1/6
	t -2.5, 3.0; b 1/12
	t -3.6, 3.2; b 1/12
	t -4.7, 3.1; b 1/6
	t -6.5, 2.9; b 1/4
	t 4.4, 1.8; b 1/4
	t 1.4, 2.3; b 1/6
	t 2.9, 3.1; b 1/12
	t 4.2, 3.6; b 1/12
	t 5.6, 3.6; b 1/6
	t 7.5, 3.4; b 1/4
	t -5.4, 1.9; b 1/4
	t -1.8, 1.0; b 1/4
	t 1.5, 0.4; b 1/4
end

tp_drop 0, -8, 1 do
	t 5.7, 0.6; b 1/4
	t 2.8, -0.8; b 1/4
	t -1.2, -2.5; b 1/6
	t 0.4, -3.1; b 1/12
	t 1.6, -3.3; b 1/12
	t 3.0, -3.1; b 1/6
	t 4.4, -2.6; b 1/4
	t -6.5, -1.2; b 1/4
	t -2.8, -0.8; b 1/4
	t 0.8, 0.2; b 1/4
end
end
current_beat = beat
finale1_start = finale1.find { %i[tap flick].include? _1.type }.beat
finale1.each do |note|
	next unless %i[tap flick].include? note.type
	next unless note.beat % 1 == 0 || note.beat - finale1_start == 31/2
	b! note.beat
	x, y = -8*(note[:x]<=>0), note[:y]
	tp_drop(x, 0, 1) { t x, y }; d x, y
end
b! current_beat
def fd x, y, direction
	f x, y, direction
	#tp_none { d x, y }
end
tp_drop(-8, 0, 1) { t -8, 2 }; d -8, 2
tp_drop 0, -8, 1, preserve_beat: false do
	t -4, 2; t 4, 2; b 1/2
	fd -8, 4, :d; fd -3, 4, :d; fd 3, 4, :d; fd 8, 4, :d; b 3/2
end
tp_drop(8, 0, 1) { t 8, 2 }; d 8, 2
b 2

grid 24
def pattern second = false; group do
tp_drop 0, 8, 1 do
	second ? t(-2, 4) : f(-2, 4, :l)
end
tp_drop -8, 8, 1 do
	5.times do |i|
		t 2-2*i, 4-2*i; b 1/4 unless i == 4
	end
end
tp_drop 8, -8, 1 do
	[1/6,1/12,1/12,1/6,1/4].each_with_index do |delta_beat, i|
		t 6-2*i, 4-2*i; b delta_beat
	end
end
tp_drop 0, 8, 1, preserve_beat: false do
	5.times { t 4, -4; b 1/2 }
end
b 1/4
4.times do |i|
	tp_drop(-8, 0, 1) { t -6+2*i, -2+2*i }
	tp_drop(0, -8, 1) { t 2*i, -4+2*i }
	b 1/2
end
end; end
finale2 = group do
pattern

transform(pattern true) { horizontal_flip }

5.times do |i|
	notes = group do
		tp_drop(-8, -8, 1) { t 8, 4-2*i }
		tp_drop(8, -8, 1) { t 2, 4-2*i }
		b 1/4
	end
	transform(notes) { horizontal_flip } if i.odd?
end
tp_chain 0, -8, 1 do
	t 0, 0; b 1/4
	t 0, 2; b 1/4
	t 0, 4; b 1/4
end
tp_drop 0, 8, 1, preserve_beat: false do
	b 1/4
	4.times { t 0, -4; b 1/2 }
end
notes = group do
	tp_drop 8, 8, 1 do
		t 4, 4; b 1/2
		t 6, 2; b 1/2
	end
	tp_drop -8, -8, 1 do
		t 4, 0; b 1/2
		t 6, -2; b 1/2
	end

	tp_drop 8, 8, 1 do
		t 8, -4; b 1/4
	end
end
transform(duplicate notes) { horizontal_flip }
tp_drop 0, 8, 1 do
	t 0, -4; b 1/4
end
tp_drop -8, 8, 1 do
	t -4, -4; b 1/6
	t -2, -2; b 1/12
	t 0, 0; b 1/12
	t 2, 2; b 1/6
	t 4, 4
end
tp_drop 0, -8, 1 do
	t -4, 4; b 1/2
	t 6, 0; t -6, 0; b 1/2
end
notes = group do
	tp_drop -8, 0, 1 do
		t -4, -4
	end
	tp_drop 8, 0, 1 do
		t 4, -4; b 1/4
		t 2, -2; b 1/4
		t 4, 0; b 1/4
		t 2, 2; b 1/4
	end
end
transform(duplicate notes) { rotate PI; beat_translate 1 }
b 1

tp_drop -8, -8, 1 do
	t -4, -4; t 4, -4; b 1/6
	t 0, -2; b 1/6
	t -4, 0; b 1/6
	t -8, 2; b 1/6
end
tp_drop 8, 8, 1 do
	t 8, -4; b 1/12
	t 4, -2; b 1/12
	t 0, 0; b 1/6
	t -4, 2; t 4, 2; b 1/4
end
tp_drop 0, -8, 1 do
	t 2, 4; b 1/4
	t 0, 4; b 1/4
	t -2, 4; b 1/4
end
tp_drop 0, 8, 1, preserve_beat: false do
	b 1/4
	4.times { t 0, -4; b 1/2 }
end
notes = group do
	tp_drop 8, 8, 1 do
		t 4, 4; b 1/2
		t 6, 2; b 1/2
	end
	tp_drop -8, -8, 1 do
		t 4, 0; b 1/2
		t 6, -2; b 1/2
	end
end
transform(duplicate notes) { horizontal_flip }

2.times do |i|
	tp_drop(-8, 0, 1) { t -8, -4+4*i }
	tp_drop(8, 0, 1) { t 8, -4+4*i }; b 1/4
	tp_drop 0, -8, 1 do
		3.times { |j| t -4+4*j, -2+4*i; b 1/4 }
	end
end
4.times do |i|
	tp_drop(-8, 0, 1) { t -6, 4-2*i }
	tp_drop(8, 0, 1) { t 6, 4-2*i }
	tp_drop 0, 8, 1 do
		if i < 2
			b 1/4
			t 0, 0; b 1/4
		else
			b 1/6
			t 2, 0; b 1/6
			t -2, 0; b 1/6
		end
	end
end
end
current_beat = beat
finale2.each do |note|
	next unless %i[tap flick].include? note.type
	next unless note.beat % 4 == 0
	b! note.beat
	d note[:x], note[:y]
end
b! current_beat

def td x, y
	tp_chain(8*(x<=>0), 8, 1) { t x, y }
	tp_chain(8*(x<=>0), -8, 1) { d x, y }
end
notes = group do
	5.times do |i|
		3.times do |j|
			x, y = (8-16/5*j)*(-1)**i, 4-2*i
			j == 2 || true ? td(x, y) : t(x, y)
		end
		b 1/4
	end
	b 1/4
end
transform(duplicate notes) { beat_translate 3/2 }
b 3/2
notes = group do
	td -8, 4; td -8+16/5, 4; b 1/8
	td -8+32/5, 4-8/6; b 3/8
	td -8, 4-16/3; td -8+16/5, 4-16/3; td -8+32/5, 4-16/3; b 1/2
end
transform(duplicate notes) do
	beat_translate 1/4
	horizontal_flip
	translate 0, -8/3
end
notes = group do
	6.times do |i|
		3.times do |j|
			next if i == 5 && j != 2
			x, y = (8-16/5*j)*(-1)**i, 4-8/5*i
			j == 2 || true ? td(x, y) : t(x, y)
		end
		b 1/4
	end
end
transform(duplicate notes) { beat_translate 3/2 }
b 3/2
def td2 x, y
	tp_chain(8, 0, 1) { t x, y }
	tp_chain(-8, 0, 1) { d x, y }
end
4.times do |i|
	4.times do |j|
		x, y = -8+16/3*j, 4-8/3*i
		if [1, 2].include?(j) && (i + j).even? || true
			td(x, y)
		else
			t(x, y)
		end
	end
	b 1/8
	td2 0, 4-8/3*i-4/3 unless i == 3; b 1/8
end

b 4

tp_drop 0, 12, 1 do
	t -4, -4; b 1/16
	t -2, -4; b 1/12-1/16
	t 0, -4; b 1/8-1/12
	t 2, -4; b 1/6-1/8
	t 4, -4; b 5/6+7
end

tp_drop 0, -12, 1 do
	t 3, 4; b 1/6
	t 1, 4; b 1/6
	t -1, 4; b 1/6
	t -3, 4; b 7/2
end

@last_events.each do |note|
	@events.delete note
	@events.push note
end

transform @events do
	scale 12.5
end

check

end
