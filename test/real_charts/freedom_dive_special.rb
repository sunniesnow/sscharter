include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title 'Freedom Dive'
artist 'xi'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '15'

offset 2.081
bpm 222.222

def pattern second = false
	group do
		tp_chain 0, 100, 1, preserve_beat: false do
			64.times do |i|
				angle = PI/2 - i * PI/4
				x = i < 56 ? 50 + 50*cos(angle) : 50 - 50*cos(angle)
				y = 50*sin(angle)
				i.zero? ? f(x, y, :r) : d(x, y); b 1/4
			end
		end
		tp_chain 0, 100, 1 do
			f -50, 50, :l; b 3/4
			t -75, 12.5; b 3/4
			t -100, -25; b 1
			t -75, -50; b 1/2
			t -62.5, -25; b 1/2
			t -50, 0; b 1/2

			t -50, 50; b 3/4
			t -75, 12.5; b 3/4
			t -100, -25; b 1/2
			t -75, -50; b 1/2
			t -62.5, -25; b 1/2
			t -50, 0; b 1

			f -50, 50, :l; b 3/4
			t -75, 12.5; b 3/4
			t -100, -25; b 1
			t -75, -50; b 1/2
			t -62.5, -25; b 1/2
			t -50, 0; b 1/2

			unless second
				t -50, 50; b 3/4
				t -75, 12.5; b 3/4
				t -100, -25; b 1/2
			else
				t -50, 50; b 1
				t -87.5, 0; b 1
			end
			[[1/4]*2, [1/8]*4].flatten.each_with_index do |delta, i|
				x = -75 + 75/6*i
				y = -50 + 50/6*i
				i.zero? ? t(x, y) : d(x, y); b delta
			end
			t 0, 0; b 1/2
			t 25, 25; b 1/2
		end
	end
end
group preserve_beat: false do
	turntable 1/8; b 8
	turntable 1/8; b 8
	turntable 1/8; b 8
	turntable 1/8; b 2
	turntable 1/8; b 2
	turntable 1/8; b 1
	turntable 1/8; b 1
	turntable 1/8; b 1
	turntable 1/8; b 1
end
pattern
transform(pattern true) { horizontal_flip }

def pattern second = false
	group do
		tp_chain 0, 100, 1, preserve_beat: false do
			64.times do |i|
				angle = PI*3/8 - (i%4) * PI/4
				x = 50 + 50*cos(angle)
				y = 50*sin(angle)
				i%4==0 ? second && i>=48 ? h(x, y, 1/2) : t(x, y) : d(x, y)
				b i%4==3 ? 5/4 : 1/4
			end
		end
		tp_chain 0, 100, 1, preserve_beat: false do
			64.times do |i|
				b 1 if i%4==0
				angle = -PI*5/8 - (i%4) * PI/4
				x = -50 + 50*cos(angle)
				y = 50*sin(angle)
				i%4==0 ? second && i>=48 ? h(x, y, 1/2) : t(x, y) : d(x, y)
				b 1/4
			end
		end
		[
			8,
			5, 1, 3/4, 3/4, 1/2,
			3, 1/2, 1, 1/2, 1, 1/2, 1/2, 1,
			*(second ? [1/2]*16 : [2, 2, 1, 1, 1, 1])
		].reduce 0 do |cur, delta|
			angle = PI/2 + cur * PI
			x = cur>=24&&second&&cur%1==1/2 ? 25+6.25*(cur-24) : 25
			x = cur % 2 < 1 ? -x : x
			y = 50*sin(angle)
			#turntable 1/8 unless second && cur >= 24
			tp_chain cur % 2 < 1 ? -100 : 100, 0, 0.75 do
				t x, y; b delta
			end
			cur + delta
		end
	end
end
pattern
transform(pattern true) { horizontal_flip }

tp_chain 0, -100, 1 do
	t -50, 50
end
def peace_theme
	group do
		notes = group do
			tp_drop 0, -100, 1 do
				t 50, 50; b 3/4
				t 50, 50; b 3/4
				t 50, 50; b 1/2
			end
			tp_drop 0, 100, 1 do
				t 62.5, -25; b 1/4
				t 87.5, -25; b 3/4
				t 87.5, -25; b 1/2
				t 87.5, -25; b 1/2
			end
		end

		transform(duplicate notes) { translate -50, 0; beat_translate 4 }
		b 4

		transform(duplicate notes) { translate -100, 0; beat_translate 8 }
		b 4

		tp_drop 0, 100, 1 do
			t -100, -50; b 3/4
			t -100, -50; b 3/4
			t -75, -37.5; b 1/2
			t -37.5, -25; b 1/2
			t 0, -12.5; b 1/2
			t 37.5, 0; b 1/2
			t 75, 12.5; b 1/2
		end

		tp_drop 0, -100, 1 do
			t 50, 25; b 3/4
			t 50, 25; b 3/4
			t 50, 25; b 1/2
			t 12.5, 37.5; b 1/4
			t -12.5, 37.5; b 3/4
			t -12.5, 37.5; b 1/2
			t -12.5, 37.5; b 1/2

			2.times { t -50, 50; b 1/2 }
			2.times { t 75, 25; b 1/2 }
		end
		tp_drop 0, 100, 1 do
			2.times { t -37.5, 0; b 1/2 }
			2.times { t 62.5, -25; b 1/2 }

			2.times { t -25, 12.5; b 1/2 }
			2.times { t 50, -12.5; b 1/2 }
			2.times { t -62.5, -37.5; b 1/2 }
			2.times { t 37.5, 12.5; b 1/2 }

			t -50, 0; b 3/4
			t -50, 0; b 3/4
			t -50, 0; b 1/2
			t -75, -37.5; b 1/4
			t -100, -37.5; b 3/4
			t -100, -37.5; b 1/2
			t -100, -37.5; b 1/2
		end

		tp_chain 100, 0, 1, preserve_beat: false do
			b -1/2
			t 100, -50; b 1/4
			d 87.5, -37.5; b 1/4
			h 75, -25, 8-1/2; b 8
			h 75, 0, 8-1/2; b 8
		end
		tp_drop 100, 0, 1, preserve_beat: false do
			b 4
			d 75, 25; b 2
			d 75, 12.5; b 2
			d 75, 0; b 2
			d 75, 12.5; b 2
			d 75, 25; b 2
			d 75, 12.5; b 2
		end
		tp_drop 0, -100, 1 do
			2.times { t -87.5, 0; b 1/2 }
			2.times { t -37.5, 12.5; b 1/2 }
			2.times { t -75, 25; b 1/2 }
			2.times { t -62.5, 50; b 1/2 }
			
			t -25, 37.5; b 1/3
			d -37.5, 50; b 1/3
			d -50, 37.5; b 1/3
			2.times { t -62.5, 12.5; b 1/2 }
		end
		tp_drop 0, 100, 1 do
			t -75, -25; b 3/4
			t -75, -25; b 1/4
			2.times { t -100, -25; b 1/2 }

			2.times { t -62.5, -50; b 1/2 }
			2.times { t 0, -25; b 1/2 }
			2.times { t -50, 0; b 1/2 }
			2.times { t 25, -50; b 1/2 }
		end

		tp_drop 0, -100, 1 do
			2.times { t 12.5, 25; b 1/2 }
			2.times { t -12.5, 12.5; b 1/2 }
			2.times { t -37.5, 0; b 1/2 }
			2.times { t -62.5, 12.5; b 1/2 }
		end
		tp_drop -100, 0, 1, preserve_beat: false do
			h -100, 25, 4-1/2; b 4-1/2
			d -100, -50; b 1/4
			d -87.5, -37.5; b 1/4

			h -75, -25, 3/2; b 2
			h -75, 25, 3/2; b 2

			h -50, -50, 3/2; b 2
			h -25, 0, 1/2; b 1
			4.times do |i|
				x = -50 - 12.5*i
				y = 50 - 12.5*i
				i.zero? ? h(x, y, 1) : d(x, y); b 1/4
			end

			d -100, 0; b 1
			h -75, -37.5, 1/2; b 1
			h -50, -12.5, 1/2; b 1
			h -25, 12.5, 1/2; b 1
		end
		tp_drop 0, -100, 1 do
			t 25, 50; b 3/4
			t 25, 50; b 3/4
			t 25, 50; b 1/2
			t 62.5, 0; b 1/4
			t 37.5, 0; b 3/4
			t 0, 12.5; b 1/2
			t -25, 25; b 1/2

			t 12.5, 37.5; b 1/2
			t 12.5, 37.5; b 1/2
			t 25, 12.5; b 1/2
			t 25, 12.5; b 1/2
			t 50, 37.5; b 3/4
			t 75, 50; b 3/4
			t 75, 50; b 1/2

			t 100, 37.5; b 3/4
			t 100, 37.5; b 3/4
			t 100, 37.5; b 3/4
			t 62.5, 12.5; b 3/4
			t 25, 25; b 1/2
			t 0, 12.5; b 1/2

			2.times { t 50, 50; b 1/2 }
		end
		tp_drop 0, 100, 1 do
			2.times { t 62.5, 25; b 1/2 }
			2.times { t 75, 0; b 1/2 }
			2.times { t 87.5, -25; b 1/2 }
		end
	end
end
peace_theme

notes = tp_drop 100, 0, 1, preserve_beat: false do
	h 100, -50, 1/2; b 1
	h 75, -25, 1/2; b 1
	h 50, 0, 1/2; b 1
	h 25, 25, 1/2; b 1
end
transform duplicate notes do
	beat_translate 4
	horizontal_flip
	translate 37.5, 12.5
end
grid 7
tp_chain -100, 0, 1 do
	t -87.5, 50; b 1/2
	t -50, 50; b 1/2
	t -12.5, 50; b 1/2
	t -75, 25; b 1/4
	d -62.5, 12.5; b 1/4
	t -75, 0; b 1/2
	t -37.5, 0; b 1/2
	t 0, 0; b 1/2
	t -62.5, -12.5; b 1/4
	d -50, -25; b 1/4

	t 12.5, -50; b 1/2
	t 50, -50; b 1/2
	t 87.5, -50; b 1/2
	t 25, -25; b 1/4
	d 37.5, -12.5; b 1/4
	t 50, -0; b 1/2
	t 75, -25; b 1/8
	d 75, -12.5; b 1/8
	d 75, 0; b 1/8
	d 75, 12.5; b 1/8
	t 75, 25; b 1/4
	d 87.5, 37.5; b 1/4
	t 100, 50; b 1/4
	d 87.5, 50; b 1/4
end

def pattern second = false
	group do
		notes = tp_chain 25, 0, relative_beat: 1/2, preserve_beat: false do
			32.times do |i|
				angle = PI*3/4 + i*PI/2
				x = -87.5 + 12.5*sqrt(2)*cos(angle)
				y = 12.5*sqrt(2)*sin(angle)
				i%4==2 ? f(x, y, :u) : t(x, y); b 1/2
			end
		end
		transform notes do
			translate 87.5, 0
			rotate PI/4
			translate -87.5, 0
		end if second
		transform duplicate notes do
			beat_translate 16
			horizontal_flip
		end
		notes = tp_chain 0, 100, 1 do
			notes = group do
				notes = group do
					h 50, 50, 1/2; b 1
					h 25, 25, 1/2; b 1
					h 75, 25, 1/2; b 1
					h 50, 0, 1/2; b 1
				end
				transform notes do
					translate -50, -25
					rotate PI/4
					translate 50, 25
				end if second
				transform duplicate notes, new_tip_points: false do
					vertical_flip
					beat_translate 4
				end
				b 4
			end
			transform duplicate notes, new_tip_points: false do
				beat_translate 8
				horizontal_flip
				translate 100, 0
			end
			b 8
		end
		notes = transform duplicate notes do
			beat_translate 16
			horizontal_flip
		end
		b 13
		grid second ? 20 : 2
		b 3
		if second
			tp = notes[0][:tip_point]
			remove *notes[-8..]
			notes = group do
				b -8
				4.times do |i|
					t -100+25*i, 12.5+12.5*i; b 1/2
				end
				4.times do |i|
					t -87.5+25*i, -37.5+12.5*i; b 1/2
				end
			end
			notes.concat transform(duplicate notes) { vertical_flip; beat_translate 4 }
			notes.each { _1[:tip_point] = tp }
			b 4
		end
	end
end
pattern
pattern true

def hold_4
	group do
		notes = group preserve_beat: false do
			8.times do |i|
				angle = PI*5/8 + i*PI/4
				x = -50 + 50*cos(angle)
				y = 50*sin(angle)
				tp_chain -100*cos(angle), -100*sin(angle), 0.75 do
					h x, y, 1/2; b 1
				end
			end
		end
		transform duplicate notes do
			beat_translate 8
			horizontal_flip
		end
	end
end
def chain x, y, angle, tap_end = false
	notes = tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 50*sqrt(2) do
		f x, y, angle; b 1/4
		dx, dy = 12.5*sqrt(2)*cos(angle), 12.5*sqrt(2)*sin(angle)
		d x+dx, y+dy; b 1/4
		tap_end ? t(x+2*dx, y+2*dy) : d(x+2*dx, y+2*dy); b 1/4
	end
end
def pattern second = false
	notes = group do
		notes = group do
			notes = chain 62.5, 50, -PI*3/4
			(1..3).each do |i|
				transform duplicate notes do
					beat_translate i*3/4
					translate 12.5*i, -25*i
				end
				b 3/4
			end
			notes = tp_chain -100, 100, beat_speed: 50*sqrt(2) do
				t 50, -25; b 1/4
				d 62.5, -37.5; b 1/4
			end
			transform duplicate notes do
				beat_translate 1/2
				translate 12.5, 25
			end
			b 1/2
		end
		transform duplicate notes do
			beat_translate 4
			horizontal_flip
			translate 125, 0
		end
		b 4
	end
	if second
		old_beat = b -2
		remove *notes.filter { _1.beat >= old_beat }
		notes.concat tp_drop(100, 100, beat_speed: 50*sqrt(2)) {
			t 62.5, -37.5; b 1/4
			d 50, -37.5; b 1/4
			t 75, -12.5; b 1/4
			d 62.5, -12.5; b 1/4
			t 75, 25; b 1/4
			d 62.5, 25; b 1/4
			t 62.5, 50; b 1/4
			d 50, 50; b 1/4
		}
	end
	notes
end
hold_4
pattern
transform(pattern true) { horizontal_flip }

notes = group do
	chain 50, 50, -PI/4
	chain 50, 25, -PI*3/4
	chain 50, 0, -PI/4, true
	chain 50, -25, -PI*3/4
	tp_drop -100, 100, beat_speed: 50*sqrt(2) do
		t 0, -37.5; b 1/2
		t 0, -12.5; b 1/2
	end
end
transform duplicate notes do
	translate -100, 0
end

def double_chain x, y, angle
	group do
		dx, dy = 25*sqrt(2)*cos(angle), 25*sqrt(2)*sin(angle)
		tp_chain -200*cos(angle), -200*sin(angle), beat_speed: 100*sqrt(2), preserve_beat: false do
			f x, y, angle; b 1/4
			d x+dx, y+dy; b 1/4
			d x+2*dx, y+2*dy; b 1/2
		end
		tp_chain 200*cos(angle), 200*sin(angle), beat_speed: 100*sqrt(2) do
			b 1/2
			t x, y; b 1/2
		end
	end
end
diamond_grid 6
double_chain -50, 50, -PI/4
double_chain 50, 50, -PI*3/4
double_chain -50, -50, PI/4
double_chain 50, -50, PI*3/4

double_chain -50, 50, -PI*3/4
double_chain 50, 50, -PI/4
double_chain -50, -50, PI*3/4
double_chain 50, -50, PI/4

checkerboard 2
tp_drop 0, 100, 1 do
	t -37.5, -37.5; t 37.5, -37.5; b 1/4
	d -12.5, -25; b 1/4
	d 12.5, -12.5; b 1/4
	t -37.5, 0; t 37.5, 0; b 1/4
	d -12.5, 12.5; b 1/4
	d 12.5, 25; b 1/4
	t -37.5, 37.5; t 37.5, 37.5; b 1/4
	d -12.5, 50; b 1/4
end
tp_drop 0, -100, 1 do
	4.times do |i|
		x = 37.5 - 12.5*i
		y = 50 - 12.5*i
		i.zero? ? f(x, y, :dl) : d(x, y); b 1/8
	end
	f -12.5, 0, :dr; b 1/4
	d 0, -12.5; b 1/4
	t -37.5, -25; t 37.5, -25; b 1/2
	t -37.5, -50; t 37.5, -50; b 1/2
end

pentagon 5
tp_drop 0, 100, 1, preserve_beat: false do
	x = 50*cos(1.3*PI)
	y = 50*sin(1.3*PI)
	2.times do
		t x, y; b 1
		t -x, y; b 1
	end
end
tp_chain 0, 0, relative: false, relative_beat: 1/2 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	t x, y; b 1/2
	t 0, 0; b 1/2
	t -x, y; b 1/2
	t 0, 0; b 1/2
	t 0, 50; b 1/2
	t 0, 0; b 1/2
	t 0, 50; b 1/2
	t 0, 0; b 1/2
end

tp_drop 0, -100, 1 do
	x = 50*cos(0.1*PI) / 2
	y = 50*(sin(0.1*PI) + 1) / 2
	t -x, y; b 1/3
	t 0, y; b 1/3
	t x, y; b 1/3
end
tp_drop 0, 100, 1 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	t -x, y; t x, y; b 1/4
	x = 50*(cos(0.1*PI) + cos(-0.3*PI)) / 2
	y = 50*(sin(0.1*PI) + sin(-0.3*PI)) / 2
	d -x, y; d x, y; b 1/4
	x = 50*cos(-0.3*PI) / 2
	y = 50*sin(-0.3*PI) / 2
	t -x, y; t x, y; b 1/2
end

notes = group do
	chain 62.5, -37.5, PI*3/4, true
	chain 25, 0, PI/4
	remove chain(62.5, 37.5, PI*3/4).last; b -1/4
end
transform duplicate notes do
	translate -100, 0
end

diamond_grid 6
group preserve_beat: false do
	8.times do |i|
		angle = PI*3/4 - i*PI/2
		x = 50*sqrt(2)*cos(angle)
		y = 50*sqrt(2)*sin(angle)
		tp_chain -2*x, -2*y, relative: false, beat_speed: 100*sqrt(2) do
			h x, y, 1/2; b 1
		end
	end
end
notes = group do
	notes = tp_chain 0, 0, relative: false, relative_beat: 1/2 do
		t 50, 50; b 1/2
		t 0, 0; b 1/2
		t -50, -50; b 1/2
		t 0, 0; b 1/2
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 2
	end
	b 2
end
transform duplicate notes do
	vertical_flip
	beat_translate 4
end
b 4

def tap_chain x, y, angle
	dx = 12.5*sqrt(2)*cos(angle)
	dy = 12.5*sqrt(2)*sin(angle)
	tp_chain -dx*8, -dy*8, beat_speed: 50*sqrt(2) do
		t x, y; b 1/4
		d x+dx, y+dy; b 1/4
	end
end
def pattern second = false
	group do
		notes = chain 62.5, 50, -PI*3/4
		(1..3).each do |i|
			transform duplicate notes do
				beat_translate i*3/4
				translate 12.5*i, -25*i
			end
			b 3/4
		end
		tap_chain 50, -25, -PI*3/4
		tap_chain 62.5, 0, -PI*3/4

		unless second
			tap_chain 75, 37.5, -PI/4
			tap_chain 87.5, 12.5, -PI/4
			tap_chain 87.5, -25, PI*3/4
			tap_chain 75, -50, PI*3/4
			chain 50, -50, PI*3/4
			chain 62.5, -25, PI*3/4
			remove chain(75, 0, PI*3/4).last; b -1/4
		else
			notes = tp_drop 100, 100, beat_speed: 50*sqrt(2) do
				t 62.5, 50; b 1/4
				d 50, 50; b 3/4
				t 75, 25; b 1/4
				d 62.5, 25; b 3/4
				t 75, -12.5; b 1/4
				d 62.5, -12.5; b 3/4
				t 62.5, -37.5; b 1/4
				d 50, -37.5; b 3/4
			end
			transform duplicate notes do
				horizontal_flip
				beat_translate 1/2
				translate 100, -12.5
			end
		end
	end
end
grid 16
transform(hold_4) { horizontal_flip }
transform(pattern) { horizontal_flip }
pattern true

tp_chain 100, 100, 1 do
	h 100, -50, 8
end
def pattern second = false
	tp_chain -100, 0, 1 do
		t -62.5, 50; b 1/2
		t -37.5, 37.5; b 1/2
		t -12.5, 25; b 1/2
		t 12.5, 37.5; b 1/2
	end
	tp_chain 100, 0, 1 do
		t 62.5, 12.5; b 1/2
		t 37.5, 0; b 1/2
		t 12.5, 12.5; b 1/2
		t -12.5, 0; b 1/2
	end

	tp_chain -100, 0, 1 do
		t -62.5, -25; b 1/2
		t -37.5, -12.5; b 1/2
		t -12.5, -25; b 1/2
		t 12.5, -37.5; b 1/2
	end
	tp_chain 100, 0, 1 do
		t 62.5, 0; b 1/2
		t 37.5, 12.5; b 1/2
		t 12.5, 0; b 1/2
		t -12.5, 12.5; b 1/2
	end

	tp_chain -100, 0, 1 do
		t -62.5, 50; b 1/2
		t -37.5, 37.5; b 1/2
		t -12.5, 25; b 1/2
		t 12.5, 37.5; b 1/2
	end
	tp_chain 100, 0, 1 do
		t 62.5, 12.5; b 1/2
		t 37.5, 0; b 1/2
		t 12.5, 12.5; b 1/2
		t -12.5, 0; b 1/2
	end

	return if second == nil
	tp_chain -100, 0, 1 do
		t -62.5, -37.5; b 1/2
		t -37.5, -25; b 1/2
	end
	tp_chain 100, 0, 1 do
		t 62.5, -25; b 1/2
		t 37.5, -37.5; b 1/2
	end
	unless second
		tp_chain -100, 0, 1 do
			t -62.5, 0; b 1/2
			t -37.5, 12.5; b 1/2
		end
		tp_chain 100, 0, 1 do
			t 62.5, 0; b 1/2
			t 37.5, 12.5; b 1/2
		end
	else
		tp_chain -100, 0, 1, preserve_beat: false do
			t -62.5, 0; b 1
			t -37.5, 12.5; b 1
		end
		tp_chain 100, 0, 1 do
			t 62.5, 0; b 1
			t 37.5, 12.5; b 1
		end
	end
end
pattern
pattern true

tp_drop 0, 100, 1, preserve_beat: false do
	28.times do |i|
		b 1/2
		t (i/8).floor.even? ? 100 : -100, 0; b 1/2
	end
end if false
tp_drop 0, 100, 1, preserve_beat: false do
	f 87.5, -50, :u; b 8

	f -87.5, -50, :u; b 8

	f 87.5, -50, :u; b 4

	f 87.5, -50, :u; b 2
	f 87.5, -50, :u; b 2

	f -87.5, -50, :u; b 1
	f -87.5, -50, :u; b 1
	f -87.5, -50, :u; b 1
	tp_chain 0, 100, 1 do
		f -87.5, -50, :u; b 1/8
		(1...8).each do |i|
			d -87.5, -50+12.5*i; b 1/8
		end
	end
end
pattern
pattern nil

128.times do |j|
	angle = PI/2 - j*PI/16 - PI*(j/64)**2
	x = cos(angle)
	y = sin(angle)
	r = 100+50*j/128
	a = 37.5+12.5*j/128
	if j%32 >= 16
		note = tp_chain -r*x, -r*y, 1 do
			j%16==0 || (j>=120&&j.even?) ? t(50+a*x, a*y) : d(50+a*x, a*y); b 1/4
		end
		transform(duplicate note) { horizontal_flip }
	else
		note = tp_chain -r*x, -r*y, 1 do
			t 50+a*x, a*y; b 1/4
		end
		transform(note) { horizontal_flip } if (j + (j/32).floor).odd?
	end
end

notes = tp_chain 0, -150, 1 do
	h 50, 50, 4-1/2; b 3
	8.times do |i|
		d 50*(-1)**i, 50-100*i/8; b 1/16
	end
	4.times do |i|
		dx = 100*i/8/sqrt(2)
		d (50+dx)*(-1)**i, -50+dx; b 1/16
	end
	b 1/4
end
transform(duplicate notes) { horizontal_flip }

def connect_tap x, y, angle, no_end = false
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 50*sqrt(2) do
		t x, y; b 1/2
		next if no_end
		t x+25*sqrt(2)*cos(angle), y+25*sqrt(2)*sin(angle); b 1/4
	end
end
def pattern1 second = false
	group do
		notes = group do
			connect_tap -75, 50, -PI/4
			connect_tap -62.5, 25, -PI*3/4
			connect_tap -75, 0, -PI/4
			connect_tap -62.5, -25, -PI*3/4
			tap_chain -100, -37.5, PI/4
			tap_chain -87.5, 0, PI/4
		end
		notes = transform duplicate notes do
			horizontal_flip
			translate -150, 0
			beat_translate 4
		end
		b 4
		if second
			old_beat = b -2
			remove *notes.filter { _1.beat >= old_beat }
			tap_chain -50, -37.5, PI*3/4
			tap_chain -37.5, -12.5, PI*3/4
			tap_chain -37.5, 25, -PI*3/4
			tap_chain -50, 50, -PI*3/4
		end
	end
end
grid 16
transform(hold_4) { horizontal_flip }
pattern1
transform(pattern1 true) { horizontal_flip }

group preserve_beat: false do
	connect_tap 75, 50, -PI/4
	connect_tap 87.5, 25, -PI*3/4, true; b 1/4
	connect_tap 75, 0, -PI/4
	connect_tap 87.5, -25, -PI*3/4, true; b 1/4
	tp_drop -100, 100, beat_speed: 50*sqrt(2) do
		t 12.5, -37.5; b 1/2
		t 12.5, -12.5; b 1/2
	end
end
connect_tap -62.5, 50, -PI/4, true; b 1/4
connect_tap -50, 25, -PI*3/4
connect_tap -62.5, 0, -PI/4, true; b 1/4
connect_tap -50, -25, -PI*3/4
tp_drop -100, 100, beat_speed: 50*sqrt(2) do
	t -100, -37.5; b 1/2
	t -100, -12.5; b 1/2
end

def double_chain x, y, angle
	group do
		dx, dy = 25*sqrt(2)*cos(angle), 25*sqrt(2)*sin(angle)
		tp_chain -200*cos(angle), -200*sin(angle), beat_speed: 100*sqrt(2), preserve_beat: false do
			f x, y, angle; b 1/4
			d x+dx, y+dy; b 1/4
			d x+2*dx, y+2*dy; b 1/2
		end
		tp_chain 200*cos(angle), 200*sin(angle), beat_speed: 100*sqrt(2) do
			t x+dx*2, y+dy*2; b 1/2
			t x, y; b 1/2
		end
	end
end
diamond_grid 6
double_chain -50, 50, -PI/4
double_chain 50, 50, -PI*3/4
double_chain -50, -50, PI/4
double_chain 50, -50, PI*3/4

double_chain -50, 50, -PI*3/4
double_chain 50, 50, -PI/4
double_chain -50, -50, PI*3/4
double_chain 50, -50, PI/4

checkerboard 2
tp_drop 0, 100, 1 do
	t -37.5, -37.5; t 37.5, -37.5; b 1/4
	t -12.5, -25; b 1/4
	t 12.5, -12.5; b 1/4
	t -37.5, 0; t 37.5, 0; b 1/4
	t -12.5, 12.5; b 1/4
	t 12.5, 25; b 1/4
	t -37.5, 37.5; t 37.5, 37.5; b 1/4
	t -12.5, 50; b 1/4
end
tp_drop 0, -100, 1 do
	4.times do |i|
		x = 37.5 - 12.5*i
		y = 50 - 12.5*i
		i.zero? ? f(x, y, :dl) : d(x, y); b 1/8
	end
	f -12.5, 0, :dr; b 1/4
	d 0, -12.5; b 1/4
	t -37.5, -25; t 37.5, -25; b 1/2
	t -37.5, -50; t 37.5, -50; b 1/2
end

pentagon 5
tp_drop 0, 100, 1, preserve_beat: false do
	x = 50*cos(1.3*PI)
	y = 50*sin(1.3*PI)
	2.times do
		f x, y, :l; b 1
		f -x, y, :r; b 1
	end
end
tp_chain 0, 0, relative: false, relative_beat: 1/2 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	t x, y; b 1/2
	t 0, 0; b 1/2
	t -x, y; b 1/2
	t 0, 0; b 1/2
	t 0, 50; b 1/2
	t 0, 0; b 1/2
	t 0, 50; b 1/2
	t 0, 0; b 1/2
end

tp_drop 0, -100, 1 do
	x = 50*cos(0.1*PI) / 2
	y = 50*(sin(0.1*PI) + 1) / 2
	t -x, y; b 1/3
	t 0, y; b 1/3
	t x, y; b 1/3
end
tp_drop 0, 100, 1 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	t -x, y; t x, y; b 1/4
	x = 50*(cos(0.1*PI) + cos(-0.3*PI)) / 2
	y = 50*(sin(0.1*PI) + sin(-0.3*PI)) / 2
	d -x, y; d x, y; b 1/4
	x = 50*cos(-0.3*PI) / 2
	y = 50*sin(-0.3*PI) / 2
	t -x, y; t x, y; b 1/2
end

group preserve_beat: false do
	connect_tap 62.5, -37.5, PI*3/4, true; b 1/4
	connect_tap 25, -12.5, PI/4
	connect_tap 62.5, 12.5, PI*3/4, true
end
connect_tap -37.5, -37.5, PI*3/4
connect_tap -75, -12.5, PI/4, true; b 1/4
connect_tap -37.5, 12.5, PI*3/4, true

diamond_grid 6
group preserve_beat: false do
	8.times do |i|
		angle = PI*3/4 - i*PI/2
		x = 50*sqrt(2)*cos(angle)
		y = 50*sqrt(2)*sin(angle)
		tp_chain -2*x, -2*y, relative: false, beat_speed: 100*sqrt(2) do
			f x, y, angle+PI; b 1
		end
	end
end
notes = group do
	notes = tp_chain 0, 0, relative: false, relative_beat: 1/2 do
		t 50, 50; b 1/2
		t 0, 0; b 1/2
		t -50, -50; b 1/2
		t 0, 0; b 1/2
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 2
	end
	b 2
end
transform duplicate notes do
	vertical_flip
	beat_translate 4
end
b 4

def pattern2 second = false
	group do
		notes = group do
			connect_tap -75, 50, -PI/4
			connect_tap -62.5, 25, -PI*3/4
			connect_tap -75, 0, -PI/4
			connect_tap -62.5, -25, -PI*3/4
			tap_chain -100, -37.5, PI/4
			tap_chain -87.5, 0, PI/4
		end

		unless second
			tap_chain -75, 37.5, -PI*3/4
			tap_chain -62.5, 12.5, -PI*3/4
			tap_chain -62.5, -25, PI*3/4
			tap_chain -75, -50, PI*3/4
			connect_tap 0, -50, PI*3/4
			connect_tap -12.5, -25, PI*3/4
			connect_tap -50, 0, PI*3/4, true
		else
			tp_drop 100, 100, beat_speed: 50*sqrt(2) do
				f -62.5, 50, :r; b 1/4
				d -50, 50; b 1/4
				t -37.5, 37.5; b 1/4
				d -50, 37.5; b 1/4
				f -75, 25, :r; b 1/4
				d -62.5, 25; b 1/4
				t -25, 12.5; b 1/4
				d -37.5, 12.5; b 1/4
				f -75, -12.5, :r; b 1/4
				d -62.5, -12.5; b 1/4
				t -25, -25; b 1/4
				d -37.5, -25; b 1/4
				f -62.5, -37.5, :r; b 1/4
				d -50, -37.5; b 1/4
				t -37.5, -50; b 1/4
				d -50, -50; b 1/4
			end
		end
	end
end
grid 32
hold_4
transform(pattern2) { horizontal_flip }
pattern2 true

notes = group do
	transform(hold_4) { horizontal_flip }
	pattern1
	transform(pattern1 true) { horizontal_flip }

	notes = group do
		connect_tap 75, 50, -PI/4
		connect_tap 87.5, 25, -PI*3/4
		connect_tap 75, 0, -PI/4
		connect_tap 87.5, -25, -PI*3/4
		tp_drop -100, 100, beat_speed: 50*sqrt(2) do
			t 37.5, -37.5; b 1/2
			t 37.5, -12.5; b 1/2
		end
	end
	transform duplicate notes do
		translate -125, 0
	end

	diamond_grid 6
	double_chain -50, 50, -PI/4
	double_chain 50, 50, -PI*3/4
	double_chain -50, -50, PI/4
	double_chain 50, -50, PI*3/4

	double_chain -50, 50, -PI*3/4
	double_chain 50, 50, -PI/4
	double_chain -50, -50, PI*3/4
	double_chain 50, -50, PI/4

	checkerboard 2
	tp_drop 0, 100, 1 do
		t -37.5, -37.5; t 37.5, -37.5; b 1/4
		t -12.5, -25; b 1/4
		t 12.5, -12.5; b 1/4
		t -37.5, 0; t 37.5, 0; b 1/4
		t -12.5, 12.5; b 1/4
		t 12.5, 25; b 1/4
		t -37.5, 37.5; t 37.5, 37.5; b 1/4
		t -12.5, 50; b 1/4
	end
	tp_drop 0, -100, 1 do
		t 12.5, 37.5; b 1/8
		d 0, 37.5; b 1/8
		t -12.5, 25; b 1/8
		d 0, 25; b 1/8
		t 12.5, 12.5; b 1/4
		t -12.5, 0; b 1/4
		t -37.5, -25; t 37.5, -25; b 1/2
		t -37.5, -50; t 37.5, -50; b 1/2
	end

	pentagon 5
	tp_drop 0, 100, 1, preserve_beat: false do
		x = 50*cos(1.3*PI)
		y = 50*sin(1.3*PI)
		2.times do
			f x, y, :l; b 1
			f -x, y, :r; b 1
		end
	end
	tp_chain 0, 0, relative: false, relative_beat: 1/2 do
		x = 50*cos(0.1*PI)
		y = 50*sin(0.1*PI)
		t x, y; b 1/2
		t 0, 0; b 1/2
		t -x, y; b 1/2
		t 0, 0; b 1/2
		t 0, 50; b 1/2
		t 0, 0; b 1/2
		t 0, 50; b 1/2
		t 0, 0; b 1/2
	end

	tp_drop 0, -100, 1 do
		x = 50*cos(0.1*PI) / 2
		y = 50*(sin(0.1*PI) + 1) / 2
		t -x, y; b 1/3
		t 0, y; b 1/3
		t x, y; b 1/3
	end
	tp_drop 0, 100, 1 do
		x = 50*cos(0.1*PI)
		y = 50*sin(0.1*PI)
		t -x, y; t x, y; b 1/4
		x = 50*(cos(0.1*PI) + cos(-0.3*PI)) / 2
		y = 50*(sin(0.1*PI) + sin(-0.3*PI)) / 2
		d -x, y; d x, y; b 1/4
		x = 50*cos(-0.3*PI) / 2
		y = 50*sin(-0.3*PI) / 2
		t -x, y; t x, y; b 1/2
	end

	notes = group do
		connect_tap 62.5, -37.5, PI*3/4
		connect_tap 25, -12.5, PI/4
		connect_tap 62.5, 12.5, PI*3/4, true
	end
	transform(duplicate notes) { translate -100, 0 }

	diamond_grid 6
	group preserve_beat: false do
		8.times do |i|
			angle = PI*3/4 - i*PI/2
			x = 50*sqrt(2)*cos(angle)
			y = 50*sqrt(2)*sin(angle)
			tp_chain -2*x, -2*y, relative: false, beat_speed: 100*sqrt(2) do
				f x, y, angle+PI; b 1
			end
		end
	end
	notes = group do
		notes = tp_chain 0, 0, relative: false, relative_beat: 1/2 do
			t 50, 50; b 1/2
			t 0, 0; b 1/2
			t -50, -50; b 1/2
			t 0, 0; b 1/2
		end
		transform duplicate notes do
			horizontal_flip
			beat_translate 2
		end
		b 2
	end
	transform duplicate notes do
		vertical_flip
		beat_translate 4
	end
	b 4

	grid 16
	hold_4
	transform(pattern2) { horizontal_flip }
	pattern2 true
end
transform(notes) { horizontal_flip }

8.times do |i|
	x = 100-12.5*i
	notes = group do
		tp_chain 0, 100, 0.5, preserve_beat: false do
			t -x, 50; b 1/4
			d -x+12.5, 25; b 1/4
			d -x+18.75, 0; b 1/4
			d -x+25, -25; b 1/4
		end
		tp_chain 0, -100, 0.5 do
			t x, -50; b 1/2
			t x-12.5, 0; b 1/2
		end
	end
	transform(notes) { horizontal_flip } if i.odd?
end
8.times do |i|
	x = 12.5+12.5*i
	notes = group do
		tp_chain 0, 100, 0.5, preserve_beat: false do
			t -x, 50; b 1/4
			d -x+12.5, 25; b 1/4
			d -x+6.25, 0; b 1/4
			d -x, -25; b 1/4
		end
		tp_chain 0, -100, 0.5 do
			f x, -50, :u; b 1/2
			t x-12.5, 0; b 1/2
		end
	end
	transform(notes) { horizontal_flip } if i.odd?
end

tp_chain 0, -100, 0.5 do
	h 100, -50, 8-1/2
end
group preserve_beat: false do
	256.times do |i|
		angle = PI/2 - PI/4*i
		r = (64...96).include?(i%128) ? 37.5 : 50
		x = ((i/128).floor.even? ? -50 : 50) + r*cos(angle)
		y = ((i/128).floor.even? ? r : -r)*sin(angle)
		tp_chain -r*2*cos(angle), -y*2, relative_beat: 2 do
			i%4==0 ? t(x, y) : d(x, y); b 1/4
		end
	end
end
notes = tp_drop 100, 0, 1 do
	b 8
	
	t 75, 25; b 5
	t 75, -25; b 1
	t 75, 25; b 3/4
	t 62.5, 0; b 3/4
	t 50, -25; b 1/2

	t 50, -50; b 3
	t 75, 50; b 1/2
	t 87.5, 25; b 1
	t 50, 37.5; b 1/2
	t 62.5, 12.5; b 1
	t 87.5, 25; b 1/2
	t 87.5, 0; b 1/2
	t 100, -25; b 1

	t 50, 50; b 2
	t 50, -25; b 2
	t 37.5, 37.5; b 1
	t 25, 12.5; b 1
	t 37.5, -12.5; b 1
	t 62.5, -25; b 1
end
transform duplicate notes do
	horizontal_flip
	beat_translate 32
end
tp_drop -100, 0, 1 do
	t -50, 50
end
b 32

def drop x_coordinates
	tp_drop 0, 175, 1 do
		x_coordinates.each do |x|
			unless x
				b 1/4
				next
			end
			x = [x] unless x.is_a? Array
			x.each do |x|
				t x, -50
			end
			b 1/4
		end
	end
end
drop [
	[-50, 50], nil, -75, -25,
	-62.5, 0, -50, 25,
	-37.5, 50, -50, 62.5,
	-25, 12.5, 62.5, 87.5
]

b 1/4
t -100, 37.5; t 25, 50; b 3/4
t -50, 50; t 75, 25; b 3/4
t -12.5, 25; t 100, 37.5; b 3/4
t -62.5, 12.5; t 25, 12.5; b 3/4
t -50, -12.5; t 50, -25; b 3/4

drop [
	[-62.5, 37.5], -25, 0, -25,
	37.5, -25, 0, -25,
	37.5, -25, 37.5, -25,
	37.5, -25, 37.5, 50
]

b 1/2
t 100, 37.5; t -75, 50; b 1/2
t 12.5, 25; t -100, 37.5; b 1
t 50, 50; t -50, 25; b 3/4
t 62.5, 0; t -25, 0; b 3/4
t 50, -25; t -50, -12.5; b 1/2

drop [
	[-75, 75], nil, -12.5, 12.5,
	-12.5, 12.5, [-50, 50], nil,
	-12.5, 12.5, -12.5, 12.5,
	-25, 25, 0, 37.5,

	*([62.5, 37.5, 12.5, 37.5]*2),
	62.5, 37.5, 62.5, 87.5,
	-37.5, -12.5, 25, 62.5,

	100, -50, -75, -50,
	[-75, 25], 0, -25, -50,
	[-75, 37.5], 0, -25, [-62.5, 50],
	12.5, -25, [-62.5, 75], nil
]

t -75, 25; b 1/4
t -87.5, 37.5; t 50, 50; b 3/4
t -50, 50; t 75, 25; b 3/4
t -12.5, 25; t 100, 37.5; b 3/4
t -62.5, 0; t 25, 12.5; b 3/4
t -50, -25; t 75, -12.5; b 3/4

drop [
	[0, 62.5], nil, -75, -25,
	25, -62.5, -25, 0,
	37.5, -50, -12.5, 37.5
]
t 0, -25; t 75, -25; b 1/2
t -50, 0; t 50, 0; b 1/2

drop [
	nil, nil, -75, nil,
	-12.5, nil, 37.5, nil,
	-100, 0, -62.5, 12.5,
	-50, 37.5, -37.5, 25,

	-62.5, -25, 25, -37.5,
	50, 12.5, -37.5, 25,
	62.5, 25, -25, -50
]
t -75, -25; t 0, -25; b 1/2
t -50, 0; t 50, 0; b 1/2

drop [
	nil, nil, 75, nil,
	12.5, nil, -37.5, nil,
	-75, -37.5, 0, -50,
	25, -12.5, 37.5, 62.5,

	[-100, 87.5], 50, 12.5, -25,
	-62.5, nil, [-100, 87.5], 50,
	12.5, -25, -62.5, nil,
	[-100, 87.5], 50, 12.5, -25,

	-62.5, nil, [-100, 87.5], nil,
	[-100, 87.5], 50, 12.5, nil,
	[-100, 87.5], 50, 12.5, nil,
	[-75, 75], nil, [-50, 50], nil,

	[-25, 25], nil, -100, -25,
	-75, -12.5, 25, 50,
	-50, 0, 37.5, 62.5,
	-37.5, 25, 50, 75,

	100, 62.5, 12.5, -25,
	87.5, 50, 25, -12.5,
	100, 12.5, 50, -37.5,
	37.5, -25, 25, -50,

	-100, -50, 25, -25,
	[-75, 50], nil, -100, -50,
	25, -25, [-50, 62.5], nil,
	nil, nil, [-37.5, 37.5], nil
]

def cycle
	tp_chain 0, 175, 1 do
		16.times do |i|
			x = i/16+1/4
			x = (4*(x-x.round).abs - 1)*100
			y = i/16
			y = (4*(y-y.round).abs - 1)*50
			t x, y; b 1/4
		end
	end
end
cycle

drop [
	0, 50, -25, 25,
	[75, -50], nil, 100, 50,
	-25, 25, [50, -62.5], nil,
	nil, nil, [-37.5, 37.5], nil
]

transform(cycle) { horizontal_flip }

drop [
	0, -50, -25, -75,
	-25, -50, -75, -100,
	-12.5, -50, -75, 0,
	-50, -75, 12.5, -50,

	-75, 25, -50, -75,
	37.5, -50, -75, 50,
	-50, -75, 62.5, -50,
	75, 25, 50, 75,

	100, 75, 50, 25,
	75, 50, 25, 0,
	37.5, 12.5, -12.5, -37.5,
	0, -25, -50, -75
]

b 1/4
t -50, 37.5; b 1/4
t -62.5, 50; t 75, 37.5; b 1/2
t 25, 12.5; b 1/4
t -87.5, 12.5; t 37.5, 25; b 1/2
t -62.5, -25; b 1/4
t -75, -12.5; t -12.5, 0; b 1/2
t 75, 0; b 1/4
t 0, 25; t 87.5, 12.5; b 1/2
t -25, -25; b 1/4
t -37.5, -12.5; t 50, -12.5; b 1/2

drop [
	[-75, 25], nil, -100, -50,
	-75, -100, -75, -50,
	*([-12.5, -37.5, -12.5, 12.5]*2),

	*([50, 25, 50, 75]*2),
	50, 25, 50, 25,
	0, 25, 0, -25
]

b 1/2
t -87.5, 37.5; t 50, 50; b 1/2
t -50, 50; t 75, 25; b 1
t -12.5, 25; t 100, 37.5; b 3/4
t -62.5, 0; t 25, 12.5; b 3/4
t -50, -25; t 75, -12.5; b 1/2

drop [
	0, 100, 75, 100,
	-37.5, 100, 75, 100,
	-62.5, 100, 75, 100,
	-37.5, 100, 75, 100,

	-25, 0, 25, 50,
	12.5, nil, -25, 50,
	87.5, 37.5, 0, nil,
	-12.5, 25, 62.5, 100,

	-100, -50, 0, 62.5,
	-75, -37.5, 25, 75,
	-50, -25, 37.5, 87.5,
	-12.5, 25, 62.5, 100,

	[-100, 75], -50, 0, 50,
	-75, -37.5, 62.5, 12.5,
	-50, -25, 25, 62.5,
	-12.5, 25, 75, 50,

	-37.5, -87.5, 12.5, 50,
	25, -62.5, 0, -75,
	-100, -50, 37.5, 75,
	50, -37.5, 25, 62.5,

	[-100, 100], -50, 50, 0,
	-75, -37.5, 12.5, 75,
	-50, -25, 62.5, 25,
	-12.5, 25, 75, 50,

	[-100, 100], -25, 50, 0,
	-75, -50, 12.5, 62.5,
	[-100, 100], -25, 62.5, 25,
	[-100, 100], -62.5, 75, 50,
]

transform(peace_theme) { horizontal_flip }

def connect_tap x, y, angle, no_end = false
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 50*sqrt(2) do
		f x, y, angle; b 1/2
		next if no_end
		t x+25*sqrt(2)*cos(angle), y+25*sqrt(2)*sin(angle); b 1/4
	end
end
def double_chain x, y, angle
	group do
		dx, dy = 25*sqrt(2)*cos(angle), 25*sqrt(2)*sin(angle)
		tp_chain -200*cos(angle), -200*sin(angle), beat_speed: 100*sqrt(2), preserve_beat: false do
			f x, y, angle; b 1/4
			t x+dx, y+dy; b 3/4
		end
		tp_chain 200*cos(angle), 200*sin(angle), beat_speed: 100*sqrt(2) do
			t x+dx*2, y+dy*2; b 1/2
			t x, y; b 1/2
		end
	end
end
notes = group do
	transform(hold_4) { horizontal_flip }
	pattern1
	transform(pattern1 true) { horizontal_flip }

	notes = group do
		connect_tap 75, 50, -PI/4
		connect_tap 87.5, 25, -PI*3/4
		connect_tap 75, 0, -PI/4
		connect_tap 87.5, -25, -PI*3/4
		tp_drop -100, 100, beat_speed: 50*sqrt(2) do
			t 37.5, -37.5; b 1/2
			t 37.5, -12.5; b 1/2
		end
	end
	transform duplicate notes do
		translate -125, 0
	end

	diamond_grid 6
	double_chain -50, 50, -PI/4
	double_chain 50, 50, -PI*3/4
	double_chain -50, -50, PI/4
	double_chain 50, -50, PI*3/4

	double_chain -50, 50, -PI*3/4
	double_chain 50, 50, -PI/4
	double_chain -50, -50, PI*3/4
	double_chain 50, -50, PI/4

	checkerboard 2
	tp_drop 0, 100, 1 do
		t -37.5, -37.5; t 37.5, -37.5; b 1/4
		t -12.5, -25; b 1/4
		t 12.5, -12.5; b 1/4
		t -37.5, 0; t 37.5, 0; b 1/4
		t -12.5, 12.5; b 1/4
		t 12.5, 25; b 1/4
		t -37.5, 37.5; t 37.5, 37.5; b 1/4
		t -12.5, 50; b 1/4
	end
	tp_drop 0, -100, 1 do
		t 12.5, 37.5; b 1/8
		d 0, 37.5; b 1/8
		t -12.5, 25; b 1/8
		d 0, 25; b 1/8
		t 12.5, 12.5; b 1/4
		t -12.5, 0; b 1/4
		t -37.5, -25; t 37.5, -25; b 1/2
		t -37.5, -50; t 37.5, -50; b 1/2
	end

	pentagon 5
	tp_drop 0, 100, 1, preserve_beat: false do
		x = 50*cos(1.3*PI)
		y = 50*sin(1.3*PI)
		2.times do
			t x, y; b 1
			t -x, y; b 1
		end
	end
	tp_chain 0, 0, relative: false, relative_beat: 1/2 do
		x = 50*cos(0.1*PI)
		y = 50*sin(0.1*PI)
		f x, y, :r; b 1/2
		t 0, 0; b 1/2
		f -x, y, :l; b 1/2
		t 0, 0; b 1/2
		f 0, 50, :r; b 1/2
		t 0, 0; b 1/2
		f 0, 50, :l; b 1/2
		t 0, 0; b 1/2
	end

	tp_drop 0, -100, 1 do
		x = 50*cos(0.1*PI) / 2
		y = 50*(sin(0.1*PI) + 1) / 2
		t -x, y; b 1/3
		t 0, y; b 1/3
		t x, y; b 1/3
	end
	tp_drop 0, 100, 1 do
		x = 50*cos(0.1*PI)
		y = 50*sin(0.1*PI)
		t -x, y; t x, y; b 1/4
		x = 50*(cos(0.1*PI) + cos(-0.3*PI)) / 2
		y = 50*(sin(0.1*PI) + sin(-0.3*PI)) / 2
		d -x, y; d x, y; b 1/4
		x = 50*cos(-0.3*PI) / 2
		y = 50*sin(-0.3*PI) / 2
		t -x, y; t x, y; b 1/2
	end

	notes = group do
		connect_tap 62.5, -37.5, PI*3/4
		connect_tap 25, -12.5, PI/4
		connect_tap 62.5, 12.5, PI*3/4, true
	end
	transform(duplicate notes) { translate -100, 0 }

	diamond_grid 6
	group preserve_beat: false do
		8.times do |i|
			angle = PI*3/4 - i*PI/2
			x = 50*sqrt(2)*cos(angle)
			y = 50*sqrt(2)*sin(angle)
			tp_chain -2*x, -2*y, relative: false, beat_speed: 100*sqrt(2) do
				b 1/4; t x, y; b 3/4
			end
		end
	end
	notes = group do
		notes = tp_chain 0, 0, relative: false, relative_beat: 1/2 do
			t 50, 50; b 1/2
			t 0, 0; b 1/2
			t -50, -50; b 1/2
			t 0, 0; b 1/2
		end
		transform duplicate notes do
			horizontal_flip
			beat_translate 2
		end
		b 2
	end
	transform duplicate notes do
		vertical_flip
		beat_translate 4
	end
	b 4

	grid 16
	hold_4
	transform(pattern2) { horizontal_flip }
	pattern2 true
end
transform(notes) { horizontal_flip }

def connect_tap x, y, angle, no_end = false
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 50*sqrt(2) do
		f x, y, angle; b 1/4
		d x+12.5*sqrt(2)*cos(angle), y+12.5*sqrt(2)*sin(angle); b 1/4
		next if no_end
		t x+25*sqrt(2)*cos(angle), y+25*sqrt(2)*sin(angle); b 1/4
	end
end
transform(hold_4) { horizontal_flip }
pattern1
transform(pattern1 true) { horizontal_flip }

notes = group do
	connect_tap 75, 50, -PI/4
	connect_tap 87.5, 25, -PI*3/4
	connect_tap 75, 0, -PI/4
	connect_tap 87.5, -25, -PI*3/4
	tp_drop -100, 100, beat_speed: 50*sqrt(2) do
		t 37.5, -37.5; b 1/2
		t 37.5, -12.5; b 1/2
	end
end
transform duplicate notes do
	translate -125, 0
end

diamond_grid 6
double_chain -50, 50, -PI/4
double_chain 50, 50, -PI*3/4
double_chain -50, -50, PI/4
double_chain 50, -50, PI*3/4

double_chain -50, 50, -PI*3/4
double_chain 50, 50, -PI/4
double_chain -50, -50, PI*3/4
double_chain 50, -50, PI/4

checkerboard 2
tp_drop 0, 100, 1 do
	t -37.5, -37.5; t 37.5, -37.5; b 1/4
	t -12.5, -25; b 1/4
	t 12.5, -12.5; b 1/4
	t -37.5, 0; t 37.5, 0; b 1/4
	t -12.5, 12.5; b 1/4
	t 12.5, 25; b 1/4
	t -37.5, 37.5; t 37.5, 37.5; b 1/4
	t -12.5, 50; b 1/4
end
tp_drop 0, -100, 1 do
	t 12.5, 37.5; b 1/8
	d 0, 37.5; b 1/8
	t -12.5, 25; b 1/8
	d 0, 25; b 1/8
	t 12.5, 12.5; b 1/4
	t -12.5, 0; b 1/4
	t -37.5, -25; t 37.5, -25; b 1/2
	t -37.5, -50; t 37.5, -50; b 1/2
end

pentagon 5
tp_drop 0, 100, 1, preserve_beat: false do
	x = 50*cos(1.3*PI)
	y = 50*sin(1.3*PI)
	2.times do
		t x, y; b 1
		t -x, y; b 1
	end
end
tp_chain 0, 0, relative: false, relative_beat: 1/2 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	f x, y, :r; b 1/2
	t 0, 0; b 1/2
	f -x, y, :l; b 1/2
	t 0, 0; b 1/2
	f 0, 50, :r; b 1/2
	t 0, 0; b 1/2
	f 0, 50, :l; b 1/2
	t 0, 0; b 1/2
end

tp_drop 0, -100, 1 do
	x = 50*cos(0.1*PI) / 2
	y = 50*(sin(0.1*PI) + 1) / 2
	t -x, y; b 1/3
	t 0, y; b 1/3
	t x, y; b 1/3
end
tp_drop 0, 100, 1 do
	x = 50*cos(0.1*PI)
	y = 50*sin(0.1*PI)
	t -x, y; t x, y; b 1/4
	x = 50*(cos(0.1*PI) + cos(-0.3*PI)) / 2
	y = 50*(sin(0.1*PI) + sin(-0.3*PI)) / 2
	d -x, y; d x, y; b 1/4
	x = 50*cos(-0.3*PI) / 2
	y = 50*sin(-0.3*PI) / 2
	t -x, y; t x, y; b 1/2
end

notes = group do
	connect_tap 62.5, -37.5, PI*3/4
	connect_tap 25, -12.5, PI/4
	connect_tap 62.5, 12.5, PI*3/4, true
end
transform(duplicate notes) { translate -100, 0 }

diamond_grid 6
group preserve_beat: false do
	8.times do |i|
		angle = PI*3/4 - i*PI/2
		x = 50*sqrt(2)*cos(angle)
		y = 50*sqrt(2)*sin(angle)
		tp_chain -2*x, -2*y, relative: false, beat_speed: 100*sqrt(2) do
			b 1/4; t x, y; b 3/4
		end
	end
end
notes = group do
	notes = tp_chain 0, 0, relative: false, relative_beat: 1/2 do
		h 50, 50, 1/2; b 1/2
		t 0, 0; b 1/2
		t -50, -50; b 1/2
		t 0, 0; b 1/2
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 2
	end
	b 2
end
transform duplicate notes do
	vertical_flip
	beat_translate 4
end
b 4

grid 16
hold_4
transform(pattern2) { horizontal_flip }
pattern2 true

8.times do |i|
	x = 100-12.5*i
	notes = group do
		tp_chain 0, 100, 0.5, preserve_beat: false do
			t -x, 50; b 1/4
			t -x+12.5, 25; b 1/2
			t -x+25, -25; b 1/4
		end
		tp_chain 0, -100, 0.5 do
			t x, -50; b 1/2
			t x-12.5, 0; b 1/2
		end
	end
	transform(notes) { horizontal_flip } if i.odd?
end
8.times do |i|
	x = 12.5+12.5*i
	notes = group do
		tp_chain 0, 100, 0.5, preserve_beat: false do
			t -x, 50; b 1/4
			t -x+12.5, 25; b 1/2
			t -x, -25; b 1/4
		end
		tp_chain 0, -100, 0.5 do
			f x, -50, :u; b 1/2
			t x-12.5, 0; b 1/2
		end
	end
	transform(notes) { horizontal_flip } if i.odd?
end

turntable 16
notes = tp_chain 0, -100, 0.5 do
	129.times do |i|
		if i == 0
			h 100, -50, 16
		elsif i >= 6
			angle = PI/2 - PI/8*i
			x = 50*cos(angle)
			y = 50*sin(angle)
			d x, y
		end
		b 1/8
	end
end
transform duplicate notes do
	rotate PI
end

end
