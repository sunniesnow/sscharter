include Math
Integer.alias_method :/, :quo
module Math
	def linspace a, b, n
		Array.new(n) { a + (b-a)/(n-1) * _1 }
	end
end

Sunniesnow::Charter.open 'special' do

title 'GOODRAGE'
artist 'EBIMAYO'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '14'
difficulty_sup ''

offset 0.081
bpm 222

def pattern ending = false
	group do
		turntable 1
		tp_chain -100, 0, 1 do
			h -50/sqrt(2), -50/sqrt(2), 1
		end
		tp_drop 100, 0, 1 do
			f 50/sqrt(2), -50/sqrt(2), :right; b 1
			f 0, 0, :up; b 1
		end
		tp_chain 50, 25, 0.5 do
			t 0, 50; b 1/4
			t -25, 37.5; b 1/4
			t -50, 25; b 1/4
		end
		notes = tp_chain 50, 50, 0.5 do
			t 0, 0; b 1/4
			t -12.5*sqrt(3), -12.5; b 1/4
			t 0, -25; b 1/4
			t -12.5*sqrt(3), -37.5; b 1/4
			t 0, -50; b 1/4
		end
		transform notes do
			rotate PI/12
			translate 0, 12.5
		end

		turntable 3/2
		tp_chain 100, 0, 1 do
			h 50/sqrt(2), -50/sqrt(2), 1
		end
		tp_chain -100, 0, 1 do
			f -50/sqrt(2), -50/sqrt(2), :left; b 3/2
		end
		if ending
			tp_drop 0, 100, 1 do
				t 0, 0; b 1
			end
			notes = tp_drop -100, 100, 1 do
				f -50, 0, :up_left; b 3/2
			end
			transform duplicate notes do
				horizontal_flip
			end
		else
			tp_chain -100, 0, 1 do
				f 0, 0, :up; b 5/2
			end
		end
	end
end

pattern
transform pattern true do
	horizontal_flip
end
pattern

turntable 4
def on_circle quarter
	t -50*sin(s*PI/8), 50*cos(s*PI/8)
end
tp_drop 0, 0, 0.5, relative: false, preserve_beat: false do
	'112223122112222222'.chars.map(&:to_i).reduce 0 do |s, delta|
		t -50*sin(s*PI/8), 50*cos(s*PI/8)
		b delta/4
		s += delta
	end
end
'44221111'.chars.map(&:to_i).reduce 0 do |s, delta|
	tp_chain -50*sin(s*PI/4), 50*cos(s*PI/4), 0.5 do
		t 0, 0; b delta/2
	end
	s += delta
end

def lf y
	tp_chain -100, 0, 1 do
		f -50, y, :left
	end
end
def rf y
	tp_chain 100, 0, 1 do
		f 50, y, :right
	end
end
def pattern ending = false
	group do
		tp_chain 100, 0, 1, preserve_beat: false do
			t 50, -50; b 1
			lf 25; b 1
			t 50, 50; b 1
			lf 0; b 1
			t 50, -50; b 1
			lf -25; b 1
			t 50, 50; b 1/2
			if ending
				lf 0; b 1/2
				rf 0; b 1/2
				lf 12.5; b 1/2
			else
				lf 0; b 1
				rf 12.5; b 1/2
			end
		end
		tp_drop 0, 100, 1 do
			t -50, -50; b 1
			f 0, 0, :up; b 1
		end
		tp_chain 0, 100, 1 do
			8.times do |i|
				next b 1/4 if i == 4
				t -25*(-1)**i-25+(i-4).abs*6.25, 50-12.5*i; b 1/4
			end
		end
		tp_drop -100, 0, 1 do
			t -50, -50; b 3/2
		end
		tp_drop 0, 100, 1 do
			if ending
				t -18.75, -12.5; b 1
				t 18.75, 12.5; b 3/2
			else
				f 0, 0, :up; b 5/2
			end
		end
	end
end
pattern
notes = group do
	pattern true
	pattern
end
transform notes do
	horizontal_flip
end

hexagon 6
def pattern mirror = false
	tp_chain 100, 100, 1, preserve_beat: false do
		t -50/sqrt(3), 50; b 1/2
		t -75/sqrt(3), 25 unless mirror; b 1/2
		t -100/sqrt(3), 0; b 1/2
		t -75/sqrt(3), -25 unless mirror; b 1/2
		t -50/sqrt(3), -50; b 1/2
		t -75/sqrt(3), -25 if mirror; b 1/2
		t -100/sqrt(3), 0; b 1/2
		t -75/sqrt(3), 25 if mirror; b 1/2

		t -50/sqrt(3), 50; b 1/2
		t -25/sqrt(3), 25; b 1/2
		t -50/sqrt(3), 0; b 1/2
		t -25/sqrt(3), -25; b 1/2
		b 1/4 if mirror
		t 0, -50; b 1/2
		t 0, -25; b 1/2
	end
end
pattern
transform pattern true do
	rotate PI
end
b 7
h 0, 0, 1/2, 'WHAT'; b 1

diamond_grid 15
group preserve_beat: false do
	8.times do
		(-100..100).step 25 do |x|
			bg_note x, 50;
			bg_note x, -50;
		end
		b 1
		(-50..50).step 25 do |y|
			bg_note -100, y;
			bg_note 100, y;
		end
		b 1
	end
end
tp_drop -100, 0, 1, preserve_beat: false do
	8.times do |i|
		t 75, 0; b 1
	end
	8.times do |i|
		t -75, 0; b 1
	end
end
tp_drop 0, -100, 1, preserve_beat: false do
	b 7+1/2
	t 50, 0; b 1/2

	b 6+1/2
	t -50, 0; b 1/4
	t -62.5, 12.5; b 1/4
	b 1/2
	t -87.5, -25; b 1/2
end
16.times do |i|
	notes = group do
		4.times do |j|
			break b 3/8 if j == 1 && i == 14
			if j == 0
				f 0, 0, :left
			else
				d -20*j, 0
			end
			b 1/8
		end
	end
	transform notes do
		rotate PI/2*i+3*PI/4
	end
	b 1/2
end

def rotating_pattern n = 48
	notes = group preserve_beat: false do
		positions = []
		(-100...100).step(25) { positions.push [_1, 50] }
		(-50...50).step(25) { positions.push [100, -_1] }
		(-100...100).step(25) { positions.push [-_1, -50] }
		(-50...50).step(25) { positions.push [-100, _1] }
		n.times do |i|
			bg_note *positions[i % positions.size]; b 1/4
		end
	end
	transform duplicate notes do
		rotate PI
	end
end
rotating_pattern
notes = tp_chain 0, 0, 0.1 do
	linspace(12.5, 75, 8).zip(linspace 12.5, 50, 8).each_with_index do |(x, y), i|
		if i % 2 == 1
			x *= -1
			y *= -1
		end
		t x, y; b 1/2
		t x, -y; b 1/2
	end
end
transform duplicate notes do
	rotate PI
end
linspace(75, 12.5, 16).zip(linspace 50, 12.5, 16).each_with_index do |(x, y), i|
	note = tp_chain 0, 100, 0.5, relative: false do
		t x, y; b 1/4
	end
	transform note do
		horizontal_flip if i % 2 == 1
		vertical_flip if i % 4 == 1 || i % 4 == 2
	end
end

def right_after_the_break_drop
	'2121213'.chars.map(&:to_i).zip(%w[RIGHT AF TER THE BREAK] + ['', 'DROP']).reduce 0 do |s, (delta, text)|
		bg_note 18.75*(s-9/2), 0, text; b delta/3
		s += delta
	end
end
right_after_the_break_drop

def verse ending = false; group do
def pattern
	group do
		note = tp_chain -100, 0, 1 do
			h -37.5, -50, 1/2; b 1
		end
		transform duplicate note do
			horizontal_flip
		end
		tp_drop 0, -100, 1 do
			f -12.5, -37.5, :up; b 1/2
			f 12.5, -37.5, :up; b 1/2
		end
		checkerboard 3/2
	end
end
pattern
group preserve_beat: false do
	b 1/4; f -37.5, 0, :up_right; b 3/4
end
tp_drop -100, 100, 1 do
	f -56.25, 12.5, :up_right; d -56.25, 12.5; b 1/2
	f -18.75, 12.5, :up_right; b 1/2
	f 18.75, 12.5, :up_right; b 1/2
	f 56.25, 12.5, :up_right; b 1/2
end

def ornamental
	group preserve_beat: false do
		5.times do |i|
			5.times do |j|
				group preserve_beat: false do
					b 2 if (i + j) % 2 == 0
					bg_note -100+25*i, -50+25*j
				end
			end
		end
	end
end
ornamental
def flick_pattern1; group do
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		f 75, 50, :left; b 3/2
		f 75, 12.5, :left; b 1
		f 75, -12.5, :left; b 1
		f 75, -37.5, :left; b 1/2
	end
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		b 1; f 100, 25, :right; b 2
		f 100, -25, :right; b 1
	end
end; end
flick_pattern1
group do
	t 100, 50; b 2
	t 100, 0; d 100, 0; b 2
end

transform pattern do
	horizontal_flip
end
tp_drop 100, 100, 1 do
	f 37.5, 12.5, :up_left; d 37.5, 12.5; b 1/2
	f 0, 12.5, :up_left; b 1/2
	f -37.5, 12.5, :up_left; b 1
end

transform ornamental do
	horizontal_flip
end
def flick_pattern2; group do
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		f -75, 50, :right; b 3/4
		f -75, 31.25, :right; b 3/4
		f -75, 12.5, :right; b 1
		f -75, -12.5, :right; b 3/2
	end
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		b 1/2; f -100, 37.5, :left; b 1/2
		f -100, 25, :left; b 1
		f -100, 0, :left; b 1
		f -100, -25, :left; b 1
	end
end; end
flick_pattern2
group do
	t -100, 50; b 2
	d -100, 0; b 2
end

pattern
group preserve_beat: false do
	b 1/4; f -37.5, 0, :up_right; b 3/4
end
tp_drop -100, 100, 1 do
	f -56.25, 12.5, :up_right; d -56.25, 12.5; b 1/2
	f -18.75, 12.5, :up_right; b 1/2
	f 18.75, 12.5, :up_right; b 1/2
	f 56.25, 12.5, :up_right; b 1/2
end

ornamental
def flick_pattern3; group do
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		f 75, 50, :left; b 3/2
		f 75, 12.5, :left; b 1
		f 75, -12.5, :left; b 1
	end
	tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
		b 1; f 100, 25, :right; b 1
		f 100, 0, :right; b 1
		f 100, -25, :right; b 1
	end
end; end
flick_pattern3
group do
	t 100, 50; b 2
	d 100, 0; b 2
end

tp_drop 100, 0, 1, preserve_beat: false do
	2.times do
		h 75, -50, 1; b 2
		f 75, 25, :up; tp_none { d 75, 25 }; b 2
	end
end
diamond_grid 6
tp_chain 0, 100, 1 do
	t -75, 50; b 1/2
	t -87.5, 18.75; b 1/2
	t -87.5, -18.75; b 1/2
	t -75, -50; b 1/2
	t -37.5, -50; b 1/2
	t -25, -18.75; b 1/2
	t -25, 18.75; b 1/2
	t -37.5, 50; b 1/2

	t -75, 50; b 1/2
	t -62.5, 18.75; b 1/2
	t -50, -18.75; b 1/2
	t -37.5, -50; b 1/2
	t -37.5, 50; b 1/2
	t -25, 18.75; b 1/2
	if ending
		big_text 1/2, "\u2713"
		bg_note 12.5, 0, 'CHEK'; b 1/2
		bg_note -12.5, 0, 'IT'; b 1/2
	else
		t -12.5, -18.75; b 1/2
		t 0, -50; b 1/2
	end
end
end; end

verse
transform verse true do
	horizontal_flip
end

def verse second = false; group do
def pattern
	notes = tp_drop -100, 0, 1 do
		h -25, -50, 1/2; b 1
		t -25, -25; b 1/2
		t -25, -25; b 1/2
	end
	transform duplicate notes do
		horizontal_flip
	end
	grid 3/2
	tp_drop -100, 0, 1 do
		f -25, 50, :down_left; tp_none { d -25, 50 }
	end
end
pattern
tp_chain -100, 0, beat_speed: 100 do
	t -100, 12.5; b 1/4
	t -75, 12.5; b 1/4
	t -50, 12.5; b 1/2
	t 0, 12.5; b 1/2
	t 50, 12.5; b 1/2
end

def ornamental
	notes = group preserve_beat: false do
		2.times do |i|
			5.times do |j|
				group preserve_beat: false do
					b 2 if (i + j) % 2 == 0
					bg_note -100+25*i, -50+25*j
				end
			end
		end
	end
	transform duplicate notes do
		horizontal_flip
	end
end
ornamental
tp_drop 100, 0, 1, preserve_beat: false do
	h 25, -50, 1/2; b 2
	checkerboard 1/2
	f 25, 50, :down_right; tp_none { d 25, 50 }; b 2
end
tp_chain 100, 0, beat_speed: 25 do
	t 50, -12.5; b 1
	t 25, -12.5; b 1/2
	if second
		t 12.5, -12.5; b 1/2
		t 0, -12.5; b 1/2
		t -12.5, -12.5; b 1/2
		t -25, -12.5; b 1
	else
		t 12.5, -12.5; b 1
		t -12.5, -12.5; b 1/2
		t -25, -12.5; b 1/2
		t -37.5, -12.5; b 1/2
	end
end
end; end

verse

pattern
tp_chain 100, 0, beat_speed: 100 do
	t 100, 12.5; b 1/2
	t 50, 12.5; b 1/2
	h 0, 12.5, 1/2; b 1
end

ornamental
tp_drop 100, 0, 1, preserve_beat: false do
	h 25, -50, 1/2; b 2
	checkerboard 1/2
	f 25, 50, :down_right; tp_none { d 25, 50 }; b 2
end
tp_chain -100, 0, beat_speed: 50 do
	t -100, -12.5; b 1/2
	t -75, -12.5; b 1/4
	t -62.5, -12.5; b 1/4
	t -50, -12.5; b 1/2
	t -25, -12.5; b 1/2
	t 0, -12.5; b 1/2
	t 25, -12.5; b 1/2
	h 50, -12.5, 1/2; b 1
end

verse true

group preserve_beat: false do
	2.times do
		tp_chain 0, -100, 1 do
			h 0, -50, 1; b 2
		end
		tp_chain 0, 100, 1 do
			f 0, 50, :up; d 0, 50; b 2
		end
	end
end
positions = linspace(12.5, 87.5, 4).zip linspace 12.5, 37.5, 4
group do
	tp_chain -100, 0, 1 do
		positions.reverse_each { |(x,y)| t -x, y; b 1/2 }
		positions.each { |(x,y)| t x, y; b 1/2 }
	end
	tp_chain 100, 0, 1 do
		positions.reverse_each { |(x,y)| t x, -y; b 1/2 }
		positions.each { |(x,y)| t -x, -y; b 1/2 }
	end
end
positions = [*positions.reverse.map { |(x,y)| [x, -y] }, *positions.map { |(x,y)| [-x, -y] }]
positions = Array.new 15 do |i|
	next positions[i/2] if i % 2 == 0
	i /= 2
	(x1, y1), (x2, y2) = positions[i], positions[i+1]
	[(x1+x2)/2, (y1+y2)/2]
end
[0, 7, 8, 11, 14].each do |i|
	group preserve_beat: false do
		b -4+i/4; d *positions[i]
	end
end

def position time
	x = (time/4).floor*25 - 87.5
	dy = (time%4)*25
	y = time % 8 < 4 ? 50 - dy : -25 + dy
	[x, y]
end
def pattern drag_points, tap_points
	tp_chain 0, 100, 1 do
		tap_points.each do |time|
			group preserve_beat: false do
				b time/4; t *position(time)
			end
		end
		drag_points.each do |time|
			group preserve_beat: false do
				b time/4; d *position(time)
			end
		end
	end
	group preserve_beat: false do
		(-87.5..87.5).step(25) do |x|
			(-25..50).step(25) do |y|
				bg_note x, y
			end
			b 1
		end
	end
	4.times do |i|
		tp_drop (i % 2 == 0 ? -200 : 200), 0, 1.5 do
			b 1/2
			3.times { t 0, -50; b 1/2 }
		end
	end
end
pattern [0,  4, 6, 8,9,10, 12, 14, 16,  20, 22,  26, 28, 30], (0...8).map { _1*4 } + [30]
pattern [0,  4, 6, 8, 10, 12,  16,17,18, 20, 22, 24, 26, 28], (0...8).map { _1*4 } + [26, 30]
pattern [0,  4, 6, 8,9,10, 12, 14, 16,  20, 22, 24, 26, 28], (0...16).map { _1*2 }

grid 7
tp_chain 0, 100, 1 do
	time = 0
	(-87.5..87.5).step(50) do |x|
		(-25..50).step(25).reverse_each do |y|
			bg_note x, y, 8-time+time/16
			t x, y; d x, y if y == 0; b 1/4
			time += 1/4
		end
		(-25..50).step(25) do |y|
			bg_note x+25, y, 8-time+time/16
			t x+25, y; d x+25, y if y == -25 || y == 25; b 1/4
			time += 1/4
		end
	end
end

h 0, 0, 15; b 8

tp_chain 0, 100, 1 do
	h -75, 0, 1/2; b 3/2
	t -50, 25; b 1
	t -62.5, -25; b 1/2
	t -50, -12.5; b 1/2
	h -37.5, 0, 1/2; b 1/2

	b 1/2
	t 12.5, 25; b 1/2
	t 37.5, 25; b 1/2
	h 50, 12.5, 1/2; b 1
	t 75, 25; b 1/2
	h 100, 25, 1/2; b 1
end

tp_chain 0, 100, 1 do
	h -50, -25, 1; b 3/2
	t -87.5, 12.5; b 1/2
	t -37.5, 0; b 1/4
	t -50, 12.5; b 1/4
	t -37.5, 25; b 1/4
	t -50, 37.5; b 1/4
	t -37.5, 50; b 1/2
	h 0, 37.5, 1/2; b 1/2

	b 1/2
	t 37.5, 25; b 1/2
	t 50, 50; b 1/2
	t 75, 37.5; b 1/4
	t 62.5, 25; b 1/4
	t 75, 12.5; b 1/2
	t 25, 12.5; b 1/4
	t 37.5, 0; b 1/4
	t 25, -12.5; b 1/2
	t 62.5, -12.5; b 1/4
	t 50, -25; b 1/4

	t 62.5, -37.5; b 1/2
	t 37.5, -50; b 1/2
	t 12.5, -37.5; b 1/2
	t -12.5, -25; b 1/2
	t -37.5, -12.5; b 1/2
	t -25, 12.5; b 1/2
	t -12.5, 37.5; b 1/2
	t 12.5, 25; b 1/2
end

tp_drop 100, 0, 1 do
	h 37.5, 37.5, 1/2; b 1
	4.times { t 37.5, 37.5; b 1/2 }
	4.times { t 37.5, 37.5; b 1/4 }
end

grid 31
def kick
	t -62.5, -50
end
def snare
	f -50, 25 - beat % 2 * 25, :left
end
tp_drop -100, 0, 1, preserve_beat: false do
	2.times do |i|
		3.times do
			kick; b 1
			snare; b 1
		end
		kick; b 1/2
		snare; b 1/2
		snare if i == 1; b 1/2
		snare; b 1/2
	end
end
def pattern
	h 12.5, 12.5, 1; b 3/2
	t -12.5, 0; b 1/2
	f -25, -25, :down_right; b 1/4
	d -12.5, -37.5; b 1/4
	d 0, -25; b 1/4
	d 12.5, -12.5; b 1/4
	d 25, 0; b 1/2
	h 37.5, 0, 1/2; b 1/2

	b 1/2
	t 62.5, 25; b 1/2
	t 87.5, 50; b 1/2
	f 50, 25, :down_right; b 1/4
	d 62.5, 12.5; b 1/4
	d 75, 25; b 1/2
	f 50, 0, :down_left; b 1/4
	d 37.5, -12.5; b 1/4
	d 25, 0; b 1/2
	f 25, -25, :down_right; b 1/4
	d 37.5, -37.5; b 1/4
end
tp_chain 0, 100, 1 do
	pattern

	d 50, -25; b 1/2
	h 25, -50, 1/2; b 1
	t 0, -37.5; b 3/2
	t -25, -25; b 1/2
	h 0, -12.5, 1/2; b 1/2

	b 1/2
	t 25, -25; b 1/2
	t 25, 25; b 1/2
	h 50, 12.5, 1/2; b 1
	t 75, 25; b 1/2
	h 100, 25, 1/2; b 1
end

def kick
	t 62.5, -50
end
def snare
	f 50, 25 - beat % 2 * 25, :right
end
tp_drop 100, 0, 1, preserve_beat: false do
	3.times do
		kick; b 1
		snare; b 1
	end
	kick; b 1/2
	snare; b 1
	snare; b 1/2

	kick; b 1
	3.times { snare; b 1 }

	4.times { snare; b 1/2 }
	(0...50).step 12.5 do |y|
		y == 0 ? f(75, y, :up) : d(75, y); b 1/4
	end
	b 1
end
notes = tp_chain 0, 100, 1 do
	pattern

	d 50, -25; b 1/2
	t 75, -37.5; b 1/2
	t 100, -50; b 1/2
	t 37.5, 0; b 1/2
	t 62.5, -12.5; b 1/2
	t 87.5, -25; b 1/2
	t 25, 25; b 1/2
	t 50, 12.5; b 1/2
end
transform notes do
	horizontal_flip
end

tp_drop 0, 100, 1 do
	h -75, 25, 1/2; b 1
	4.times { t -75, 25; b 1/2 }
end
h 0, 0, 1/2, 'WHAT'; b 1

def verse; group do
def pattern
	notes = tp_drop -100, 0, 1 do
		h 100, -50, 1/2; b 1
		2.times { t 100, -25; b 1/2 }
	end
	transform duplicate notes do
		horizontal_flip
	end
	hexagram 3/2
end
def draw_hexagram positions, rhythm
	group preserve_beat: false do
		t 0, 0; b 2
		t 0, 0
	end
	tp_drop 0, 0, 0.5, relative: false do
		positions.chars.map(&:to_i).zip(rhythm.chars.map(&:to_i)) do |position, delta|
			angle = PI/2 + PI/3*position
			f 50*cos(angle), 50*sin(angle), (angle/(PI/4)).round*PI/4+PI; b delta/4
		end
	end
end
pattern
draw_hexagram '02415', '11222'

def ornamental
	notes = group preserve_beat: false do
		3.times do |i|
			radius = i*25
			vertices = Array.new(3) do |j|
				angle = 2*PI/3*j - PI/2
				[radius*cos(angle), radius*sin(angle)]
			end
			3.times do |j|
				(x1, y1), (x2, y2) = vertices[j], vertices[(j+1)%3]
				(2*i).times do |k|
					x = x1 + (x2-x1)*k/(2*i)
					y = y1 + (y2-y1)*k/(2*i)
					bg_note x, y
				end
			end
		end
	end
	transform duplicate notes do
		vertical_flip
		beat_translate 2
	end
end
def ornamental2; group do
	3.times do |i|
		5.times do |j|
			group preserve_beat: false do
				b 2 if (i + j) % 2 == 0
				bg_note -100+25*i, -50+25*j
			end
		end
	end
end; end
transform flick_pattern1 do
	horizontal_flip
	translate 175, 0
end
tp_chain -150, 0, beat_speed: 25 do
	ornamental2
	b 2
	t 50, 0
	ornamental
	b 2
end

pattern
draw_hexagram '240', '224'

tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
	b 3/4
	f -75, 31.25, :right; b 3/4
	f -75, 12.5, :right; b 1
	f -75, -12.5, :right; b 3/2
end
tp_chain 0, 100, beat_speed: 25, preserve_beat: false do
	f -100, 50, :left; b 1/2
	f -100, 37.5, :left; b 1/2
	f -100, 25, :left; b 1
	f -100, 0, :left; b 1
	f -100, -25, :left; b 1
end
tp_chain 150, 0, beat_speed: 25 do
	transform(ornamental2) { horizontal_flip }
	b 2
	t -50, 0
	ornamental
	b 2
end
end; end

verse
transform verse do
	horizontal_flip
end

rotating_pattern
linspace(37.5, 12.5, 4).each do |y|
	tp_chain 0, 100, 0.5, preserve_beat: false do
		t y-50, y; b 1/2
		t y-50, -y; b 1/2
	end
	tp_chain 0, -100, 0.5 do
		t -y-50, -y; b 1/2
		t -y-50, y; b 1/2
	end
	tp_chain 0, 100, 0.5, preserve_beat: false do
		t -y+50, y; b 1/2
		t -y+50, -y; b 1/2
	end
	tp_chain 0, -100, 0.5 do
		t y+50, -y; b 1/2
		t y+50, y; b 1/2
	end
end

notes = group do
	linspace(12.5+6.25, 37.5-6.25, 4).each_with_index do |y, i|
		x = y*(-1)**(i % 2)
		tp_chain 100*(-1)**(i % 2), 100, 0.5 do
			t -50+x, y; b 1/2
			t -50-x, -y; b 1/2
		end
	end
end
transform duplicate notes do
	beat_translate 1/4
	horizontal_flip
end

bg_note -37.5, 0, 'SPIN'; b 1
bg_note -12.5, 0, 'IT'; b 1
bg_note 12.5, 0, 'BACK'; b 1
bg_note 37.5, 0, 'NOW'; b 1

def pattern1_a; group do
	h -87.5, -25, 1/2; b 1
	t -50, -12.5; b 1/2
	t -62.5, 12.5; b 1/2
	t -25, -12.5; b 1/4
	t 12.5, 0; b 1/4
	t -12.5, 12.5; b 1/4
	t 25, 25; b 1/4
	t 37.5, 37.5; b 1/2
	h 62.5, 50, 1/2; b 1/2

	b 1/2
	t 37.5, 0; b 1/2
	f 62.5, -25, :right; b 1/2
	t -37.5, -25; b 1/4
	t -50, -12.5; b 1/4
	f -62.5, 0, :left; b 1/2
	t 37.5, 0; b 1/4
	t 50, 12.5; b 1/4
	f 62.5, 25, :right; b 1/2
	t -37.5, 25; b 1/4
	t -50, 37.5; b 1/4
end; end
def pattern1_b; group do
	t 50, -50; b 1/2
	t 62.5, -25; b 1/2
	t 62.5, 12.5; b 1/2
	t 50, 37.5; b 1/2
	b 1
	t -50, 50; b 1/2
	t -62.5, 25; b 1/2

	t -62.5, -12.5; b 1/2
	t -50, -37.5; b 1/2
	t -12.5, -50; b 1
	t 12.5, -25; b 1
	t -12.5, 0; b 1
end; end
tp_chain 0, 200, 1, preserve_beat: false do
	pattern1_a
	
	f -62.5, 50, :left; b 1/2
	t -87.5, 25; b 1/2
	t -62.5, 12.5; b 1/2
	h 87.5, 12.5, 1/2; b 1
	t -25, -50; b 1/2
	t 0, -25; b 1/2
	h -25, 25, 1/2; b 1/2

	b 1/2
	t -50, 12.5; b 1/2
	t -75, 37.5; b 1/2
	h -100, 25, 1/2; b 1
	t 50, 0; b 1/2
	h 75, 12.5, 1/2; b 1
end
tp_chain 0, 200, 1 do
	pattern1_b
	
	t 12.5, 25; b 1/2
	t 50, 50; b 1/2
	t 62.5, 25; b 1/2
	t -75, -12.5; b 1/2
	t -50, -37.5; b 1/2
	t 50, -50; b 1/2
	t 62.5, -25; b 1/2
	t 62.5, 12.5; b 1/2

	t 50, 37.5; b 1/2
	t 25, 50; b 1/2
	t 12.5, 25; b 1/2
	t 12.5, -12.5; b 1/2
	t 25, -37.5; b 1/2
	t -50, -25; b 1/2
	t -62.5, 0; b 1/2
	t -62.5, 37.5; b 1/2
end

def pattern3; group do
	t -62.5, -50; b 1/2
	t 50, -25; b 1/2
	t -37.5, 0; b 1/2
	t 87.5, 0; b 1/2
	t -62.5, 12.5; b 1/2
	t 37.5, 25; b 1/2
	t -25, 50; b 1/2
	t 12.5, 25; b 1/2
end; end
tp_chain 0, -200, 1, preserve_beat: false do
	transform(pattern1_a) { vertical_flip }

	pattern3
end
tp_chain 0, -200, 1 do
	transform(pattern1_b) { vertical_flip }

	transform(pattern3) { horizontal_flip }
end

diamond_grid 3
tp_drop 0, 100, 0.75 do
	16.times { t 0, 0; b 1/4 }
end

tp_chain 0, 200, 1, preserve_beat: false do
	h 62.5, -25, 1/2; b 1
	t 87.5, -37.5; b 1/2
	t 50, -50; b 1/2
	t -50, -37.5; b 1/4
	t 0, -25; b 1/4
	t -37.5, -12.5; b 1/4
	t 12.5, 0; b 1/4
	t -25, 12.5; b 1/2
	h -50, 37.5, 1/2; b 1/2

	b 1/2
	t -12.5, 25; b 1/2
	f 0, 50, :left; b 1/2
	t -25, 0; b 1/4
	t -12.5, 12.5; b 1/4
	f 0, 25, :right; b 1/2
	t 25, -25; b 1/4
	t 12.5, -12.5; b 1/4
	f 0, 0, :left; b 1/2
	t -25, -50; b 1/4
	t -12.5, -37.5; b 1/4

	f 0, -25, :right; b 1/2
	h 50, -37.5, 1/2; b 1
	t 75, -12.5; b 1/2
	t 87.5, 12.5; b 1/2
	t 87.5, 50; b 1/2
	t 62.5, 37.5; b 1/2
	h 37.5, 50, 1/2; b 1/2

	b 1/2
	t 12.5, 25; b 1/2
	t -12.5, 37.5; b 1/2
	h -37.5, 25, 1/2; b 1
	t -50, -25; b 1/2
	h -75, -12.5, 1/2; b 1

	grid 15
	h 87.5, -37.5, 1/2; b 1
	t 100, 12.5; b 1/2
	t 87.5, 37.5; b 1/2
	h -37.5, 37.5, 1/2; b 1
	t -25, -12.5; b 1/2
	t -37.5, -37.5; b 1/2

	b 1/2
	t 100, -12.5; b 1
	t 87.5, 37.5; b 1
	t -25, 12.5; b 1/2
	t -25, -12.5; b 1/2
	t -37.5, -37.5; b 1/2

	tp_none do
		4.times { h 0, 50/3, 1/2; b 1 }
	end
end
tp_chain 0, 200, 1 do
	t -62.5, -50; b 1/2
	t -75, -25; b 1/2
	t -75, 12.5; b 1/2
	t -62.5, 37.5; b 1/2
	b 1
	t 62.5, 50; b 1/2
	t 50, 25; b 1/2

	t 50, -12.5; b 1/2
	t 75, 0; b 1/2
	t 87.5, 25; b 1
	t -87.5, 0; b 1
	t 87.5, -25; b 1

	t -87.5, -50; b 1/2
	t -75, -25; b 1/2
	t -75, 12.5; b 1/2
	t -87.5, 37.5; b 1/2
	t -62.5, 25; b 1/2
	t -50, 0; b 1/2
	t -37.5, -25; b 1/2
	t -12.5, -37.5; b 1/2
	
	t 12.5, -25; b 1/2
	t 37.5, -37.5; b 1/2
	t 62.5, -50; b 1/2
	t 75, -25; b 1/2
	t 75, 6.25; b 1/2
	t 75, 37.5; b 1/2
	t 100, 25; b 1/2
	t 100, -12.5; b 1/2

	2.times do
		t -87.5, -37.5; b 1/2
		t -100, -12.5; b 1/2
		t -100, 12.5; b 1/2
		t -87.5, 37.5; b 1/2
		t 37.5, 37.5; b 1/2
		t 25, 12.5; b 1/2
		t 25, -12.5; b 1/2
		t 37.5, -37.5; b 1/2
	end

	rotating_pattern 24
	4.times do |i|
		t -75*(-1)**i, -50; b 1/2
		t -37.5*(-1)**i, 50; b 1/2
	end
end

positions = [[75, -50], [37.5, 50], [-37.5, 50], [-75, -50]]
tp_chain 0, 50/3, relative_beat: 1/2, relative: false, preserve_beat: false do
	6.times { |i| t *positions[i%4]; b 1/2 }
end
tp_chain 0, 50/3, relative_beat: 1/2, relative: false do
	6.times { |i| t *positions[(i+2)%4]; b 1/2 }
end
h 0, 0, 1/2; b 1

turntable 28
tp_chain 100, 0, 1, preserve_beat: false do
	2.times do
		t 50, 50; b 1
		t 75, -50; b 1
		t 100, 50; b 1
		t 75, -50; b 1
	end
	b -1/2; t 62.5, 0; b 1/2
	2.times do
		t -50, 50; b 1
		t -75, -50; b 1
		t -100, 50; b 1
		t -75, -50; b 1
	end
	b -3/2
	t -87.5, 0; b 1/4
	t -81.25, -25; b 1/4+1/2
	t -62.5, 0; b 1/2
end
group preserve_beat: false do
	8.times do
		(-100..100).step 25 do |x|
			bg_note x, 50;
			bg_note x, -50;
		end
		b 1
		(-50..50).step 25 do |y|
			bg_note -100, y;
			bg_note 100, y;
		end
		b 1
	end
end
16.times do |i|
	notes = group do
		4.times do |j|
			break b 3/8 if j == 1 && i == 14
			if j == 0
				f 0, 0, :left
			else
				d -50/3*j, 0
			end
			b 1/8
		end
	end
	transform notes do
		rotate PI/2*i+3/2*PI
	end
	b 1/2
end

positions = Array.new(32) { |i| [62.5*cos(PI/16*i), 62.5*sin(PI/16*i)] }
group preserve_beat: false do
	96.times do |i|
		bg_note *positions[i%32]; b 1/8
	end
end
positions = Array.new(16) { |i| [37.5*cos(PI/8*i), 37.5*sin(PI/8*i)] }
notes = group preserve_beat: false do
	b 8
	16.times do |i|
		bg_note *positions[i%16]; b 1/4
	end
end
transform(duplicate notes) { translate 75, 0 }
transform(notes) { translate -75, 0 }
notes = tp_chain 200, 0, 1, preserve_beat: false do
	24.times do |i|
		next b 1/2 if i >= 16 && i % 2 == 1
		angle = PI/4*i+PI/2
		t 50*cos(angle), 50*sin(angle); b 1/2
	end
end
transform duplicate notes do
	scale 0.5
end
b 8

1.upto 3 do |i|
	tp_chain 200, 0, 1, preserve_beat: false do
		b i/4
		4.times do |j|
			angle = PI/2 + PI/8*i + PI/2*j
			t 37.5*cos(angle), 37.5*sin(angle); b 1
		end
	end
end
b 4

right_after_the_break_drop
b -1; h 0, 0, 1/2, 'WHAT'; b 1

note = tp_chain -300, 0, 1 do
	f 0, 50, :down
end
transform(duplicate note) { rotate PI }

end
