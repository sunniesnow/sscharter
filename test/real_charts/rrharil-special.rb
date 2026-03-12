include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title "Rrhar'il"
artist 'Team Grimoire'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '14'
difficulty_sup ?+

offset 1.262
bpm 190

def clock short_angle, long_angle
	4.times do |i|
		angle1 = short_angle - i*PI/24
		angle2 = long_angle - i*PI/8
		0.upto 6 do |j|
			x, y = j/2*cos(angle1), j/2*sin(angle1)
			bg_note x, y
		end
		1.upto 8 do |j|
			x, y = j/2*cos(angle2), j/2*sin(angle2)
			bg_note x, y
		end
		b 2
	end
end
group preserve_beat: false do
	b 2
	clock -PI/6, PI/2
	clock PI/2, -5*PI/6
end

tp_drop -8, 0, 1 do
	t 8, -4
end
t 0, 0
tp_drop 8, 0, 1 do
	[-4, -2, 2, 0].each { |y| t -8, y; b 1/2 }
end
tp_drop -8, 0, 1 do
	[4, 2, 0, -2].each { |y| t 8, y; b 1/2 }
end

tp_drop 8, 0, 1 do
	[4, 0, -2, 0].each { |y| t -8, y; b 1/2 }
end
tp_drop -8, 0, 1 do
	[2, -2, -4, -2].each { |y| t 8, y; b 1/2 }
end

tp_drop 8, 0, 1 do
	t -8, 4
end
tp_drop -8, 0, 1 do
	[4, 2, 0, 2].each { |y| t 8, y; b 1/2 }
end
tp_drop 8, 0, 1 do
	[2, 4, -2, 0].each { |y| t -8, y; b 1/2 }
end

tp_drop -8, 0, 1 do
	[4, -2, 0, 2].each { |y| t 8, y; b 1/2 }
end
tp_drop 8, 0, 1 do
	[-2, -4, -2, 0].each { |y| t -8, y; b 1/2 }
end

note = tp_drop 8, -8, 1 do
	t -5, 4; b 1/2
end
transform(duplicate note) { horizontal_flip }
tp_drop -8, -8, 1 do
	5.times do |i|
		x, y = -3+i*5/2, 1-i/2
		t x, y; b 1/4 if i != 4
	end
end
tp_drop -8, 8, 1 do
	t -7, 0; b 1/2
end
tp_drop 8, 8, 1 do
	5.times do |i|
		x, y = 4-i*5/2, -4+i/2
		t x, y; b 1/4 if i != 4
	end
end
tp_drop -8, 8, 1 do
	t 6, 1; b 1/2
end
tp_drop -8, 0, 1, preserve_beat: false do
	t 3, 4; b 1/4
	t 0, 3; b 1/4
	t 2, 2
end
tp_drop 8, 8, 1 do
	t -7, 3; b 1/2

	f -4, 0, :l; b 1/2
end
tp_drop -8, 8, 1 do
	t 0, -2; b 1/4
	t -1, -3
end
tp_chain 8, 0, 1 do
	f 7, 3, :r; b 1/2
end
tp_drop 8, 8, 1 do
	t 5, -1; b 1/4
	t 6, -2
end
tp_chain -8, 0, 1 do
	f -2, 3, :u; b 1/2
end
tp_drop -8, -8, 1 do
	t -8, 4; b 1/4
	t -7, 3
end
tp_chain 8, 0, 1 do
	f 2, -3, :d; b 1/2
end
tp_drop 8, -8, 1 do
	t 2, 3; b 1/4
end
notes = tp_drop 8, 0, 1 do
	t 3, 2; b 1/4
	t 3/2, 0; b 1/4
	t 3, -2; b 1/2
end
transform(duplicate notes) { horizontal_flip }

tp_drop 0, 8, 1 do
	f -6, 0, :ul
end
tp_drop 0, -8, 1 do
	t 7, 1; b 1/2
end
tp_drop 8, 0, 1 do
	t 0, 5/2; b 1/4
	t 0, 4
end
tp_drop -8, 0, 1 do
	t 0, -4; b 1/2
end
tp_drop 8, -8, 1 do
	t -3, 4
end
tp_drop -8, 8, 1 do
	t 3, -4; b 1/4
	t 4, -3/2; b 1/4
	t 5, 1; b 1/4
	f 6, 7/2, :dr
end
tp_drop 0, 8, 1 do
	t -7, 0; b 3/4
end
notes = tp_drop 8, 0, 1 do
	4.times do |i|
		angle = PI + 2*atan(3/4) * i/3
		r = 25/3
		x, y = 31/3 + r*cos(angle), 4 + r*sin(angle)
		t x, y; b 1/4
	end
end
transform(duplicate notes) { rotate PI }
b 1/4

3.times do |i|
	angle = PI/2 + 2*PI/3 * i
	x, y = 4*cos(angle), 4*sin(angle)
	tp_drop -x, -y, 1, relative: false do
		h x, y, 8
	end
end
b 4

hexagram 4
3.times do |i|
	angle = [5*PI/6, -PI/2, PI/6][i]
	x, y = 4*cos(angle), 4*sin(angle)
	tp_drop -x, -y, 1, relative: false do
		h x, y, 4-i/8; b 1/8
	end
end
b 4-3/8

t 0, 0; b 2
10.times do |i|
	(-1..1).each do |j|
		x, y = sqrt(3)/2*i, 3*j + (-1)**i*3/4
		bg_note x, y, 2-2/9*i
		bg_note -x, y, 2-2/9*i unless i.zero?
	end
	b 2/9 unless i == 9
end

def neuro x, y, pattern
	pattern = pattern.digits(2).map { [false, true][_1] }
	pattern = [false]*(4-pattern.size) + pattern.reverse
	tp_drop (x<=>0)*8, 8, 1 do
		b 3/4
		pattern.each_with_index do |has, i|
			unless has
				b 1/4
				next
			end
			i == 1 ? f(x, y, PI/2 - (x<=>0)*PI/4) : t(x, y); b 1/4
			x += (x <=> 0)*2
			y -= 2
		end
		b 1/4
	end
end

grid 16
tp_drop 0, 4, 1, relative: false do
	t -8, 4; t 0, -4; t 8, 4
end
tp_drop 0, 8, 1, preserve_beat: false do
	4.times do |i|
		if i.zero?
			b 2
		else
			t 0, -4; b 1/2
			t 0, -4; b 1
			t 0, -4; b 1/2
		end
		t 0, -4; b 3/4
		t 0, -4; b 3/4
		t 0, -4; b 1/2
	end
end
neuro -2, 2, 0b0111
neuro 4, 2, 0b0110

neuro -4, 0, 0b0100
neuro 6, 2, 0b0110

neuro -4, 2, 0b1110
neuro 4, 0, 0b0110

neuro -4, 2, 0b0100
neuro 2, 2, 0b0110

tp_drop 0, 4, 1, relative: false do
	t -8, 4; t 0, -4; t 8, 4; b 1
end
notes = group do
	notes = tp_drop -8, 8, 1 do
		3.times { t 2, 0; b 1/4 }; b 1/4
	end
	transform(duplicate notes) { horizontal_flip }
end
transform(duplicate notes) { translate -1, 3; beat_translate 1 }
transform(duplicate notes) { translate 3, -1; beat_translate 2 }
transform(notes) { translate -4, 1 }
b 2

notes = tp_drop 0, 12, 1 do
	[6, 2, -2, 2, 6].each do |x|
		t x, -4; b 1/2
	end
end
transform(duplicate notes) { translate -4, 0 }
tp_drop 8, 0, 1 do
	3.times do |i|
		x, y = -9/2+3*i, -2+i/2
		t x, y; b 1/4
	end
end
tp_drop -8, 0, 1 do
	3.times do |i|
		x, y = 9/2-3*i, -1/2+[0,2,1][i]
		t x, y; b 1/4
	end
end

notes = tp_drop 0, -8, 1 do
	4.times do |i|
		x, y = -6+4*i, 3-(i%2)/2
		t x, y; b 1/4
	end
end
transform(duplicate notes) { translate -2, -2; beat_translate 1 }
transform(duplicate notes) { horizontal_flip; translate 2, -4; beat_translate 2 }
transform(duplicate notes) { horizontal_flip; translate 0, -6; beat_translate 3 }
b 3

notes = group do
	notes = tp_drop 0, 8, 1 do
		t 8, -3; b 1/2
		t 7, -1; b 1/2
		t 6, 1; b 1/2
		t 7, 3; b 1/2
	end
	transform(duplicate notes) { translate -4, -1 }
end
transform(duplicate notes) { horizontal_flip; translate 0, 1; beat_translate 1/4 }
=begin
notes = tp_chain 0, 8, 1 do
	2.times do
		f 8, 2, :d; b 1/4
		f -8/3, 2, :d; b 1/4
		f 8, -2, :u; b 1/4
		f -8/3, -2, :u; b 1/4
	end
end
transform(duplicate notes) { translate -16/3, 0 }
=end
8.times do |i|
	4.times do |j|
		x, y = -8+16/3*j, 2*(-1)**i
		tp_chain 0, 12, beat_speed: 16/5 do
			i.zero? ? f(x, y, :d) : d(x, y)
		end
	end
	b 1/4
end

diamond_grid 16
tp_drop 0, 4, 1, relative: false do
	t -8, 4; t 0, -4; t 8, 4
end
tp_drop 0, 8, 1, preserve_beat: false do
	4.times do |i|
		if i.zero?
			b 2
		else
			t 0, -4; b 1/2
			t 0, -4; b 1
			t 0, -4; b 1/2
		end
		t 0, -4; b 3/4
		t 0, -4; b 3/4
		t 0, -4; b 1/2
	end
end
neuro 2, 2, 0b0111
neuro -2, 2, 0b0110

neuro 4, 0, 0b0100
neuro -6, 2, 0b0110

neuro 6, 2, 0b0110
neuro -4, 0, 0b0110

neuro 2, 2, 0b0110
neuro -2, 2, 0b0110

tp_drop 0, 4, 1, relative: false do
	t -8, 4; t 0, -4
end
notes = tp_chain -8, 0, 1 do
	6.times do |i|
		x, y = 6+2*(-1)**i - 1/2*((i/2).floor%2), 4-8*i/6
		tp_drop 0, 8, 1 do
			f -6, 0, :l
		end if i == 4
		t x, y; b 1/4
	end
	t 8-1/2, -4; b 1/2
end
transform(duplicate notes) { horizontal_flip; beat_translate 2 }
b 2

tp_drop 0, 12, 1 do
	[2, 6, 2, -2, -6, -2, 2, -2].each do |x|
		t x, -4; b 1/4
	end
	notes = group do
		[6, 2, -2].each do |x|
			t x, -4; b 1/2
		end
	end
	transform(duplicate notes) { translate -4, 0 }
	b 1/2
end

hexagram 4
notes = group do
	3.times do |i|
		3.times do |j|
			angle = -5*PI/6 + 2*PI/3 * (i+j)
			x, y = 4*cos(angle), 4*sin(angle)
			tp_drop -x, -y, 1, relative: false do
				if j.zero? && i != 2
					f x, y, (angle/PI).round*PI
				else
					t x, y
				end
			end
		end
		b 3/4
	end
end
transform(duplicate notes) { rotate PI; beat_translate 2 }
b 4-3/4*3

notes = tp_drop -8, 0, 1 do
	h 8, 4, 1/2
	f 8, 0, :l
	h 8, -4, 1/2
end
transform(duplicate notes) { horizontal_flip; beat_translate 1 }
b 2
def text_r
	big_text 2, ?R
	notes = group do
		t -20.6, 46.1; t 13.5, 41.9; b 1/3
		t -17.1, 23.8; t 31.0, 23.2; b 1/3
		t -19.4, 4.2; t 10.5, 7.2; b 1/3
		t -23.6, -14.8; t 3.4, -13.3; b 1/3
		t -28.6, -32.6; t 19.2, -30.5; b 1/3
		t -37.2, -48.9; t 47.3, -42.4; b 1/3
	end
	transform(notes) { scale 1/12.5 }
end
text_r

tp_drop 0, 8, 1 do
	h 8, -2, 4
end
tp_chain 0, 8, 1 do
	t -6, -3; b 1
	tp_drop 8, 8, 1 do
		t -7, 2; b 1/2
		t -1, 0; b 1/2
		t -7, 2; b 1
	end
	t -3, -3; b 1
end

tp_drop 0, 8, 1 do
	h -8, -2, 4
end
tp_chain 0, 8, 1 do
	t 5, -4; b 1
	tp_drop -8, 8, 1 do
		t 7, 2; b 1/2
		t 1, 0; b 1/2
		t 7, 2; b 1/2
	end
	t 2, -3; b 1/2
	t 8, -2; b 1
end

notes = group do
	tp_drop -8, 0, 1 do
		t 6, 3; b 1/4
		t 3, 2; b 1/4
	end
	tp_drop 8, 0, 1 do
		t -1, 1; b 1/4
		t 2, 0; b 1/4
		t -2, -1; b 1/4
		t 1, -2; b 1/4
	end
end
transform(notes) { translate -2, -2 }
tp_drop 0, 8, 1, preserve_beat: false do
	5.times { b 1/4; t -7, -4; b 1/4 }
end
tp_drop -8, -8, 1 do
	t 2, 2; b 1/2
	t 6, 3; b 1/2
	t 2, 2; b 1/2
	t 6, 3; b 1/2
	t 1, 4; b 1/2
end

tp_drop 8, 8, 1 do
	3.times do |i|
		4.times do |j|
			x, y = -8+7/2*i + 3/2*j+j**2/4, 2+i/2-j*2
			t x, y; b 1/4
		end
	end
	4.times do |j|
		x, y = 2+3/2*j-j**2/4, -4+j*2+j**2/8
		t x, y; b 1/4
	end
end

tp_drop 0, -8, 1 do
	h 8, 2, 4
end
tp_chain 0, 8, 1 do
	t -6, 3; b 1
	tp_drop -8, 8, 1 do
		t -7, 0; b 1/2
		t -1, -2; b 1/2
		t -7, 0; b 1
	end
	t -3, 3; b 1
end

tp_drop 0, -8, 1 do
	h -8, 2, 4
end
tp_chain 0, 8, 1 do
	t 5, 4; b 1
	tp_drop 8, 8, 1 do
		t 7, 0; b 1/2
		t 1, -2; b 1/2
		t 7, 0; b 1
	end
	t 2, 3; b 1
end

tp_drop 0, -8, 1 do
	t -5, 4; b 1/2
	t 8, 2; b 1/4
	t 5, 3; b 1/4
	t 3, 1; b 1/2
	t -3, 4; b 1/2
end
notes = tp_drop 0, 8, 1 do
	t -8, 2; b 1/4
	t -4, 1; b 1/4
	t -2, 0; b 1/4
	t 0, 1; b 1/4
end
transform(duplicate notes) { translate 3, -4; beat_translate 1 }
b 1

tp_chain 0, -8, 1 do
	mark :c
end
8.times do |i|
	x, y = [8, 2, 5, 2][i%4], -2+i*2/3
	if i.even?
		tp_drop(8, 0, 1) { t x, y; b 1/2 }
	else
		at(:c, update_mark: true) { b 1/4; t x, y; b 1/4 }
	end
end

tp_chain 8, 0, 1 do
	t 7, -2+16/3; b 1/2
	t 4, 2; b 1/2
	t 1, 0; b 1/2
	t -2, -2; b 1/2
end
at :c, update_mark: true do
	b 1/4
	t 0, 5/2; b 1/2
	t -3, 1/2; b 1/2
	t -6, -2; b 1/2
	t -8, -4; b 1/4
end

tp_drop 0, 4, 1, relative: false do
	t -8, 4; t 0, -4; t 8, 4; b 1/2
end
tp_drop 0, 8, 1 do
	(-2..2).each do |i|
		x, y = 3*i, -1+i**2/2
		t x, y; b 1/4
	end
	b 1/4
end
notes = tp_drop 8, 0, 1 do
	t 7, 4; b 1/4
	t 3, 3; b 1/4
	t -1, 2; b 1/4
	t 3, 1; b 1/4
end
transform(duplicate notes) do
	horizontal_flip
	translate 0, -3
	beat_translate 1
end
b 1

tp_drop 0, 12, 1 do
	(Array.new(4) { |i| 8-4*i } + Array.new(4) { |i| -8+4*i }).each do |x|
		t x, -4; b 1/4
	end
	tp_chain 0, 12, 1, preserve_beat: false do
		4.times do |i|
			angle = PI/2 * i/4
			x, y = 8*cos(angle), 8*sin(angle)-4
			t x, y; b 1/2
		end
	end
	4.times { b 1/4; t -8, -4; b 1/4 }
end

8.times do |i|
	x, y = [0, -3, -5, -3][i%4], 4-i
	if i%4 == 0
		tp_drop(8, 0, 1) { t x, y; b 1/4 }
	else
		tp_drop(-8, 0, 1) { t x, y; b 1/4 }
	end
end
tp_drop 0, 12, 1 do
	(Array.new(4) { |i| -8+4*i } + Array.new(4) { |i| 8-4*i }).each do |x|
		t x, -4; b 1/4
	end

	tp_chain 0, 12, 1, preserve_beat: false do
		8.times do |i|
			angle = -PI - PI/2 * i/4
			x, y = 8*cos(angle), 8*sin(angle)-4
			t x, y; b 1/2
		end
	end
	4.times { b 1/4; t 8, -4; b 1/4 }
	4.times { b 1/4; t -8, -4; b 1/4 }
end

tp_drop -8, 0, 1 do
	f 8, 4, :l; f 8, -4, :l; b 1/2
end
tp_chain 0, 8, 1 do
	t 2, 2; b 1/4
	t 4, 1; b 1/4
	t 2, 0; b 1/2
	t -2, 3; b 1/2
	t -6, 4
end
tp_chain 0, 8, 1 do
	t 5, -3; b 1/2
	t 0, -2; b 1/4
	t -1, -4; b 1/4
	t -2, -2; b 1/4
	t -3, 0; b 1/4
	t -4, -2; b 1/4
	t -5, 0; b 1/4
end

tp_drop 8, 0, 1 do
	f -8, 4, :r; f -8, -4, :r; b 1/4
end
tp_drop -8, 8, 1 do
	1.upto 3 do |i|
		x, y = -8+3*i+i**2/3, 4-i*2+i**2/2
		t x, y; b 1/4
	end
	4.times do |i|
		x, y = -7+3*i+i**2/3, 1-i*2+i**2/3*2
		t x, y; b 1/4
	end
	4.times do |i|
		x, y = -5+3*i, -2-i*3/2+i**2*3/4
		t x, y; b 1/4
	end
	4.times do |i|
		x, y = -2+3*i, -4+i**2*3/4
		t x, y; b 1/4
	end
end

notes = group do
	tp_drop -8, 0, 1 do
		f -5, 4, :l; f -5, -4, :l; b 1/2
	end
	tp_drop 0, 8, 1 do
		2.times do
			t -2, 0; t 2, 0; b 1/2
		end
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 3/2 }
b 3/2
notes = group do
	tp_drop -8, 0, 1 do
		f -7, 0, :l; b 1/2
	end
	tp_drop 0, 8, 1 do
		t -2, 0; b 1/2
	end
end
transform(duplicate notes) { horizontal_flip }

checkerboard 4
4.times do |i|
	angle = -3*PI/4 - PI/2*i
	r = 4*sqrt(2)
	(-1..2).each do |j|
		a = angle + PI/2*j
		x, y = r*cos(a), r*sin(a)
		tp_drop -x, -y, 1, relative: false do
			j.zero? ? h(x, y, 1/2) : t(x, y)
		end
	end
	b 1/2
	tp_drop 0, 8, 1 do
		2.times { t 0, 0; b 1/4 }
	end
end

4.times do |i|
	angle = PI/4 + PI/2*i
	x, y = 4*sqrt(2)*cos(angle), 4*sqrt(2)*sin(angle)
	tp_drop -x, -y, 1, relative: false do
		f x, y, (angle/PI).round*PI
	end
end
def t_l y
	tp_drop 48, 0, 3 do
		t -8, y+2; t -8, y-2
	end
end
def t_d x
	tp_drop 0, 24, 1.5 do
		t x+2, -4; t x-2, -4
	end
end
def t_r y
	tp_drop -48, 0, 3 do
		t 8, y+2; t 8, y-2
	end
end
notes = group do
	b 3/2
	t_l -1; b 1
	t_d 4; b 1/4
	t_d -4; b 1/4
	t_d 4; b 1/2
	t_d -1; b 1/2

	b 1/2
	t_l 2; b 1/4
	t_l 2; b 3/4
	t_l -1; b 3/4
	t_d 5; b 1/4
	t_d -4; b 1/4
	t_d -4; b 1/4
	t_d 4; b 1/2
	t_d 0; b 1/2

	t_l 2; b 1/2
	t_l 2; b 3/4
	t_d 1; b 1/2
	t_d -4; b 1/4
	t_d -4; b 1/2
	t_d 4; b 1/4
	t_d 4; b 1/4
	t_l -1; b 1/4
	t_l -1; b 1/4
	t_d 2; b 1/4
	t_d 2; b 1/4

	t_l 2; b 3/4
	t_d 4; b 1/4
	t_d 4; b 1/4
	t_d 0; b 1/4
	t_d 4; b 1/2
	t_l -1; b 3/4
	t_l 0; b 3/4
	t_l 1; b 1/2
end
transform(notes) do
	angle = PI/24
	rotate angle
	scale 1/(cos(angle)+2*sin(angle))
end

grid 1/2
tp_chain 0, 16, 1.5 do
	h 5, -3, 1/2; b 1
end
notes = group do
	t_d -4; b 1
	t_r 2; b 1/4
	t_r 2; b 1/2
	t_r -1; b 3/4
	t_r 2; b 1/2

	t_d -4; b 1/2
	t_d -1; b 1/4
	t_d 4; b 1/4
	t_d -3; b 1/2
	t_d -3; b 1
	t_d -4; b 1/2
	t_r 1; b 1/4
	t_r 1; b 1/4
	t_r 1; b 1/2

	t_d -1; b 3/4
	t_d -4; b 3/4
	t_r -2; b 1/2
	t_r 1; b 1/4
	t_r 1; b 3/4
	t_d 3; b 1/2
	t_d -4; b 1/4
	t_d -4; b 1/4
end
transform(notes) do
	angle = PI/24
	rotate -angle
	scale 1/(cos(angle)+2*sin(angle))
end

tp_drop 0, 16, 1.5 do
	h 6, -3, 2; h 2, -3, 2; b 2
	h -2, -3, 2; h -6, -3, 2; b 2
end

def t_h n
	i, d = n.divmod 1
	angle1 = PI/3*(i+2)
	angle2 = angle1 + PI/3
	r = 8/sqrt(3)
	x1, y1, x2, y2 = r*cos(angle1), r*sin(angle1), r*cos(angle2), r*sin(angle2)
	t x1 + d*(x2-x1), y1 + d*(y2-y1)
end
def kicks pattern
	pattern = pattern.digits(2).map { [false, true][_1] }
	pattern = [false]*(16-pattern.size) + pattern.reverse
	group preserve_beat: false do
		b -1/2
		tp_chain 0, 8, relative_beat: 4, preserve_beat: false do
			(0...16).step(2) do |i|
				if i == 10
					tp_chain(-8, 0, 1) { f 0, 0, :l }
				else
					t 8, 4-i/2
				end if pattern[i]
				b 1/2
			end
		end
		tp_chain 0, 8, relative_beat: 4 do
			b 1/4
			(1...16).step(2) do |i|
				x, y = 6, 4-i/2
				t x, y if pattern[i]; b 1/2
			end
		end
	end
end
hexagon 46
kicks 0b0010000011100000
tp_chain 0, 8, 1 do
	t_h 5; b 1
	t_h 0; b 1
	t_h 1; b 1
	t_h 2; b 1/2
	t_h 5/2; b 1/2
	mark :c
end

transform(kicks 0b0010111010100000) { horizontal_flip }
at :c, update_mark: true, preserve_beat: true do
	t_h 3; b 1
	t_h 4; b 1
	t_h 5; b 1
	t_h 4; b 1
end

kicks 0b0010000011101010
at :c, update_mark: true, preserve_beat: true do
	t_h 3; b 1
	t_h 2; b 1
	t_h 1; b 1
	t_h 0; b 1
end

transform(kicks 0b0010111111100000) { horizontal_flip }
at :c, update_mark: true, preserve_beat: true do
	t_h 5; b 3/2
	t_h 4; b 1/2
	t_h 7/2; b 1
	t_h 5/2; b 1/2
	t_h 2; b 1/2
end

kicks 0b1110000011100000
at :c, update_mark: true, preserve_beat: true do
	t_h 3/2; b 1
	t_h 1/2; b 1
	t_h 11/2; b 1
	t_h 9/2; b 1
end

transform(kicks 0b0010111110100000) { horizontal_flip }
at :c, update_mark: true, preserve_beat: true do
	t_h 7/2; b 1
	t_h 5/2; b 1
	t_h 7/2; b 1
	t_h 9/2; b 1/2
	t_h 5; b 1/2
end

kicks 0b0010000011101010
at :c, update_mark: true, preserve_beat: true do
	t_h 11/2; b 4
end

transform(kicks 0b0010111111100000) { horizontal_flip }
at :c, update_mark: true, preserve_beat: true do
	t_h 3/2; b 2
	t_h 3; b 2
end

kicks 0b1110000000000000
3.times do |i|
	angle = 2*PI/3*i
	x, y = 8/sqrt(3)*cos(angle), 8/sqrt(3)*sin(angle)
	tp_drop -x, -y, 1, relative: false do
		h x, y, 14
	end
end
b 8

3.times do |i|
	angle = 2*PI/3*(i+1/2)
	x, y = 8/sqrt(3)*cos(angle), 8/sqrt(3)*sin(angle)
	tp_drop -x, -y, 1, relative: false do
		h x, y, 6
	end
end
b 8

turntable 16
notes = tp_drop -12, 0, 1 do
	0b11101101101111111.digits(2).reverse.each_with_index do |has, i|
		i == 16 ? f(0, 0, :u) : t(0, 0) if has > 0; b 1/4
	end
	b -1/4
end
transform(duplicate notes) { horizontal_flip }

b 2
n = 300
n.times do |i|
	angle = PI/16*i
	bg_note 4*cos(angle), 4*sin(angle)
	bg_note 2*cos(angle/2+PI), 2*sin(angle/2+PI) if i%4==0
	b 10*((1-i/n)**2 - (1-(i+1)/n)**2)
end

tp_chain 0, 8, 1 do
	tp_drop -8, 0, 1, preserve_beat: false do
		t -6, -3; b 1
		f -5, 1, :l; b 1
	end
	h 2, -4, 1; b 3/2
	t 6, 0; b 1/4
	t 3, 1; b 1/4
	tp_drop 8, 0, 1, preserve_beat: false do
		t 0, 2; b 1
		f 4, 0, :r; b 1
	end
	h -6, 4, 1/2; b 1
	t 6, 4; b 1/2
	t -4, -1; b 1/4
	t -1, -2; b 1/4

	tp_drop 8, 0, 1, preserve_beat: false do
		t 8, -3; b 1
		f 4, 4, :r; b 1
	end
	h 2, -3, 1; b 3/2
	t 8, 0; b 1/4
	t 6, -1; b 1/4
	tp_drop -8, 0, 1, preserve_beat: false do
		t -6, -2; b 1
		f -3, 4, :l; b 1
	end
	t 4, -2; b 1/4
	t -4, 0; b 1/4
	t 0, 1; b 1/4
	t -5, 2; b 1/4
	t 6, 3; b 1/4
	t 4, 1; b 1/4
	t 2, -1; b 1/4
	t 0, -3; b 1/4

	def overlay x, y
		t x, y; b 1/4
		tp_drop 0, 8, 1 do
			t x, y; b 1/4
		end
	end
	tp_drop -8, 0, 1, preserve_beat: false do
		t -2, -1; b 1
	end
	t 8, 1; b 1/2
	overlay 3, 4
	overlay -5, 3
	overlay 2, 2
	overlay -4, 1
	overlay 1, 0
	overlay -3, -1
	overlay 2, -2

	tp_drop 8, 0, 1, preserve_beat: false do
		t 5, -1; b 1
		f 7, 3, :r; b 1
	end
	h -6, -2, 1; b 3/2
	t 4, 0; b 1/4
	t 2, -1; b 1/4
	tp_drop -8, 0, 1, preserve_beat: false do
		t -8, 2; b 1
		f -6, -3, :l; b 1
	end
	h 0, -2, 1/2; b 1
	t 8, 1; b 1/2
	t 4, 2; b 1/2

	tp_drop 8, 0, 1, preserve_beat: false do
		t 7, 4; b 1
		f 4, -1, :r; b 1
	end
	h -5, 3, 1; b 3/2
	t -1, 0; b 1/4
	t -3, -1; b 1/4
	tp_drop -8, 0, 1, preserve_beat: false do
		t -5, -2; b 1
		f -3, 2, :l; b 1
	end
	t 7, 1; b 1/2
	t 3, -3; b 1/6
	t 2, -2; b 1/6
	t 3, -1; b 1/6
	t 4, 0; b 1/2
	t 2, 3; b 1/2
	
	tp_drop -8, 0, 1, preserve_beat: false do
		t -7, 4; b 1
		f -7, 2, :l; b 1
	end
	t 7, 4; b 1/2
	t -3, 0; b 1/4
	t -5, 1; b 1/4
	t 3, 3; b 1/2
	t 2, -2; b 1/4
	t 4, -1; b 1/4
	tp_drop 8, 0, 1, preserve_beat: false do
		t 6, 0; b 1
		f 8, 3, :r; b 1
	end
	t -1, -1; b 1/2
	t -2, -4; b 1/4
	t -4, -3; b 1/4
	t -6, -2; b 1/2
	t -6, 3; b 1/2

	tp_drop -8, 0, 1, preserve_beat: false do
		4.times do |i|
			t -8, 4-8/3*i; b 1/2
		end
		4.times do |i|
			t -16/3, -4+8/3*i; b 1/2
		end
	end
	h 3, 3, 1/2; b 3/2
	t 4, -2; b 1/4
	t 6, -1; b 1/4
	t -2, -3; b 1/4
	t 1, -4; b 1/4
	t -3, -1; b 1/4
	t 0, -1; b 1/4
	t -3, 1; b 1/4
	t 1, 2; b 1/4
	t -2, 3; b 1/4
	t 4, 3; b 1/4

	tp_drop 8, 0, 1, preserve_beat: false do
		4.times do
			t 0, 4; b 1/4
			t 0, -4; b 1/4
		end
		t 0, 4
	end
	2.times do
		t -1, -4/3; b 1/4
		t 1, 4/3; b 1/4
		t 1, -4/3; b 1/4
		t -1, 4/3; b 1/4
	end
	notes = tp_drop -8, 0, 1, preserve_beat: false do
		b 1/2
		5.times do |i|
			angle = PI/2 + PI/2 * i/4
			x, y = 8+10*cos(angle), -4+8*sin(angle)
			t x, y; b 1/8
		end
	end
	transform(duplicate notes) { horizontal_flip; beat_translate 1 }
	t -1, -4/3; b 1/4
	1.upto 4 do |i|
		angle = PI/2 + PI/2*i/4
		x, y = 6*cos(angle), -2+6*sin(angle)
		d x, y; b 1/4
	end
	1.upto 3 do |i|
		angle = -PI/2 + PI/2*i/4
		x, y = -2+6*cos(angle), 2+6*sin(angle)
		d x, y; b 1/4 unless i == 4
	end

	grid 16
	tp_drop -8, 0, 1, preserve_beat: false do
		b 1/2
		[0, -2, -4].each { |x| d x, -4; b 1/2 }
		4.times do |i|
			x, y = -6, -4+2*i
			t x, y; b 1/2
		end
	end
	h 4, 2, 1; b 3/2
	t 4, -4; b 1/4
	t 6, -2; b 1/4
	t 8, 0; b 1/2
	t 6, 4; b 1/2
	t 4, 0; b 1/2
	t 2, 4; b 1/2

	tp_drop -8, 0, 1, preserve_beat: false do
		4.times do |i|
			x, y = -8, 4-2*i
			t x, y; b 1/2
		end
		4.times do |i|
			x, y = -6, -4+2*i
			t x, y; b 1/2
		end
	end
	h 0, 0, 1; b 3/2
	t 4, 0; b 1/4
	t 2, -2; b 1/4
	h 0, -4, 1; b 3/2
	t 2, 0; b 1/4
	t 0, 2; b 1/4

	tp_drop 8, 0, 1, preserve_beat: false do
		4.times do |i|
			x, y = 8, 4-2*i
			t x, y; b 1/2
		end
		4.times do |i|
			x, y = 6, -4+2*i
			t x, y; b 1/2
		end
	end
	h -2, 4, 1; b 3/2
	t -2, -2; b 1/4
	t -4, 0; b 1/4
	t -6, 2; b 1/2
	t -2, 4; b 1/2
	t 0, 0; b 1/6
	d -2, 0; b 1/6
	d -4, 0; b 1/6
	t -6, 0; b 1/4
	t -4, -2; b 1/4

	tp_drop 8, 0, 1, preserve_beat: false do
		4.times do |i|
			x, y = 8, 4-2*i
			t x, y; b 1/2
		end
		4.times do |i|
			x, y = 6, -4+2*i
			t x, y; b 1/2
		end
	end
	h -2, -4, 1; b 3/2
	t 2, 4; b 1/4
	t 0, 2; b 1/4
	h -2, 0, 1/2; b 1
	t 0, -4; b 1/4
	t 2, -2; b 1/4
	t 0, 0; b 1/4
	t 2, 2; b 1/4

	group preserve_beat: false do
		4.times do |i|
			tp_chain -8*(-1)**i, 0, 1 do
				f -7*(-1)**i, 4-3/2*i, PI/2+PI/2*(-1)**i; b 3/4
			end
		end
		tp_chain -8, 0, 1 do
			f -7, -2, :l; b 1/2
		end
		tp_chain 8, 0, 1 do
			f 7, -3, :r; b 1/2
		end
	end
	4.times do |i|
		3.times do |j|
			x, y = (4-8/3*j)*(-1)**i, 4-(3*i+j)/2
			t x, y unless i==0 && j==1; b 1/4
		end
	end
	t 4, -2; b 1/4
	t 4/3, -5/2; b 1/4
	t -4/3, -3; b 1/4
	t -4, -7/2; b 1/4

	tp_drop -8, 0, 1, preserve_beat: false do
		t -2, -4; b 1/2
		t -7, -3; b 1/4
		t -6, -2; b 1/2
		t -8, 0; b 1/2
		t -3, -1; b 1/4
	end
	8.times do |i|
		x, y = 2 + (1-4*(i/8-1/2)**2)*4, -4+4*i/8
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	tp_drop 8, 0, 1, preserve_beat: false do
		t 2, 0; b 1/2
		t 7, 2; b 1/4
		t 8, 3; b 1/2
		t 5, 3; b 1/4
		t 4, 2; b 1/4
		t 3, 1; b 1/4
	end
	8.times do |i|
		x, y = -2 - (1-4*(i/8-1/2)**2)*4, 4*i/8
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

notes = group do
	tp_drop 0, 8, 1 do
		f 2, 0, :r
	end
	tp_drop 0, -8, 1 do
		f -2, 4, :l; b 1/2
	end
	tp_drop 0, 8, 1 do
		f 2, 4, :r
	end
	tp_drop 0, -8, 1 do
		f -2, 0, :l; b 1
	end
end
transform(duplicate notes) { vertical_flip; beat_translate 3/2 }
b 3/2
notes = group do
	3.times do |i|
		angle = 2*PI/3 - 2*PI/3*i
		x, y = 3*cos(angle)-6, 3*sin(angle)
		tp_chain(-12*cos(angle), -12*sin(angle), 1) { t x, y }
	end
	b 1/2
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1/2

notes = group do
	notes = tp_drop 8, 0, 1 do
		t -2, 4; f -2, 0, :l; t -2, -4; b 3/4
	end
	transform(duplicate notes) { horizontal_flip }
end
transform(duplicate notes) { horizontal_flip; scale 5/2, 1; beat_translate 3/4 }
b 3/4
notes = tp_drop 8, 0, 1 do
	f -8, 4, :r; f -8, 0, :r; f -8, -4, :r; b 1/2
end
transform(duplicate notes) { horizontal_flip }
=begin
notes = tp_chain 0, 8, 1 do
	2.times do
		f -8, 2, :d; b 1/4
		f 8/3, 2, :d; b 1/4
		f -8, -2, :u; b 1/4
		f 8/3, -2, :u; b 1/4
	end
end
transform(duplicate notes) { translate 16/3, 0 }
=end
8.times do |i|
	4.times do |j|
		x, y = -8+16/3*j, 2*(-1)**i
		tp_chain 0, 12, beat_speed: 16/5 do
			i.zero? ? f(x, y, :d) : d(x, y)
		end
	end
	b 1/4
end

notes = group do
tp_drop 0, -8, 1, preserve_beat: false do
	6.times do |i|
		h 8*(-1)**i, 4, 4; b 4
	end
	h 8, 4, 2; b 2
	h -8, 4, 2; b 2
	h 8, 4, 2; b 4
end

tp_drop 8, 0, 1 do
	f 2, 4, :r
end
tp_chain 0, 8, 1 do
	t -5, 4; b 1/2
	t -2, 3; b 1/4
	h 0, 2, 1/2; b 3/4
	h 3, 0, 1/2; b 1/2
	tp_chain(0, 8, 1) { t -4, 0; b 1/2 }
	t -6, 2; b 1/2
end
tp_chain 0, -8, 1 do
	t 2, -2; b 1/4
	t 0, -1; b 1/4
	t 2, 0; b 1/4
	t 0, 1; b 1/4

	h 2, 2, 1/2; b 1/2
	tp_chain(0, -8, 1) do
		t -4, -2; b 1/4
		t -6, -1; b 1/4
		t -4, 0; b 1/2
		t 0, 3; b 1/2
	end
end
tp_chain 0, 8, 1 do
	h -1, -1, 1/2; b 1/2
	tp_chain 0, 8, 1, preserve_beat: false do
		t -6, -3; b 1
		t -4, 0; b 1
	end
	b 1/2
	h 3, 0, 1/2; b 1

	tp_drop 8, 0, 1 do
		f 3, 4, :r
	end
	h -5, 3, 1/2; b 1/2
	tp_chain 0, 8, 1 do
		t 2, 2; b 1/4
		t 0, 1; b 1/4
		t 2, 0; b 1/2
		t -2, -1; b 1/2
	end
	h 6, 2, 1/2; b 1/2
end
tp_chain 0, -8, 1 do
	t -6, -3; b 1/4
	t -4, -2; b 1/4
	t -6, -1; b 1/4
	t -4, 0; b 1/4
	t -6, 1; b 1/4
	t -4, 2; b 1/4

	tp_drop -8, 0, 1 do
		f -2, 3, :l
	end
	h 1, 2, 1/2; b 1/2
end
tp_chain 0, -8, 1 do
	t -2, -2; b 1/4
	t 0, -1; b 1/4
	t -2, 0; b 1/2
end
tp_chain 0, 8, 1 do
	t 6, 3; b 1/4
	t 4, 2; b 1/4
	h 6, 1, 1/2; b 1/2
	tp_chain 0, 8, 1, preserve_beat: false do
		t 1, 1; b 1/2
		t 1, -1
	end
	b 1/4
	h 3, 0, 1/2; b 3/4
	t 6, -2; b 1/2
end

tp_chain 8, 0, 1 do
	f 3, 4, :r
end
tp_chain 0, -8, 1, preserve_beat: false do
	b 1/2
	t -4, 2; b 1/2
	t -6, 0; b 1
	t 6, 1; b 1
	t 5, -2; b 1
end
tp_chain 0, -8, 1 do
	h -2, 0, 1/2; b 3/2
	h -8, -2, 1/2; b 1
	h -4, -2, 1/2; b 1
	t -5, 1; b 1/2
end

tp_chain -8, 0, 1 do
	f -2, 4, :l
end
tp_chain 0, 8, 1 do
	h 2, 3, 1/2; b 1/2
	tp_chain 0, 8, 1 do
		t -2, 1; b 1/4
		t 0, 0; b 1/4
		t -2, -1; b 1/2
		t 4, -3; b 1/2
	end
	t -6, 0; b 3/4
end
tp_chain 0, -8, 1 do
	t 5, -1; b 1/4
	t 7, 0; b 1/4
	t 5, 1; b 1/4
	t 7, 2; b 1/4
	t 5, 3; b 1/4

	tp_chain -8, 0, 1 do
		f -6, 3, :l
	end
	tp_chain 0, -8, 1, preserve_beat: false do
		b 1/2
		t -5, 1; b 1/2
		t -7, -1; b 1/2
		t -6, -3; b 1/2
	end
	h 3, 4, 1/2; b 3/4
	h 0, 0, 1/2; b 3/4
	t -2, -3; b 1/2
end
tp_chain 8, 0, 1 do
	f 6, 3, :r
end
tp_chain 0, 8, 1, preserve_beat: false do
	b 1/2
	t 5, 1; b 1/2
	t 7, -1; b 1/2
	t 6, -3; b 1/2
end
tp_chain 0, 8, 1 do
	h -4, 2, 1/2; b 3/4
	h -1, -2, 1/2; b 3/4
	t 2, -4; b 1/2
end
end
transform(notes) { horizontal_flip }

tp_chain 8, 0, 1 do
	f 2, 4, :r
end
tp_chain 0, -8, 1 do
	b 1/2
	t -3, 1; b 1/4
	t -1, 0; b 1/4
	t -3, -1; b 1/2
	t 1, -4; b 1/4
	t -1, -3; b 1/4
	16.times do |i|
		x, y = [3,1,-3,-1][i%4]*(2+(1-(i/16-1/2)**2*4)*2/3), -2+6*i/16
		[0,4,6,8,12,14].include?(i) ? t(x, y) : tp_chain(0, 8, 1) { t x, y }; b 1/8
	end
end

diamond_grid 12
tp_drop 0, -8, 1, preserve_beat: false do
	3.times do |i|
		notes = group do
			h -4, 4, 4-1/2
			8.times { t -8, 4; b 1/2 }
		end
		transform(notes) { horizontal_flip } unless i == 2
	end
end

tp_chain 0, 8, 1 do
	b 3/4
	t -4, 4; b 3/4
	t -3, -1; b 3/4
	t 0, -4; b 1/4
	d 1, -3; b 1/4
	t 2, -2; b 1/4
	d 1, -1; b 1/4
	t 0, 0; b 1/4
	d -1, -1; b 1/4
	t -2, -2; b 1/4

	t -3, -1; b 1/2
	t -5, 1; b 1/4
	t -6, 2; b 1/2
	t -4, 4; b 1/4
	t -3, 3; b 3/4
	t -3, -1; b 1/4
	d -2, -2; b 1/4
	t -1, -1; b 1/4
	d 0, 0; b 1/4
	t -1, 1; b 1/4
	d -2, 2; b 1/4
	t -3, 3; b 1/4
end

tp_chain 0, 8, 1 do
	t 1, 3; b 3/4
	t 2, -2; b 1/2
	t 0, -4; b 1/2
	t -2, -2; b 1/2
	t 0, 0; b 1/4
	d 1, 1; b 1/4
	t 2, 2; b 1/4
	d 3, 1; b 1/4
	t 4, 0; b 1/4
	d 5, 1; b 1/4
	t 6, 2; b 1/4
end

notes = group do
	tp_chain -8, -8, 1 do
		f 7, 3, :ur; b 3/4
	end
	tp_chain 0, -8, 1 do
		f 0, 2, :u; b 3/4
	end
	tp_chain 8, -8, 1 do
		f -7, 3, :ul; b 1/2
	end
end
transform(duplicate notes) { vertical_flip }
text_r

9.times do |i|
	x1, y1 = -8+3/2*(1-4*(i/8-1/2)**2), -4+8*i/8
	x2, y2 = 2+4*(i/8)**2, -7/2+7*(i/8)
	tp_chain -8, 0, 1 do
		t x1, y1
	end
	tp_chain -8*(-1)**i, 8, 1 do
		t x2*(-1)**i, y2
	end if i >= 2 && i != 8
	tp_chain 8, 0, 1 do
		t -x1, y1
	end
	b 1/2 unless i == 8
end

tp_drop 0, 8, 1 do
	b 1/2
	5.times do |i|
		x, y = i, -i
		t -x*(-1)**i, y
		t -(x+3)*(-1)**i, y+2
		b 1/4
	end
	b 1/4
end
tp_drop 0, -8, 1 do
	16.times do |i|
		x, y = [-3,-1,3,1][i%4]*(2+(1-(i/16-1/2)**2*4)*2/3), 4-8*i/16
		t x, y; b 1/8
	end
end

checkerboard 4
tp_drop 0, 12, 1 do
	([1/4]*2 + [1/6]*8 + [1/18]*3 + [1/6]*9 + [1/2]).each_with_index.reduce 0 do |sum, (delta, i)|
		x, y = -2*(-1)**i, -4 # -4+8*sum/(4-1/2)
		t x, y; b delta
		sum + delta
	end
end

tp_drop 0, -8, 1 do
	[
		88.0, -44.8, # 0
		1.4, -44.5,
		-86.9, -37.7,
		40.2, -34.9,
		-41.9, -30.4, # 1
		65.6, -23.6,
		-1.4, -19.6,
		-80.3, -8.9,
		96.8, 13.2, # 2
		65.9, -2.4,
		28.9, -6.3,
		-100, 13.2,
		-60.3, 6.7,
		-23.2, -2.9,
		75.8, 27.0,
		48.4, 17.1,
		9.3, 14.0, # 3
		-86.0, 29.9,
		-56.3, 20.2,
		-29.1, 16.6,
		47.2, 38.1,
		14.1, 45.1,
		-49.2, 41.5,
		-16.7, 43.4,
	].each_slice(2).zip([1/4]*8+[1/8]*16) do |(x, y), delta|
		t x/12.5, y/12.5; b delta
	end
end

pentagon 8
5.times do |i|
	angle = PI/2 + 2*PI/5*i
	x, y = 4*cos(angle), 4*sin(angle)
	tp_chain -x, -y, 1, relative: false do
		h x, y, 16
	end
end
b 16

t 0, 0

transform @events do
	scale 12.5
end
check

end
