include Math
srand 1108

Sunniesnow::Charter.open 'master' do

title 'Stasis'
artist 'Maozon'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color '#8c68f3'
difficulty '13'
difficulty_sup '+'

offset 0.107
bpm 180

def drop_x x, *ys
	ys.each { t x, _1; b 1/2r }
end
def drop_y y, *xs
	xs.each { t _1, y; b 1/2r }
end

tp_drop -100, 0, 1 do
	drop_x 50, -50, -25, 0, -50
end
tp_drop 100, 0, 1 do
	drop_x -50, 50, 25, 0, -50
end
tp_drop 0, 100, 1 do
	drop_y -50, -25, 0, 25, -25
end
tp_drop 0, -100, 1 do
	drop_y 50, 0, -25, 50, 25
end

h 0, 0, 8 - 1/2r
tp_drop -100, 0, 1 do
	drop_x 50, -50, -25, 0, -50
end
tp_drop 100, 0, 1 do
	drop_x -50, 50, 25, 0, 25
end
tp_drop 0, 100, 1 do
	drop_y -50, 0, -25, 25, 0
end
tp_drop 0, -100, 1 do
	drop_y 50, 25, 0, -25, -50
end

def bg_drop_hold x, y, duration, n = 4
	notes = group preserve_beat: false do
		h x, y, duration
		unit_x = x.to_f / n
		unit_y = y.to_f / n
		b -1
		n.times do |i|
			bg_note unit_x * i, unit_y * i, duration
			b 1r/n
		end
	end
	transform(duplicate notes) { rotate PI }
end
tp_drop 0, 0, relative: false, speed: 100 do
	grid 1
	bg_drop_hold 50, 50, 1; b 3/2r
	grid 3/2r
	bg_drop_hold -50, 50, 3/2r; b 2r
end
3.times { t 0, 0; b 1/4r }; b 1/4r

tp_drop 0, 0, relative: false, speed: 100 do
	turntable 1/2r
	bg_drop_hold 0, -50, 1/2r; b 1r
end
turntable 1
tp_drop(100, 0, 1) { d 0, 0 }
tp_drop(-100, 0, 1) { h 0, 0, 1 }
b 1
tp_chain 0, -50, speed: 100 do
	f 0, -50, :up; b 1
	t 0, 0; b 1/2r
end

tp_drop 0, 0, relative: false, speed: 100 do
	hexagon 1
	bg_drop_hold -50/sqrt(3), 50, 1; b 3/2r
	hexagon 3/2r
	bg_drop_hold 50/sqrt(3), 50, 3/2r; b 2r
end

2.times { t 0, 0; b 1/4r }
pentagon 4
h 0, 0, 4 - 1/2r
link = tp_chain 0, 0, 1/2r, relative: false do
	delta_beats = [1/2r]*3 + [1/4r]*10
	delta_beats.each_with_index do |delta, i|
		angle = 2*PI * i / delta_beats.length
		d 50 - 50*cos(angle), 50*sin(angle)
		b delta
	end
end
transform(duplicate link) { horizontal_flip }

bg_note 0, 50, 16
tp_drop 0, 50, relative: false, speed: 100 do
	1.upto 16 do |i|
		amplitude = PI/48 * i
		x = 100*sin(amplitude)
		y = 50 - 100*cos(amplitude)
		if i == 16
			f -x, y, :down_right
			f x, y, :down_left
			b 1
		else
			h x*(-1)**i, y, i == 15 ? 1/2r : 1; b 1/2r
			t 0, -50; b 1/2r
		end
	end
end
diamond_grid 8
tp_chain 25, 25, relative: false, speed: 100, preserve_beat: false do
	t -75, 12.5; b 1
	t 62.5, -37.5; b 1
	t -12.5, 25; b 1
	t 50, -50; b 1
	t -87.5, 0; b 1
	t 0, 0; b 1
	t -100, 25; b 1
	t -37.5, -37.5; b 1
end
tp_chain 25, -25, relative: false, speed: 100 do
	t -25, 12.5; b 1/2r
	t -62.5, -37.5; b 1/2r
	t 12.5, 25; b 1/2r
	t -50, -50; b 1/2r
	t 75, 0; b 1/2r
	t 0, 0; b 1/2r
	t 87.5, 25; b 1/2r
	t 37.5, -37.5; b 1/2r
	t -25, 12.5; b 1/2r
	t -62.5, -37.5; b 1/2r
	t 12.5, 25; b 1/2r
	t -50, -50; b 1/2r
	t 75, 0; b 1/2r
	t 100, 25; b 1/2r
	t -37.5, -12.5; b 1/2r
	t 0, 0; b 1/2r
end
tp_chain 0, 0, 0, relative: false do
	16.times do |i|
		x = 100*exp(-i/4r) * (-1)**i
		y = -50 + i*100.0/16
		t x, y; b 1/4r
	end
	f 0, 0, :down
end

bg_note -75, 0; b 1/2r
bg_note -50, 0; b 1/2r
bg_note -25, 0; b 1/2r
bg_note 0, 0; b 1/4r
bg_note 12.5, 0; b 1/4r
bg_note 25, 0; b 1/2r
bg_note 50, 0; b 1/2r
bg_note 75, 0; b 1

group preserve_beat: false do
	2.times do
		b 2; f 0, 0, :up; b 2
	end
	2.times do
		b 2; f 0, 0, :down; b 2
	end
	2.times do
		b 2; f 0, 0, :up; b 2
	end
	b 2; f 0, 0, :down; b 2
end
def pattern ending = false
	f 50, -50, :up_right; b 1
	b 1
	f 50, -50, :up_left; b 1
	return if ending
	f -50, -50, :up_right; b 1
	b 1/2r
	f 25, -50, :up_right; b 1
	f 0, -50, :up_left; b 1/2r
	h -75, -50, 1; b 1
end
def more_pattern ending = false
	group do
		tp_drop 0, 100, speed: 50 do
			h -75, -50, 1; b 1
			pattern
		end
		tp_chain 0, 100, speed: 100 do
			h 75, -50, 1
			1.upto 8 do |i|
				b 1/8r
				x = 75 * (i/4.0 - 1)**2
				y = -50 + 100 * i/8.0
				d x, y
			end
		end
		notes = tp_drop 0, 100, speed: 50 do
			pattern ending
		end
		transform(notes) { rotate PI }
	end
end
more_pattern
transform(more_pattern true) { horizontal_flip }

turntable 4
tp_chain 0, 100, 1, relative: false do
	16.times do |i|
		y = -40 + 80 * (1-i/16.0)**2
		x = sqrt(50**2 - y**2) * (-1)**i
		t x, y; b 1/4r
	end
end

group preserve_beat: false do
	tp_drop 0, 100, 1 do
		16.times { t 0, -50; b 1/2r }
	end
	tp_drop 0, -100, 1 do
		12.times { t 0, 50; b 1/2r }
	end
	b 2
	tp_drop 0, 100, 1 do
		16.times { t 0, -50; b 1/2r }
	end
	tp_drop 0, -100, 1 do
		8.times { t 0, 50; b 1/2r }
	end
end
def pattern ending = 0
	group do
		b 1
		f -75, 0, :up; b 1
		b 1
		f -75, 0, :up; b 1
		next if ending == 2
		f -75, 0, :up; b 3/2r
		t -75, 0; b 1/2r
		next if ending == 1
		t -75, -25; b 1/2r
		t -75, 0; b 1/2r
		f -75, 25, :up; b 1
	end
end
pattern
transform(pattern 1) { horizontal_flip }
group preserve_beat: false do
	3.times do |i|
		hexagon 1/2r
		angle = PI/3 * i
		x = 100/sqrt(3) * sin(angle)
		y = 100/sqrt(3) * cos(angle)
		tp_chain(0, 0, 0.5, relative: false) { h x, y, 1/2r }
		tp_chain(0, 0, 0.5, relative: false) { h -x, -y, 1/2r }
		b 3/4r
	end
end
b 2
h -75, -25, 3/4r
pattern
transform(pattern 2) { horizontal_flip }

group preserve_beat: false do
	b 1
	t -50, -25; b 1/2r
	t -25, -25; b 1/2r
	t 0, -25; b 1/2r
	t 25, -25; b 1/2r
	t 50, -25; b 1/2r
end
bg_note -75, 0; b 1/2r
bg_note -50, 0; b 1/4r
bg_note -37.5, 0; b 1/4r
bg_note -25, 0; b 1/2r
bg_note 0, 0; b 1/2r
bg_note 25, 0; b 1/2r
bg_note 50, 0; b 1/2r
bg_note 75, 0; b 1

def pattern ending = false
	group do
		tp_chain 0, 100, speed: 100, preserve_beat: false do
			t -100, -25; b 1/2r
			t -75, -50; b 1/2r
			t -50, -25; b 1/2r
			t -25, 0; b 1/2r
			t -0, 25; b 1/2r
			t -25, -25; b 1/2r
			t -50, 50; b 1/2r
			t -75, 25; b 1/2r
			b 1/2r
			t -75, 0; b 1/2r
			t -50, 25; b 1/2r
			t -25, 50; b 1/2r
			b 1/2r
			t -75, -25; b 1/2r
			t -50, 0; b 1/2r
			t -25, 25; b 1/2r

			t -100, 0; b 1/2r
			t -75, -25; b 1/2r
			t -50, 0; b 1/2r
			t -25, 25; b 1/2r
			t -0, 50; b 1/2r
			t -25, 25; b 1/2r
			t -50, 50; b 1/2r
			t -75, 25; b 1/2r
			b 1/2r
			t -25, 50; b 1/2r
			t -50, 0; b 1/2r
			t -75, 25; b 1/2r
			t -100, 25; b 1/2r
			t -75, 0; b 1/2r
			t -50, -25; b 1/2r
			h -25, 50, 3/2r #
			t 100, -50
			b 1/2r

			b 1/2r
			t 75, -50; b 1/2r
			t 50, -25; b 1/2r
			t 25, 0; b 1/2r
			t 0, 25; b 1/2r
			t 25, 0; b 1/2r
			t 50, 50; b 1/2r
			t 75, 25; b 1/2r
			b 1/2r
			t 75, 25; b 1/2r
			t 50, 0; b 1/2r
			t 25, 25; b 1/2r
			b 1/2r
			t 75, 0; b 1/2r
			t 50, 25; b 1/2r
			h 25, -50, 3/2r #
			t -75, 50; b 1/2r
			b 1/2r

			t -75, 25; b 1
			t -25, 25; b 1/2r
			t -0, 50; b 1/2r
			t -25, 25; b 1/2r
			t -50, 0; b 1/2r
			t -75, 25; b 1/2r
			b 1/2r
			t -75, -25; b 1/2r
			t -50, 25; b 1/2r
			t -25, -50; b 1/2r
			notes = group do
				t -0, 25; b 1/2r
				t -25, 0; b 1/2r
				t -50, -25; b 1
			end
			transform(notes) { horizontal_flip } if ending
		end
		tp_chain 0, 100, speed: 100 do
			h 75, -50, 1; b 2
			f 50, 0, :up; b 2
			h 25, -50, 1; b 2
			f 50, 0, :down; b 2

			h 75, -50, 1; b 2
			f 50, 0, :up; b 2
			h 25, -50, 1; b 2
			f 50, 0, :down; b 3/2r
			d -25, 50; b 1/2r

			b 2
			f -50, 0, :up; b 2
			h -75, -50, 1; b 2
			f -50, 0, :down; b 3/2r
			d 25, -50; b 1/2r

			next b 8 if ending
			b 2
			f 50, 0, :up; b 2
			h 75, -50, 1; b 2
			f 50, 0, :down; b 2
		end
	end
end
group preserve_beat: false do
	grid 16
	b 16 - 1/2r
	diamond_grid 8 + 1/2r
	b 8
	grid 8 - 1/2r
end
pattern
group preserve_beat: false do
	diamond_grid 16
	b 16 - 1/2r
	grid 8 + 1/2r
	b 8
	diamond_grid 4 + 1/2r
end
transform(pattern true) { horizontal_flip }

def bg_pattern
	tp_drop 0, 100, 1, preserve_beat: false do
		[
			-50, -25, 0, -50, 50, 25, 0, -75, -50, -25, 0, -75, 52, 25, 75, 50,
			-50, -25, 0, -25, 50, 25, 0, 50, 75, 0, 100, -25, 75, -50, 50, -75
		].each do |x|
			bg_note x, -50
			b 1/2r
		end
	end
end
bg_pattern
notes = tp_chain 0, 0, relative: false, speed: 100, preserve_beat: false do
	f -100, 0, :left
	b 15
	d 0, 0
end
transform(duplicate notes) { horizontal_flip }
b 15
tp_chain 0, 25, speed: 100, relative: false do
	f 0, 37.5, :down
	b 1
end

bg_pattern
turntable 16
64.times do |i|
	angle = 2*PI * i/16.0
	x = 200 * sin(angle)
	y = 200 * cos(angle)
	tp_chain x, y, speed: 50 + 100*i/64.0, relative: false do
		d 0, 0
	end
	b 1/4r
end

group preserve_beat: false do
	15.times do |i|
		turntable 3/4r
		b 1
	end
	grid
end
32.times do |i|
	angle = 2*PI * (i+64)/32.0
	x = 200 * sin(angle) * (-1)**i
	y = 200 * cos(angle)
	tp_chain x, y, speed: 150 + 50*i/32.0, relative: false do
		i % 4 == 0 ? t(0, 0) : d(0, 0)
	end
	b 1/4r
end
28.times do |i|
	angle = 2*PI * (i+96)/32.0
	x = 200 * sin(angle) * (-1)**i
	y = 200 * cos(angle)
	tp_chain x, y, speed: 200 + 50*i/32.0, preserve_beat: false, relative: false do
		i % 4 == 0 ? t(0, 0) : d(0, 0)
		if i % 4 == 0
			j = i/4
			b (28-i)/4r + j/32r
			nx = -50
			ny = 50 - 100/8.0*j
			j == 0 ? f(nx, ny, :down) : d(nx, ny)
		elsif i % 4 == 2
			j = i/4
			b (28-i)/4r + j/32r
			nx = 50
			ny = 50 - 100/8.0*j
			j == 0 ? f(nx, ny, :down) : d(nx, ny)
		end
	end
	b 1/4r
end
b 1

def outward_drop &block
	tp_chain 0, 0, speed: 100, preserve_beat: false, relative: false, &block
end
def pattern angle
	r = 37.5*sqrt(2)
	x = r * cos(angle)
	y = r * sin(angle)
	group preserve_beat: false do
		4.times { outward_drop { t x, y }; b 1/2r }
	end
	outward_drop do
		t -x, -y; b 1/2r
		3.times { d -x, -y; b 1/2r }
	end
	b 2
end
checkerboard 12
pattern PI/4*3
pattern PI/4
pattern -PI/4
pattern -PI/4*3
([[1,1], [-1,1]]*2 + [[1,-1], [-1,-1]]*2 + [[1,1], [-1,1], [1,-1], [-1,-1]]*2).each do |(x, y)|
	outward_drop { t x*37.5, y*37.5 }
	b 1/4r
end
b 4

pentagon 15
tp_chain 0, 100, 1, relative: false do
	h 0, 0, 1
	b 1
	1.upto 15 do |i|
		end_angle = PI/2 + 4*PI/5 * i
		start_angle = end_angle - 4*PI/5
		start_x = 50 * cos(start_angle)
		start_y = 50 * sin(start_angle)
		end_x = 50 * cos(end_angle)
		end_y = 50 * sin(end_angle)
		direction = atan2 end_y - start_y, end_x - start_x
		direction = (direction / (PI/4)).round * PI/4
		f start_x, start_y, direction
		next b 1/2r if i == 15
		1.upto 3 do |j|
			b 1/4r
			d start_x + (end_x - start_x) * j/4.0, start_y + (end_y - start_y) * j/4.0
		end
		b 1/4r
	end
end
t -100, 0
t 100, 0
b 1/2r

hexagon 12
tp_chain 0, 100, 1, relative: false do
	h 0, 0, 1
end
b 1
group preserve_beat: false do
	1.upto 11 do |i|
		b 1/2r
		tp_chain 0, 100, 1, relative: false do
			t 0, 0; b 1/2r
		end
	end
end
1.upto 11 do |i|
	notes = tp_chain 100, 0, 1 do
		f 50/sqrt(3), 50, :down
		b 1/4r
		d 250/3/sqrt(3), 50/3.0
		b 1/4r
		d 250/3/sqrt(3), -50/3.0
		b 1/4r
		d 50/sqrt(3), -50
		b 1/4r
	end
	transform(notes) { horizontal_flip } if i % 2 == 0
end

def pattern
	tp_drop 0, -100, 1 do
		2.times { t -37.5, 50; b 1/4r }
		2.times { t 12.5, 50; b 1/4r }
		2.times { t -12.5, 50; b 1/4r }
		2.times { t 37.5, 50; b 1/4r }
	end
end
pattern
transform(pattern) { vertical_flip }

checkerboard 15
tp_chain 0, 100, 1, relative: false do
	h 0, 0, 1
end
b 1
def inward_drop x, y
	r = hypot x, y
	tp_chain 200*x/r, 200*y/r, speed: 100, relative: false do
		t x, y
	end
end
1.upto 15 do |i|
	u = 50 * exp(-i/3.0)
	inward_drop u, u; b 1/4r
	next b 1/4r if i == 15
	inward_drop -u, u; b 1/4r
	inward_drop u, -u; b 1/4r
	inward_drop -u, -u; b 1/4r
end
t -100, 0
t 100, 0
b 1/2r

turntable 11 - 1/2r
tp_chain 0, 100, 1, relative: false do
	h 0, 0, 1
end
b 1
def pattern
	tp_chain 100, 0, 1, preserve_beat: false do
		20.times do |i|
			angle = PI/2 - PI/8 - PI/4*i
			x = 50 * cos(angle)
			y = 50 * sin(angle)
			t x, y; b 1/2r
		end
	end
end
pattern
b 1/4r
transform(pattern) { rotate PI }
b 10 - 1/4r
tp_chain 0, 100, 1, relative: false do
	f 0, 0, :up
end
b 1

hexagon 1
def bg_drop_hold x, y, duration, n = 4
	notes = group preserve_beat: false do
		h x, y, duration
		unit_x = x.to_f / n
		unit_y = y.to_f / n
		b -1
		n.times do |i|
			bg_note unit_x * i, unit_y * i, duration
			b 1r/n
		end
	end
	transform(duplicate notes) { horizontal_flip }
end
bg_drop_hold 50/sqrt(3), 50, 1
b 3/2r
hexagon 3/2r
bg_drop_hold 50/sqrt(3), -50, 3/2r
b 5/2r

def dt x, y
	t x, y
	d x, y
end
tp_chain 0, 100, 1, preserve_beat: false, relative: false do
	t 0, 0; b 1/2r
	t -25, 25; b 1/2r
	dt 50, 0; b 1/2r
	t -50, -50; b 1/4r
	t 40, -40; b 1/4r
	t -30, -30; b 1/4r
	t 20, -20; b 1/4r
	dt -10, -10; b 1/2r
	t -50, 0; b 1/4r
	t 40, 10; b 1/4r
	t -30, 20; b 1/4r
	t 20, 30; b 1/4r

	t 40, 40; b 1/2r
	t 0, 10; b 1/2r
	dt -40, -20; b 1/2r
	t -80, -50; b 1/4r
	t -70, 45; b 1/4r
	t -60, -40; b 1/4r
	t -50, 35; b 1/4r
	dt -40, -30; b 1/2r
	t 0, -50; b 1/4r
	t 10, 45; b 1/4r
	t 20, -40; b 1/4r
	t 30, 35; b 1/4r

	t 40, -30; b 1/8r
	d 45, -25; b 1/8r
	d 50, -20; b 1/8r
	d 55, -15; b 1/8r
	d 60, -10; b 1/8r
	d 65, -5; b 1/8r
	d 70, 0; b 1/8r
	d 75, 5; b 1/8r
	dt 80, 10; b 1/2r
	t 60, 45; b 1/4r
	t 50, -40; b 1/4r
	t 40, 35; b 1/4r
	t 30, -30; b 1/4r
	dt 20, 25; b 1/2r
	t -10, -40; b 1/4r
	t -20, 35; b 1/4r
	dt -30, -30; b 1/4r
	t -40, 25; b 1/4r

	t -50, -20; b 1/2r
	t -20, 5; b 1/2r
	dt 10, 30; b 1/2r
	t 40, 50; b 1/4r
	t -20, 40; b 1/4r
	t 35, 30; b 1/4r
	t -10, 20; b 1/4r
	dt 30, 10; b 1/2r
	t 0, -10; b 1/4r
	t -60, -20; b 1/4r
	t -10, -30; b 1/4r
	t -50, -40; b 1/4r
end
tp_chain 0, 100, 1, relative: false do
	f 50, 0, :up; b 1
	f -50, 0, :down; b 3/2r
	f 50, -12.5, :up; b 3/2r

	b 1
	f 25, 0, :left; b 3/2r
	f -50, 50, :right; b 3/2r

	b 1
	f 25, 0, :left; b 3/2r
	f 20, -50, :right; b 3/2r

	b 1
	f -50, 30, :up; b 3/2r
	f -20, 10, :down; b 3/2r
end

tp_drop 0, -100, 1 do
	h -60, -50, 3/4r
	h 60, -50, 3/4r
end
tp_chain 0, 100, 1, preserve_beat: false, relative: false do
	b 1
	dt 100, 25; b 1/2r
	t 75, -50; b 1/4r
	t 50, -50; b 1/4r
	t 50, -25; b 1/4r
	t 25, -25; b 1/4r
	dt 25, 0; b 1/2r
	t 0, -50; b 1/4r
	t 0, -25; b 1/4r
	t -25, -25; b 1/4r
	t -25, 0; b 1/4r

	t -50, 0; b 1/2r
	t -75, 25; b 1/2r
	dt -100, 50; b 1/2r
	t -50, 50; b 1/4r
	t -50, 25; b 1/4r
	t -25, 25; b 1/4r
	t -25, 0; b 1/4r
	dt 0, 0; b 1/2r
	t 25, 25; b 1/4r
	t 50, 25; b 1/4r
	t 50, 0; b 1/4r
	t 75, 0; b 1/4r

	t 75, -25; b 1/8r
	d 60, -27; b 1/8r
	d 45, -29; b 1/8r
	d 30, -31; b 1/8r
	d 15, -33; b 1/8r
	d 0, -35; b 1/8r
	d -15, -37; b 1/8r
	d -30, -39; b 1/8r
	dt -45, -41; b 1/2r
	t -80, -50; b 1/4r
	t -70, -25; b 1/4r
	t -80, 0; b 1/4r
	t -70, 25; b 1/4r
	dt -80, 50; b 1/2r
	t 10, -50; b 1/4r
	t 0, -25; b 1/4r
	dt 10, 0; b 1/4r
	t 0, 25; b 1/4r

	16.times do |i|
		t 10*exp(i/7.0)*(-1)**i, 50 - 100*i/16.0; b 1/4r
	end
end
tp_chain 100, 0, 1, relative: false do
	b 1
	f 100, -37.5, :up; b 3/2r
	f 75, 0, :right; b 3/2r

	b 1
	f 0, 50, :down; b 3/2r
	f -50, 0, :left; b 3/2r

	b 1
	f 25, -50, :right; b 3/2r
	f -50, 50, :right; b 3/2r

	b 4
end

grid 13
tp_chain 0, 100, 1, preserve_beat: false, relative: false do
	t 100, 50; b 1/2r
	t 100, 0; b 1/2r
	dt 100, -50; b 1/2r
	t 50, -50; b 1/4r
	t -50, -25; b 1/4r
	t 50, 0; b 1/4r
	t -50, 25; b 1/4r
	dt 50, 50; b 1/2r
	t 25, -50; b 1/4r
	t -25, -25; b 1/4r
	t 25, 0; b 1/4r
	t -25, 25; b 1/4r

	t 25, 50; b 1/2r
	t -62.5, 25; b 1/2r
	dt -100, 50; b 1/2r
	t -100, -50; b 1/4r
	t -50, 50; b 1/4r
	t 0, -50; b 1/4r
	t 50, 50; b 1/4r
	dt 100, -50; b 1/2r
	t -100, -50; b 1/4r
	t -50, 50; b 1/4r
	t 0, -50; b 1/4r
	t 50, 50; b 1/4r

	t 100, -50; b 1/8r
	d 75, -37.5; b 1/8r
	d 50, -25; b 1/8r
	d 25, -12.5; b 1/8r
	d 0, 0; b 1/8r
	d -25, 12.5; b 1/8r
	d -50, 25; b 1/8r
	d -75, 37.5; b 1/8r
	dt -100, 50; b 1/2r
	t 100, 50; b 1/4r
	t 0, 25; b 1/4r
	t 50, 0; b 1/4r
	t -50, -25; b 1/4r
	dt 0, -50; b 1/2r
	t -100, 50; b 1/4r
	t 0, 25; b 1/4r
	dt -50, 0; b 1/4r
	t 50, -25; b 1/4r

	t 0, -50; b 1/2r
	t 0, 0; b 1/2r
	dt 0, 50; b 1/2r
	t 0, -50; b 1/4r
	t 0, -25; b 1/4r
end
tp_drop 0, 100, 1 do
	f 0, 0, :up; b 1
	f 0, 0, :left; b 3/2r
	f 0, 0, :down_left; b 3/2r

	b 1
	f 0, 0, :down_right; b 3/2r
	f 0, 0, :up; b 3/2r

	b 1
	f 0, 0, :up_right; b 3/2r
	f 0, 0, :down_right; b 3/2r

	b 1
	f 0, 0, :down; b 1
end
def hold_flick j, duration, n = 4
	angle = PI/2 + 2*PI/5 * j*2
	x = 50 * cos(angle)
	y = 50 * sin(angle)
	group preserve_beat: false do
		h x, y, duration
		unit_x = x.to_f / n
		unit_y = y.to_f / n
		b -1
		n.times do |i|
			bg_note unit_x * i, unit_y * i, duration
			b 1r/n
		end
	end
	angle = PI/2 - 2*PI/5 * j
	x = 50 * cos(angle)
	y = 50 * sin(angle)
	tp_chain 0, 0, speed: 100, relative: false do
		f x, y, (atan2(y, x)/(PI/4)).round * PI/4
	end
end
pentagon 1/2r
hold_flick 1, 1/2r
b 1/2r
tp_chain(0, 100, 1, relative: false) { t 0, 0; b 1/4r }
pentagon 1/2r
hold_flick -1, 1/2r
b 1/2r
tp_chain(0, 100, 1, relative: false) { t 0, 0; b 1/4r }
pentagon 1/4r
bg_drop_hold 50*cos(PI/2 + 4*PI/5), 50*sin(PI/2 + 4*PI/5), 1/4r
b 1/2r

diamond_grid 7
tp_chain 0, 100, 1, preserve_beat: false, relative: false do
	t 50, 50; b 1/2r
	t 75, 25; b 1/2r
	dt 100, 0; b 1/2r
	t 25, 25; b 1/4r
	t 37.5, 12.5; b 1/4r
	t 50, 0; b 1/4r
	t 62.5, -12.5; b 1/4r
	dt 75, -25; b 1/2r
	t -25, 25; b 1/4r
	t -12.5, 12.5; b 1/4r
	t 0, 0; b 1/4r
	t 12.5, -12.5; b 1/4r

	t 25, -25; b 1/2r
	t 0, -50; b 1/2r
	dt -25, -25; b 1/2r
	t -50, 0; b 1/4r
	t -62.5, 12.5; b 1/4r
	t -75, 25; b 1/4r
	t -87.5, 37.5; b 1/4r
	dt -100, 50; b 1/2r
	t 50, 0; b 1/4r
	t 62.5, 12.5; b 1/4r
	t 75, 25; b 1/4r
	t 87.5, 37.5; b 1/4r

	f 100, 50, :left; b 1/8r
	d 75, 50; b 1/8r
	d 50, 50; b 1/8r
	d 25, 50; b 1/8r
	d 0, 50; b 1/8r
	d -25, 50; b 1/8r
	d -50, 50; b 1/8r
	d -75, 50; b 1/8r
	f -20, 46, :down_left; b 1/2r
	f -18, 12, :down_right; b 1
	f -16, -10, :down_right; b 1
	f 12, 30, :down_left; b 1
	f 37, 35, :down_right; b 3/2r
	f 10, -15, :down; b 1
	f 36, -13, :down; b 1
	h 18, -36, 15
end
tp_chain 0, 100, 1, relative: false do
	f 0, 50, :left; b 1
	f 0, 0, :left; b 3/2r
	f 0, -50, :left; b 3/2r

	b 1;
	f 75, -25, :right; b 3/2r
	f 0, 50, :right; b 3/2r

	group preserve_beat: false do
		h -100, -50, 4; b 1/8r
		d -75, -50; b 1/8r
		d -50, -50; b 1/8r
		d -25, -50; b 1/8r
		d 0, -50; b 1/8r
		d 25, -50; b 1/8r
		d 50, -50; b 1/8r
		d 75, -50; b 1/8r
	end
end
big_text 8, '船'; b 8

tp_chain 0, 100, 1 do
	t -50, -50; b 1/2r
	t -50, -25; b 1/2r
	t -50, 0; b 1/2r
	t -25, 0; b 1
	t -50, 25; b 1
	t -75, 50; b 1/2r
end
tp_chain 0, 100, 1 do
	t 0, -50; b 1/2r
	t -25, -50; b 1/2r
	t -25, -25; b 1/2r
	t 0, -25; b 1
	t 0, 25; b 1/2r
	t -25, 25; b 1/2r
	t -50, 25; b 1/2r
end
tp_chain 0, 100, 1 do
	t 0, -50; b 1/2r
	t -25, -50; b 1/2r
	t -25, -25; b 1/2r
	t 0, -25; b 1
	t 0, 25; b 1
	t -25, 25; b 1/2r
end
tp_chain 0, 100, 1 do
	t -75, 50; b 1/2r
	t -75, 25; b 1/2r
	t -75, 0; b 1/2r
	t -100, 0; b 1
	t 0, 0; b 1/2r
	f 0, 25, :up; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	t -100, -50; b 1/2r
	t -75, -50; b 1/2r
	t -50, -50; b 1/2r
	t -50, -25; b 1/2r
	t -50, 0; b 1/2r
	t -50, 25; b 1/2r
	t -25, 0; b 1/2r
	t -25, 25; b 1/2r
	t -25, 50
end
tp_chain 0, -100, 1 do
	b 3/2r
	b 1/4r
	t 0, -12.5; b 1/2r
	t 0, 12.5; b 1
	t 25, 12.5; b 1/2r
	t 25, 37.5; b 1/4r
end
tp_chain 0, 100, 1, preserve_beat: false do
	b 1/2r
	t 75, -50; b 1/2r
	t 50, -50; b 1/2r
	t 50, -25; b 1/2r
	t 50, 0; b 1/2r
	t 50, 25; b 1/2r
	t 25, 0; b 1/2r
	t 25, 25; b 1/2r
	t 25, 50
end
tp_chain 0, -100, 1 do
	b 3/2r
	b 1/4r
	t 0, -12.5; b 1/2r
	t 0, 12.5; b 1
	t -25, 12.5; b 1/2r
	t -25, 37.5; b 1/4r
end
tp_chain 0, 100, 1, preserve_beat: false do
	b 1/2r
	t 0, 25; b 1/2r
	t 0, 0; b 1/2r
	t 0, -25; b 1/2r
	t -25, -25; b 1/2r
	t -50, -25; b 1/2r
	t -75, -25; b 1/2r
	t -75, 0; b 1/2r
	t -75, 25; b 1/2r
	t -75, 50; b 1/2r
	t -50, 50; b 1/2r
	t -25, 50; b 1/2r
	t 0, 50; b 1/2r
	t 0, 25; b 1/2r
	f 0, 0, :down
end
tp_chain 0, 100, 1 do
	b 3/2r
	b 1/4r
	t 25, -25; b 1/2r
	t 50, -25; b 1
	t 75, -25; b 1/2r
	t 75, 0; b 1
	t 75, 25; b 1/2r
	t 50, 25; b 1
	t 25, 25; b 1/2r
	t 25, 0; b 1/4r
	b 1
end

def pattern y
	s = 0
	([2]*3 + [1]*4 + [2] + [1]*4).each do |dx|
		bg_note -100 + 200/16.0*s, y
		b dx/4r
		s += dx
	end
end
group preserve_beat: false do
	pattern 50
	pattern 25
	pattern 0
	pattern -25
	pattern -50
	pattern 50
	pattern 25
end
tp_chain -100, 0, 1 do
	h 50, 50, 12; b 12
	h -50, 25, 2; b 2
	h 25, 0, 3/2r; b 3/2r
	t 0, 0; b 1/4r
	t -12.5, -12.5; b 1/4r

	h -25, -25, 4; b 4
	h 50, -50, 2; b 2
	h 25, 0, 2; b 2
	h 50, 50, 4 - 1/2r; b 4 - 1/2r
	t 25, 25; b 1/4r
	t 12.5, 12.5; b 1/4r
	h 0, 0, 4
end
tp_drop 0, 100, 1 do
	b 1/2r
	3.times { t -25, -50; b 1/2r }
	b 1/2r
	3.times { t 25, -50; b 1/2r }
end

end
