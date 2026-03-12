include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'master' do

title 'OTTAMA GAZER'
artist 'MYUKKE.'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'
difficulty_sup ?+

offset 2.823
bpm 170

# intro 1
def intro1; group do
group preserve_beat: false do
	tp_drop -100, 0, 1 do
		h -87.5, 25, 3; b 4
		h -75, 0, 3; b 4
		h -62.5, -25, 3; b 4
		h -50, -50, 3; b 4
	end
	tp_drop 100, 0, 1 do
		h 87.5, 50, 3; b 4
		h 75, 25, 3; b 4
		h 62.5, 0, 3; b 4
		h 50, -25, 3; b 4
	end
end

tp_chain 0, 100, 1 do
	t 87.5, 25; b 1/2
	t 75, 12.5; b 1/2
	t 62.5, 25; b 1/2
	t 50, 37.5; b 1/2
	t 37.5, 25; b 1/2
	t 25, 37.5; b 1/2
	t 12.5, 25; b 1/2
	t 0, 12.5; b 1/2

	t 12.5, 0; b 1/2
	t 25, -12.5; b 1/2
	t 37.5, -25; b 1/2
	t 50, -37.5; b 1/2
	t 62.5, -50; b 1/2
	t 75, -37.5; b 1/2
	t 87.5, -25; b 1/2
	t 100, -12.5; b 1/2

	t 87.5, 0; b 1
end
tp_drop 0, 100, 1 do
	6.times { t 50, -50; b 1/2 }

	2.times { t 50, -50; b 1/2 }
	t 50, -50; b 1
	t 50, -50; b 2
end

tp_chain 0, 100, 1 do
	t -87.5, 25; b 1/2
	t -75, 12.5; b 1
	f -50, 12.5, :up_right; b 1/4
	d -37.5, 25; b 1/4
	d -25, 37.5; b 1/2
	t -12.5, 25; b 1
	t -12.5, 0; b 1/2

	t -25, -12.5; b 1/2
	t -37.5, -25; b 1/2
	t -50, -37.5; b 1/2
	t -62.5, -25; b 1/2
	t -75, -12.5; b 1
	t -100, -37.5; b 1
end

tp_drop 0, 100, 1 do
	t -50, -50; b 1
	6.times { t -50, -50; b 1/2 }

	2.times { t -50, -50; b 1/2 }
	3.times { t -50, -50; b 1 }
end
end; end
intro1

# intro 2 (intro 1 + vocal)
def intro2 ending = false; group do
tp_chain 0, 100, 1, preserve_beat: false do
	h 87.5, 25, 3; b 1/2
	d 75, 12.5; b 1/2
	d 62.5, 25; b 1/2
	d 50, 37.5; b 1/2
	d 37.5, 25; b 1/2
	d 25, 37.5; b 1/2
	d 12.5, 25; b 1/2
	d 0, 12.5; b 1/2

	h 12.5, 0, 3; b 1/2
	d 25, -12.5; b 1/2
	d 37.5, -25; b 1/2
	d 50, -37.5; b 1/2
	d 62.5, -50; b 1/2
	d 75, -37.5; b 1/2
	d 87.5, -25; b 1/2
	d 100, -12.5; b 1/2

	h 87.5, 0, 3; b 1
end

tp_chain 0, 100, 1 do
	t -87.5, 25; b 3/4
	t -62.5, 25; b 1/4
	t -50, 12.5; b 1
	t -25, 0; b 1
	t -50, -12.5; b 1

	t -75, 0; b 1
	t -100, 0; b 1
	t -75, 0; b 1
	t -50, 12.5; b 1

	h -25, -12.5, 3+1/2; b 1
	6.times { |i| d -12.5+i*12.5, -12.5; b 1/2 }

	2.times { |i| d 62.5+i*12.5, -12.5; b 1/2 }
	d 87.5, -12.5; b 1
	d 100, -12.5; b 2
end

tp_chain 0, 100, 1, preserve_beat: false do
	h -87.5, 25, 3; b 1/2
	d -75, 12.5; b 1
	d -50, 12.5; b 1/4
	d -37.5, 25; b 1/4
	d -25, 37.5; b 1/2
	d -12.5, 25; b 1
	d -12.5, 0; b 1/2

	h -25, -12.5, 3; b 1/2
	d -37.5, -25; b 1/2
	d -50, -37.5; b 1/2
	d -62.5, -25; b 1/2
	d -75, -12.5; b 1
	d -100, -37.5; b 1

	h -75, -50, 3; b 3/2
	d -50, 0; b 1/2
	d -37.5, -12.5; b 1/2
	d -25, -25; b 1/2
	d -12.5, -37.5; b 1/2
	d 0, -50; b 1/2

	h 12.5, -37.5, 5/2
end

tp_chain 0, 100, 1 do
	t 87.5, 25; b 3/4
	t 62.5, 25; b 1/4
	t 50, 12.5; b 1
	t 25, 0; b 1
	t 50, -12.5; b 1

	t 75, 0; b 1
	t 100, 0; b 1
	t 75, -12.5; b 1
	t 50, 0; b 1

	h 25, 12.5, 3+1/2; b 4
end

b 1
tp_chain 0, 100, beat_speed: 25 do
	t 50, 25; b 1
	t 50, 0; b 1
end
tp_chain 0, -100, 1 do # drum at end of intro 2
	unless ending
		t -12.5, -25; b 1/4
		t 12.5, -12.5; b 1/4
		t -12.5, 0; b 1/4
		t 12.5, 12.5; b 1/4
	end

	f -12.5, 25, :up; b 1 if ending
end
end; end
intro2
# intro 3
tp_drop 0, 100, 1, preserve_beat: false do
	notes = group do
		2.times do
			3.times { b 1; f -75, 0, :left; b 1 }
			2.times { b 1/2; f -75, 0, :left }
			b 1
		end
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 16
	end
end
tp_chain 0, 100, 1 do
	h 25, 25, 1; b 3/2
	h 50, 50, 2; b 1/2+2

	h 75, 25, 3; b 3+1/2
	h 100, 0, 4; b 1/4
	d 87.5, 12.5; b 1/4

	d 75, 0; b 4

	h 25, 37.5, 3+1/2; b 4
end

tp_chain 0, 100, 1 do
	h -25, 25, 2; b 5/2
	t -50, -37.5; b 1/2
	t -62.5, -25; b 1/2
	t -75, -12.5; b 1/2

	h -87.5, 0, 1; b 3/2
	h -75, -25, 2; b 5/2

	h -50, -50, 5/2; b 3
	h 0, -50, 4; b 1/4
	d -12.5, -37.5; b 1/4
	d -25, -25; b 1/4
	d -37.5, -12.5; b 1/4

	d -50, 0; b 4
end

# theme 1 (has the same drum as intro 3)
grid 15
tp_drop 0, 100, 1, preserve_beat: false do
	notes = group do
		3.times do
			t -25, -50; b 1
			f -75, 0, :left; b 1
		end
		t -25, -50; b 1/2
		f -75, 0, :left; b 1/2
		f -75, 0, :left; b 1
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 8
	end
end

tp_chain 0, 100, 1 do
	t 50, 25; b 3/2
	t 100, 0; b 1/2
	t 75, 0; b 1/2
	t 50, 0; b 1/2
	t 25, 25; b 1

	t 0, -25; b 1/2
	t 25, -25; b 1
	t 50, 25; b 1/2
	t 75, 25; b 1
	t 75, -25; b 1
end

tp_chain 0, 100, 1 do
	t -25, 0; b 1/2
	t -50, 0; b 1/2
	t -75, 0; b 1/2
	t -100, -25; b 3/2
	t -50, 0; b 1/2
	t -25, 25; b 1/2

	t 0, 50; b 3/2
	t -50, 25; b 3/2
	t -100, 0; b 1
end

notes = tp_chain 0, 100, 1 do # 8th kick
	t -75, 50; b 1/2
	t -50, 25; b 1/2
	f -50, -25, :left; b 1/2
	t -75, -50; b 1/2
	t -100, -37.5; b 1/2
	t -75, -12.5; b 1/2
	f -50, 12.5, :left; b 1/2
	t -25, 37.5; b 1/2
	
	t -50, 50; b 1/2
	t -75, 25; b 1/2
	f -75, -25, :left; b 1/2
	t -50, -50; b 1/2
	t -25, -37.5; b 1/2
	f -50, -12.5, :left; b 1/2
	f -75, 12.5, :left; b 1
end
transform(duplicate notes) { rotate PI }

tp_chain 0, -100, beat_speed: 100/2.5, preserve_beat: false do
	b 1/4
	5.times { |i| t -25, -50+(i+0.5)*100/5; b 1/2 }
end
tp_chain 0, -100, beat_speed: 100/2.5 do
	6.times do |i|
		if i == 2
			f 25, -50+i*100/5.0, :right; b 1/2
		else
			t 25, -50+i*100/5.0; b 1/2
		end
	end
end
tp_chain 0, 100, 1 do
	f 0, 0, :up; b 1
end

diamond_grid 3
notes = tp_chain -100, -100, beat_speed: 100*sqrt(2)/1.5 do
	50.step(-50, -100/3) { |y| t -y, y; b 1/2 }
	b 1/2
	t -75, 25; b 1/2
	f -100, 0, :left; b 1
end
transform(duplicate notes) { horizontal_flip }

# theme 2
tp_chain 0, 100, 1, preserve_beat: false do # 鼓点
	2.times do
		t 0, -50; b 2
		f -100, 0, :left; b 2

		t 0, 50; b 2
		f 100, 0, :right; b 2

		t 0, -50; b 2
		f -100, 0, :left; b 2

		t 0, 50; b 2
		f 100, 0, :right; b 3/2
		t 25, -25; b 1/4
		t 12.5, -37.5; b 1/4
	end
end
group preserve_beat: false do # 杂项采音
	b 1
	tp_chain 100, 0, 1 do
		t 50, -50 # guitar
	end
	b 3

	b 1
	tp_chain 0, -100, 1 do # 32rd
		f -50, -37.5, :up_left; b 1/8
		d -62.5, -25; b 1/8
		d -75, -12.5; b 1/8
		d -87.5, 0; b 1/8
	end
	b 1
	tp_chain -100, 0, 1 do
		t -25, -50 # vocal
	end
	b 3/2

	b 5/2
	tp_chain 100, 0, 1 do
		t 75, -50 # bass
	end
	b 3/2
	
	b 1
	tp_chain 0, -100, 1 do # 32rd
		f 0, -25, :up_left; b 1/8
		d -12.5, -12.5; b 1/8
		d -25, 0; b 1/8
		d -37.5, 12.5; b 1/8
	end
	b 1
	tp_chain -100, 0, 1 do
		t -50, -50 # drip
	end
	b 3/2
end
tp_chain 0, 100, 1 do
	h 50, 25, 1/2; b 1
	b 1/2 # guitar
	t 100, 12.5; b 1/2
	t 75, 12.5; b 1/2
	t 50, 0; b 1/2
	h 25, 25, 1/2; b 1

	t 0, -25; b 1/2
	t -25, -25; b 1/2
	b 1/2 # 32rd
	t -75, 12.5; b 1/2
	t -50, 12.5; b 1/2
	b 1/2 # vocal
	h -25, 25, 1/2; b 1

	t 12.5, 25; b 1/2
	t 37.5, 25; b 1/2
	t 62.5, 25; b 1/2
	h 87.5, 12.5, 1/2; b 1
	b 1/2 # bass
	t 50, -12.5; b 1/2
	t 25, 0; b 1/2

	h 0, 12.5, 1/2; b 1
	b 1/2 # 32rd
	t -50, 0; b 1/2
	t -75, 0; b 1/2
	b 1/2 # drip
	h -100, -12.5, 1/2; b 1
end

group preserve_beat: false do
	b 1
	tp_chain 100, 0, 1 do
		t 50, 50 # guitar
	end
	b 3

	b 1
	tp_chain 0, -100, 1 do # 32rd
		f -100, 0, :down_right; b 1/8
		d -87.5, -12.5; b 1/8
		d -75, -25; b 1/8
		d -62.5, -37.5; b 1/8
	end
	b 1
	tp_chain -100, 0, 1 do
		h -25, 50, 1/8 # bass
	end
	b 3/2

	b 5/2
	tp_chain 100, 0, 1 do
		h 75, 50, 1/8 # bass
	end
	b 3/2

	b 1
	tp_chain 0, -100, 1 do
		t -25, -50 # high
	end
end
tp_chain 0, 100, 1 do
	h 0, -12.5, 1/2; b 1
	b 1/2 # guitar
	t 50, 12.5; b 1/2
	t 25, 12.5; b 1/2
	t 0, 0; b 1/2
	h -25, 25, 1/2; b 1

	t -62.5, 25; b 1/2
	t -87.5, 25; b 1/2
	b 1/2 # 32rd
	t -50, -25; b 1/2
	t -25, -25; b 1/2
	b 1/2 # bass
	h 0, -12.5, 1/2; b 1

	t 25, 0; b 1/2
	t 50, 0; b 1/2
	t 75, 0; b 1/2
	h 100, -12.5, 1/2; b 1
	b 1/2 # bass
	t 50, -12.5; b 1/2
	t 25, 0; b 1/2

	h 0, 12.5, 1/2; b 1
	b 1/2 # high
	h -25, 50, 1; b 3/2
	h -25, 0, 1/2; b 1
end

# refrain 1
def curve x, y, angle, length, head: :tap, reverse: @default_reverse
	center_x = x
	center_y = y + 100
	radius = 100
	tp_drop center_x, center_y, 1, relative: false do
		n = (length*8).to_i
		n.times do |i|
			a = reverse ? (n-i-1)*angle/n : i*angle/n
			x = center_x + radius*sin(a)
			y = center_y - radius*cos(a)
			if i == 0
				case head
				when :tap then t x, y
				when :hold then h x, y, length
				when :drag then d x, y
				end
			else
				d x, y
			end
			b 1/8
		end
	end
end
def curves_pattern
	curve 0, -50, -PI/3, 1/2
	curve 37.5, -37.5, PI/3, 1/2
	curve -25, -12.5, -PI/4, 1/2, head: :hold
	curve 12.5, 37.5, PI/4, 1/2, head: :drag
	curve -50, 25, -PI/6, 1/2
	curve 50, 0, PI/6, 1/2
	curve -37.5, 12.5, -PI/4, 1/2
	curve 0, 0, PI/4, 1/2

	curve 0, -50, -PI/3, 1/2
	curve 37.5, -37.5, PI/3, 1/2
	curve -25, -12.5, -PI/4, 1/2
	curve 50, 12.5, PI/4, 1/2
	curve -50, 25, -PI/4, 1, head: :hold
	curve 50, 12.5, PI/6, 1/2
	curve -37.5, -12.5, -PI/4, 1/2, reverse: !@default_reverse

	notes = group do
		curve 0, 25, -PI/3, 1/2
		curve 37.5, 12.5, PI/3, 1/2
		curve -25, -12.5, -PI/4, 1/2
		curve 50, -37.5, PI/4, 1/2
		curve -50, -50, -PI/6, 1/2
		curve 50, -50, PI/6, 1/2
		curve -37.5, -37.5, -PI/4, 1/2
		curve 0, -25, PI/4, 1/2

		curve 0, 25, -PI/3, 1/2
		curve 37.5, 12.5, PI/3, 1/2
		curve -25, -12.5, -PI/4, 1/2
		curve 50, -37.5, PI/4, 1/2
		if @default_reverse
			curve -12.5, -50, -PI/3, 3/2, head: :hold
			b 1/2
		else
			curve -50, -50, -PI/4, 1, head: :hold
			curve 50, -25, PI/6, 1/2
			curve -37.5, -12.5, -PI/4, 1/2, reverse: !@default_reverse
		end
	end
	transform(notes) { horizontal_flip }
end
grid 31
curves = group do
	@default_reverse = false
	curves_pattern

	@default_reverse = true
	curves_pattern
end
transform(curves) do
	notes = curves.filter { _1.type != :placeholder }
	x_min, x_max = notes.map { _1[:x] }.minmax
	y_min, y_max = notes.map { _1[:y] }.minmax
	x_scale = 200/(x_max-x_min)
	y_scale = 100/(y_max-y_min)
	scale x_scale, y_scale
	translate -100 - x_min * x_scale, -50 - y_min * y_scale
end

# interlude 1
def clockwork x, y, angle
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 6.25*12, preserve_beat: false do
		(0...7).each do |i|
			b 1/12
			if i == 0
				f x, y, angle
			else
				d x+cos(angle)*i*6.25, y+sin(angle)*i*6.25
			end
		end
	end
end
group preserve_beat: false do
	b 4

	b 3
	clockwork 37.5, 0, PI/4; b 1

	b 3/2
	tp_chain 0, 100, 1 do
		t -37.5, 37.5; b 1/2
		t -12.5, 25; b 1/2
		t 12.5, 12.5; b 1/2
		t 37.5, 0; b 1/2
		t 62.5, -12.5; b 1/2

		t 87.5, -25; b 3
	end
	clockwork 0, 0, PI/4; b 1

	b 4

	b 3
	clockwork -37.5, 0, 3*PI/4; b 1

	b 3/2
	tp_chain 0, -100, 1 do
		t -100, -25; b 1/2
		t -75, -12.5; b 1/2
		t -50, 0; b 1/2
		t -25, 12.5; b 1/2
		t 0, 25; b 1/2

		t 25, 12.5; b 3/2
		t 62.5, 0; b 1/2
		t 87.5, -12.5; b 2
	end
end
tp_chain 0, 100, 1 do
	t -100, 50; b 1/2
	t -75, 0; b 1/2
	t -50, 25; b 1/2
	t -25, 0; b 1/2
	t 0, 25; b 1/2
	t 25, 50; b 1/2
	t 50, 25; b 1/2
	t 75, 0; b 1/2

	t 100, -25; b 1/2
	t 75, -50; b 1/2
	t 37.5, -12.5; b 1/6
	t 50, -25; b 1/6
	t 37.5, -37.5; b 1/6
	t 50, -50; b 1/2
	h 12.5, -25, 1/2; b 1
	t -25, 0; b 1/2
	t -50, -25; b 1/2

	h -75, 0, 4; b 8

	t 100, 0; b 1/2
	t 75, 25; b 1/2
	t 50, 25; b 1/2
	t 25, 50; b 1/2
	t 0, 25; b 1/2
	t -25, 50; b 1/2
	t -50, 25; b 1/2
	t -75, 0; b 1/2

	t -100, -25; b 1/2
	t -75, -50; b 1/2
	t -37.5, -12.5; b 1/6
	t -50, -25; b 1/6
	t -37.5, -37.5; b 1/6
	t -50, -50; b 1/2
	h -12.5, -25, 1/2; b 1
	t 25, 0; b 1/2
	t 50, -25; b 1/2

	h 75, 0, 4; b 8
end

tp_drop -100, 0, 1, preserve_beat: false do
	b -1
	t -87.5, 25; b 1/2
	t -87.5, 0; b 1/2

	notes = group do
		t -87.5, -25; b 2
		f -87.5, 25, :up; b 2

		t -87.5, -25; b 3/2
		t -87.5, -25; b 1/2
		f -87.5, 25, :up; b 2

		t -87.5, -25; b 2
		f -87.5, 25, :up; b 2
	end

	t -87.5, -25; b 3/2
	t -87.5, -25; b 1/2
	f -87.5, 25, :up; b 2

	transform duplicate notes do
		horizontal_flip
		beat_translate 16
	end
end

# interlude 2 (same melody as interlude 1)
group preserve_beat: false do
	3.times { grid 4; b 8 }
	grid 7
end
notes = group do
	tp_drop 0, 100, 1 do
		t -25, 12.5; b 1
		h -0, 50, 1/2; b 1
		t 25, 12.5; b 1/2
		t 37.5, 50; b 1/2
		t 50, 12.5; b 1/2
		t 62.5, 50; b 1/2
	end

	tp_drop 0, -100, 1 do
		t 75, -25; b 1/2
		t 62.5, -37.5; b 1/2
		t 50, -25; b 1/2
		t 37.5, -37.5; b 1/2
		h 25, -25, 1/2; b 1
		t 0, -37.5; b 1/2
		t -12.5, -25; b 1/2
	end

	tp_drop 0, 100, 1 do
		t 75, 12.5; b 1/2
		t 62.5, 50; b 1/2
		t 50, 12.5; b 1/2
		t 37.5, 50; b 1/2
		t 25, 12.5; b 1/2
		t 12.5, 50; b 1/2
		t 0, 12.5; b 1/2
		t -12.5, 50; b 1/2
	end
end

tp_drop 0, -100, 1 do
	t -50, -37.5; b 1/2
	t -37.5, -25; b 1/2
	t -25, -37.5; b 1/2
	t -12.5, -25; b 1/2
	h 0, -37.5, 1/2; b 1
	t 25, -25; b 1/2
	t 37.5, -37.5; b 1/2
end

transform duplicate notes do
	translate -37.5, 0
	beat_translate 16
end
b 12

tp_drop 0, -100, 1, preserve_beat: false do
	t -50, -37.5; b 1/2
	t -37.5, -25; b 1/2
	t -25, -37.5; b 1/2
	t -12.5, -25; b 1/2
	h 0, -37.5, 1/2; b 1
end
tp_drop 0, 100, 1 do
	t -12.5, 50; b 1/2
	t 0, 12.5; b 1/2
	t 12.5, 50; b 1/2
	t 25, 12.5; b 1/2
	h 37.5, 50, 1/2; b 1
end
tp_drop -100, 0, 1 do
	f -87.5, 25, :up
end
tp_drop 100, 0, 1 do
	f 87.5, 25, :up
end
b 1

# interlude 3
tp_chain 100, 0, 1, preserve_beat: false do
	128.times do |i|
		angle = PI/2 + PI/16*i
		radius = 1 - (angle - PI/2) / (PI*8)
		x = radius * 100 * cos(angle)
		y = radius * 50 * sin(angle)
		if i == 0
			f x, y, :left; b 1/4
		else
			d x, y; b 1/4
		end
	end
	d 0, 0
end

tp_chain 0, 100, 1 do
	h 75, 25, 1; b 3/2
	h 50, 0, 1; b 3/2
	h 25, -25, 1/2; b 1
end

tp_chain 0, 100, 1 do
	h -75, 25, 3/2; b 2
	h -50, 0, 1/2; b 1
	h -25, -25, 1/2; b 1
end

tp_chain 0, 100, 1 do
	h 100, 25, 1; b 3/2
	h 75, 0, 1/2; b 1
	t 50, -25; b 1/2
	t 25, 0; b 1/2
	t 0, 25; b 1/2
end

tp_chain 0, 100, 1 do
	h -75, 25, 1; b 3/2
	h -50, 0, 1; b 3/2
	h -25, -25, 1/2; b 1
end

tp_chain 0, 100, 1 do
	h 100, 25, 1; b 3/2
	h 75, 0, 1/2; b 1
	t 50, -25; b 1/2
	t 25, 0; b 1/2
	t 0, 25; b 1/2
end

tp_chain 0, 100, 1 do
	h -100, 0, 1; b 3/2
	h -75, 25, 1/2; b 1
	t -50, 0; b 1/2
	h -25, 25, 1/2; b 1
end

tp_chain 0, 100, 1 do
	h 100, 25, 1; b 3/2
	h 75, 0, 1/2; b 1
	t 50, -25; b 1/2
	t 25, 0; b 1/2
	t 0, 25; b 1/2
end

tp_chain 0, 100, 1 do
	h -75, 0, 1; b 3/2
	h -50, 25, 1; b 3/2
	h -25, -25, 1/2; b 1
end

# interlude 4
tp_drop 0, 100, 1, preserve_beat: false do
	f 0, 0, :up; b 1
	30.times { t 0, 0; b 1 }
	f 0, 0, :down; b 1
end

tp_chain 100, 0, 1 do
	t 100, -50; b 1
	t 75, -50; b 1
	t 50, -50; b 1/2
	t 37.5, -50; b 1/2
	t 25, -37.5; b 1
end

tp_chain 100, 0, 1 do
	t 100, 50; b 1/2
	t 75, 37.5; b 1/2
	t 50, 50; b 1/2
	t 25, 37.5; b 1/2
	t 0, 37.5; b 1/8
	d -6.25, 43.75; b 1/8
	d -12.5, 37.5; b 1/4
	t -37.5, 25; b 1/2
	t -62.5, 12.5; b 1/2
	t -87.5, 25; b 1/2
end

tp_chain -100, 0, 1 do
	t -100, -50; b 1
	t -75, -50; b 1
	t -50, -37.5; b 1/2
	t -25, -37.5; b 1/2
	t -0, -37.5; b 1
end

tp_chain -100, 0, 1 do
	t -100, 25; b 1/2
	t -75, 37.5; b 1/2
	t -50, 37.5; b 1/2
	t -25, 50; b 1/2
	t 0, 37.5; b 1/2
	t 25, 50; b 1/2
	t 50, 37.5; b 1/8
	d 56.25, 43.75; b 1/8
	d 62.5, 37.5; b 1/4
	t 87.5, 25; b 1/2
end

tp_chain 100, 0, 1 do
	t 100, -50; b 1
	t 75, -50; b 1
	t 50, -50; b 1/2
	t 37.5, -50; b 1/2
	t 25, -37.5; b 1
end

tp_chain 100, 0, 1 do
	t 100, 50; b 1/2
	t 75, 37.5; b 1/2
	t 50, 50; b 1/2
	t 25, 37.5; b 1/2
	t 0, 25; b 1/8
	d -6.25, 31.25; b 1/8
	d -12.5, 25; b 1/4
	t -37.5, 12.5; b 1/2
	t -62.5, 50; b 1/2
	t -87.5, 37.5; b 1/2
end

tp_chain -100, 0, 1 do
	t -100, -50; b 1
	t -75, -50; b 1
	t -50, -25; b 1/2
	t -25, -25; b 1/2
	t -0, -37.5; b 1
end

tp_chain -100, 0, 1 do
	h -100, 50, 1/2; b 1
	h -62.5, 37.5, 1/2; b 1
	h -25, 25, 1; b 2
end

# interlude 5 (similar to intro 3)
tp_drop 100, 100, 1, preserve_beat: false do
	notes = group do
		8.times do |i|
			t -50, -50; b 1/2
			if i % 4 == 3
				f -100, 0, :left; b 1/2
			else
				b 1/2 # t -75, -25; b 1/2
			end
			f -100, 0, :left; b 1/2
			b 1/2 # t -75, -25; b 1/2
		end
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 16
	end
end
tp_chain 0, 100, 1 do
	h 25, 25, 1; b 3/2
	h 50, 50, 2; b 1/2+2

	h 75, 25, 3; b 3+1/2
	h 100, 0, 4; b 1/4
	d 87.5, 12.5; b 1/4

	d 75, 0; b 4

	h 25, 37.5, 3+1/2; b 4
end

tp_chain 0, 100, 1 do
	h -25, 25, 2; b 5/2
	t -50, -37.5; b 1/2
	t -62.5, -25; b 1/2
	t -75, -12.5; b 1/2

	h -87.5, 0, 1; b 3/2
	h -75, -25, 2; b 5/2

	h -50, -50, 5/2; b 3
	h 0, -50, 4; b 1/4
	d -12.5, -37.5; b 1/4
	d -25, -25; b 1/4
	d -37.5, -12.5; b 1/4

	d -50, 0; b 4
end

# theme 3 (similar to theme 1)
grid 15
notes = group preserve_beat: false do
	4.times do |i|
		tp_drop 0, 100*(-1)**i, 1 do
			t -25, -50*(-1)**i; b 1/2
		end
		tp_drop 100, 0, 1 do
			f -75, 0, :left if i == 3; b 1/2
			f -75, 0, :left; b 1
		end
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 8
end

tp_chain 0, 100, 1 do
	t 50, 25; b 3/2
	t 100, 0; b 1/2
	t 75, 0; b 1/2
	t 50, 0; b 1/2
	t 25, 25; b 1

	t 0, -25; b 1/2
	t 25, -25; b 1
	t 50, 25; b 1/2
	t 75, 25; b 1
	t 75, -25; b 1
end

tp_chain 0, 100, 1 do
	t -25, 0; b 1/2
	t -50, 0; b 1/2
	t -75, 0; b 1/2
	t -100, -25; b 3/2
	t -50, 0; b 1/2
	t -25, 25; b 1/2

	t 0, 50; b 3/2
	t -50, 25; b 3/2
	t -100, 0; b 1
end

def kicks right = false
	tp_chain 0, 100, 1, preserve_beat: false do # 8th kick
		t -75, 50; b 1/2
		t -50, 25; b 1/2
		f -50, -25, :left; b 1/2
		t -75, -50; b 1/2
		t -100, -37.5; b 1/2
		t -75, -12.5; b 1/2
		f -50, 12.5, :left; b 1/2
		if right
			b 1/4; t -37.5, 37.5; b 1/4
		else
			t -25, 37.5; b 1/2
		end
		
		t -50, 50; b 1/2
		t -75, 25; b 1/2
		f -75, -25, :left; b 1/2
		t -50, -50; b 1/2
		t -25, -37.5; b 1/2
		f -50, -12.5, :left; b 1/2
		f -75, 12.5, :left; b 1
	end
end
transform(kicks) { vertical_flip }
transform(kicks true) { horizontal_flip }
b 8

tp_chain 0, -100, beat_speed: 100/3.0, preserve_beat: false do
	b 1/4
	6.times do |i|
		y = -50+(i+0.5)*100/6
		t 25, y; b 1/2
	end
end
tp_chain 0, -100, beat_speed: 100/3.0, preserve_beat: false do
	b 1/8+2
	(4...6).each do |i|
		y = -50+(i+0.25)*100/6
		d -50, y; b 1/2
	end
end
tp_chain 0, -100, beat_speed: 100/3.0, preserve_beat: false do
	b 3/8+2
	(4...6).each do |i|
		y = -50+(i+0.75)*100/6
		d 50, y; b 1/2
	end
end
tp_chain 0, -100, beat_speed: 100/3.0 do
	6.times do |i|
		y = -50+i*100/6.0
		if i == 2
			f -25, y, :left; b 1/2
		else
			t -25, y; b 1/2
		end
	end
end
tp_chain 0, 100, 1 do
	f 0, 0, :up; b 1
end

diamond_grid 3
notes = tp_chain -100, -100, beat_speed: 100*sqrt(2)/1.5 do
	(-50).step(50, 100/3) { |y| t -y, y; b 1/2 }
	b 1/2
	t 75, -25; b 1/2
	f 100, 0, :right; b 1
end
transform(duplicate notes) { horizontal_flip }

# theme 4 (similar to theme 2)
tp_chain 0, 100, 1, preserve_beat: false do # 鼓点
	4.times do
		t -100, 50; b 2
		f 100, 50, :right; b 2

		t 100, -50; b 2
		f -100, -50, :left; b 2

		t -100, 50; b 2
		f 100, -50, :right; b 2

		t 100, 50; b 2
		f -100, -50, :left; b 3/2
		t -75, 25; b 1/4
		t -87.5, 37.5; b 1/4
	end
end
notes = group do
group preserve_beat: false do # 杂项采音
	b 1
	tp_chain 0, 100, 1 do
		t 50, -50 # guitar
	end
	b 3

	b 1
	tp_chain -100, 0, 1 do # 80th
		f -50, -37.5, :up_left
		(1..7).each do |i|
			b 1/20
			d -50-6.25*i, -37.5+6.25*i
		end
		b 3/20
	end
	b 1
	tp_chain 0, 100, 1 do
		t -25, -50 # vocal
	end
	b 3/2

	b 5/2
	tp_chain 0, 100, 1 do
		t 75, -50 # bass
	end
	b 3/2
	
	b 1
	tp_chain -100, 0, 1 do # 64th
		f 0, -25, :up_left
		(1..6).each do |i|
			b 1/16
			d -6.25*i, -25+6.25*i
		end
		b 1/8
	end
	b 1
	tp_chain 0, 100, 1 do
		t -50, -50 # drip
	end
	b 3/2
end
tp_chain 0, 100, 1 do
	h 50, 25, 1/2; b 1
	b 1/2 # guitar
	t 100, 12.5; b 1/2
	t 75, 12.5; b 1/2
	t 50, 0; b 1/2
	h 25, 25, 1/2; b 1

	t 0, -25; b 1/2
	t -25, -25; b 1/2
	b 1/2 # 80th
	t -75, 12.5; b 1/2
	t -50, 12.5; b 1/2
	b 1/2 # vocal
	h -25, 25, 1/2; b 1

	f 12.5, 25, :down_left; b 1/2
	f 37.5, 25, :down_left; b 1/2
	f 62.5, 25, :down_left; b 1/2
	f 87.5, 12.5, :down_left; b 1
	b 1/2 # bass
	t 50, -12.5; b 1/2
	t 25, 0; b 1/2

	h 0, 12.5, 1/2; b 1
	b 1/2 # 64th
	t -50, 0; b 1/2
	t -75, 0; b 1/2
	b 1/2 # drip
	h -100, -12.5, 1/2; b 1
end

group preserve_beat: false do
	b 1
	tp_chain 0, -100, 1 do
		t 50, 50 # guitar
	end
	b 3

	b 1
	tp_chain 100, 0, 1 do # 80th
		f -100, 0, :down_right
		(1..8).each do |i|
			b 1/20; d -100+6.25*i, -6.25*i
		end
		b 1/10
	end
	b 1
	tp_chain 0, -100, 1 do
		h -25, 50, 1/8 # bass
	end
	b 3/2

	b 5/2
	tp_chain 0, -100, 1 do
		h 75, 50, 1/8 # bass
	end
	b 3/2

	b 1
	tp_chain 0, 100, 1 do
		t -25, -50 # high
	end
end
tp_chain 0, 100, 1 do
	h 0, -12.5, 1/2; b 1
	b 1/2 # guitar
	t 50, 12.5; b 1/2
	t 25, 12.5; b 1/2
	t 0, 0; b 1/2
	h -25, 25, 1/2; b 1

	t -62.5, 25; b 1/2
	t -87.5, 25; b 1/2
	b 1/2 # 80th
	t -50, -25; b 1/2
	t -25, -25; b 1/2
	b 1/2 # bass
	h 0, -12.5, 1/2; b 1

	t 25, 0; b 1/2
	t 50, 0; b 1/2
	t 75, 0; b 1/2
	h 100, -12.5, 1/2; b 1
	b 1/2 # bass
	t 50, -12.5; b 1/2
	t 25, 0; b 1/2

	h 0, 12.5, 1/2; b 1
	b 1/2 # high
	h -25, 50, 1; b 3/2
	h -25, 0, 1/2; b 1
end
end
transform(duplicate notes) { beat_translate 32 }
transform(notes) { horizontal_flip }
b 32

# refrain 2 (similar to refrain 1)
def arc x1, y1, x2, y2, head: :drag, length: 1/2
	middle_x = (x1+x2)/2
	middle_y = (y1+y2)/2
	half_base = hypot(x2-x1, y2-y1) / 2
	radius = 100
	chord_distance = sqrt radius**2 - half_base**2
	perp_x = y1-y2
	perp_y = x2-x1
	if perp_y < 0
		perp_x = -perp_x
		perp_y = -perp_y
	end
	perp_length = hypot perp_x, perp_y
	perp_x /= perp_length
	perp_y /= perp_length
	center_x = middle_x + perp_x * chord_distance
	center_y = middle_y + perp_y * chord_distance
	angle1 = atan2 y1-center_y, x1-center_x
	angle2 = atan2 y2-center_y, x2-center_x
	n = (length * 8).to_i
	positions = n.times.map do |i|
		angle = angle1 + (angle2-angle1) * i / (n-1)
		[center_x + radius * cos(angle), center_y + radius * sin(angle)]
	end
	tp_chain center_x, center_y, 1, relative: false do
		case head
		when :drag
			d x1, y1
		when :hold
			h x1, y1, length
		when :tap
			t x1, y1
		when :flick
			(xx1, yy1), (xx2, yy2) = positions
			f x1, y1, (atan2(yy2-yy1, xx2-xx1)/(PI/4)).round*PI/4
		end
		b 1/8
		n = (length * 8).to_i
		(1...(length * 8).to_i).each { |i| d *positions[i]; b 1/8 }
	end
end
def arcs_pattern ending = false; group preserve_beat: false do
	arc -100, 50, -37.5, 25, head: :tap
	arc -87.5, 25, -50, 0
	arc -87.5, 0, -50, -25
	arc -87.5, -25, -50, -50
	arc -87.5, -50, -50, -25, head: :flick
	arc -87.5, -25, -50, 0
	arc -100, 0, -50, 25
	arc -100, 25, -37.5, 50

	arc -100, 50, -50, 25, head: :tap
	arc -87.5, 25, -50, 0
	arc -87.5, 0, -50, -25
	arc -87.5, -25, -50, -50
	if ending
		arc -87.5, -50, 0, -12.5, head: :flick, length: 3/2
	else
		arc -87.5, -50, 0, -12.5, head: :flick, length: 1
		arc -12.5, -12.5, -50, 0
		arc -25, 0, -75, 25
	end
end; end
def pattern ending = false; group do
arcs_pattern
transform arcs_pattern ending do
	horizontal_flip
	translate -100, 0
	beat_translate 8
end

tp_chain 0, 100, 1 do
	t 75, 37.5; b 1/2
	t 62.5, 12.5; b 1/2
	h 50, -12.5, 1/2; b 1
	t 75, -50; b 1/2
	t 62.5, -25; b 1/2
	t 50, 0; b 1/2
	t 37.5, 25; b 1/2
	
	t 75, 37.5; b 1/2
	t 62.5, 12.5; b 1/2
	t 50, -12.5; b 1/2
	t 37.5, -37.5; b 1/2
	h 62.5, -50, 1/2; b 1
	t 75, -12.5; b 1/2
	t 87.5, 12.5; b 1/2
	
	t 75, 50; b 1/2
	t 87.5, 25; b 1/2
	t 75, 0; b 1/2
	t 87.5, -25; b 1/2
	t 75, -50; b 1/2
	t 62.5, -25; b 1/2
	t 75, 0; b 1/2
	t 87.5, 25; b 1/2
	
	t 75, 37.5; b 1/2
	t 87.5, 12.5; b 1/2
	t 100, -12.5; b 1/2
	t 87.5, -37.5; b 1/2
	if ending
		h 62.5, -50, 3/2; b 2
	else
		h 62.5, -50, 1/2; b 1
		t 75, -12.5; b 1/2
		t 62.5, 12.5; b 1/2
	end
end
end; end
grid 31
pattern
transform(pattern true) { horizontal_flip }

# outro 1 (similar to intro 1)
transform(intro1) { horizontal_flip }

# outro 2 (similar to intro 2)
transform(intro2 true) { horizontal_flip }

# outro 3 (similar to interlude 1)
def clockwork x, y, end_x, end_y
	vector_x = end_x - x
	vector_y = end_y - y
	tp_chain -100, 0, 1 do
		t x, y
		(1..7).each do |i|
			b 1/12; d x+vector_x/8*i, y+vector_y/8*i
		end
		b 5/12
	end
end
def drop_pattern ending = false
	tp_drop -100, 0, 1 do
		2.times do |i|
			b 1; 3.times { t -75, 50; b 2 }
			clockwork -75, 50, -100, 0 if !ending || i == 0
		end
	end
end
def outro3_company ending = false; group preserve_beat: false do
	tp_chain -75, 37.5, relative_beat: 2, relative: false, preserve_beat: false do
		4.times do
			t -100, 0; b 2
			t -75, -25; b 2
			t -50, 0; b 2
			t -75, 25; b 2
		end
	end
	drop_pattern
	transform(drop_pattern ending) { vertical_flip }
end; end
outro3_company

tp_chain 0, 100, 1 do
	t 100, 50; b 1/2
	t 75, 25; b 1/2
	t 50, 37.5; b 1/2
	t 25, 25; b 1/2
	t 25, 0; b 1/2
	t 50, 12.5; b 1/2
	t 75, 0; b 1/2
	t 100, 12.5; b 1/2

	t 100, 37.5; b 1/2
	t 75, 50; b 1/2
	t 50, 37.5; b 1/6
	d 37.5, 50; b 1/6
	d 25, 37.5; b 1/6
	d 12.5, 25; b 1/2
	t 0, 0; b 1
	t 50, 12.5; b 1/2
	t 75, 0; b 1/2

	t 100, 12.5; b 3/2
end
tp_chain 0, -100, 1 do
	t 37.5, -25; b 1/2
	t 62.5, -12.5; b 1/2
	t 87.5, 0; b 1/2
	t 100, -25; b 1/2
	t 75, -37.5; b 1/2

	t 50, -50; b 4
end

tp_chain 0, 100, 1 do
	t 12.5, 25; b 1/2
	t 37.5, 37.5; b 1/2
	t 62.5, 37.5; b 1/2
	t 87.5, 50; b 1/2
	t 100, 25; b 1/2
	t 75, 12.5; b 1/2
	t 50, 25; b 1/2
	t 25, 12.5; b 1/2

	t 12.5, 37.5; b 1/2
	t 37.5, 50; b 1/2
	t 62.5, 37.5; b 1/6
	d 75, 50; b 1/6
	d 87.5, 37.5; b 1/6
	d 100, 25; b 1/2
	t 87.5, 0; b 1
	t 50, 12.5; b 1/2
	t 25, 0; b 1/2

	t 0, 12.5; b 3/2
end
tp_chain 0, -100, 1 do
	t 100, -25; b 1/2
	t 75, -12.5; b 1/2
	t 50, 0; b 1/2
	t 25, 12.5; b 1/2
	t 37.5, -12.5; b 1/2

	t 62.5, -25; b 3/2
	t 100, -37.5; b 1/2
	t 75, -50; b 2
end

transform outro3_company true do
	horizontal_flip
end
tp_chain 0, 100, 1 do
	t -100, 50; b 1/2
	t -75, 25; b 1/2
	t -50, 37.5; b 1/2
	t -25, 25; b 1/2
	t -25, 0; b 1/2
	t -50, 12.5; b 1/2
	t -75, 0; b 1/2
	t -100, 12.5; b 1/2

	t -100, 37.5; b 1/2
	t -75, 50; b 1/2
	t -50, 37.5; b 1/6
	d -37.5, 50; b 1/6
	d -25, 37.5; b 1/6
	d -12.5, 25; b 1/2
	t -0, 0; b 1
	t -50, 12.5; b 1/2
	t -75, 0; b 1/2

	t -100, 12.5
end
tp_chain 0, -100, 1 do
	d -100, 12.5; b 1/2
	t -75, 0; b 1/2
	t -50, 0; b 1/2
	t -25, -12.5; b 1/2
	t -12.5, -25; b 1/2
	t -37.5, -37.5; b 1/2
	t -62.5, -25; b 1/2
	t -87.5, -12.5; b 1/2

	t -100, -37.5; b 1/2
	t -75, -50; b 1/2
	t -50, -37.5; b 1/2
	t -25, -25; b 1/2
	t -12.5, -50; b 1
	t -50, -37.5; b 1/2
	t -75, -50; b 1/2
end

tp_chain 0, 100, 1 do
	t -12.5, 25; b 1/2
	t -37.5, 37.5; b 1/2
	t -62.5, 37.5; b 1/2
	t -87.5, 50; b 1/2
	t -100, 25; b 1/2
	t -75, 12.5; b 1/2
	t -50, 25; b 1/2
	t -25, 12.5; b 1/2

	t -12.5, 37.5; b 1/2
	t -37.5, 50; b 1/2
	t -62.5, 37.5; b 1/6
	d -75, 50; b 1/6
	d -87.5, 37.5; b 1/6
	d -100, 25; b 1/2
	t -87.5, 0; b 1
	t -50, 12.5; b 1/2
	t -25, 0; b 1/2

	t 0, 12.5; b 3/2
end
tp_chain 0, -100, 1 do
	t -37.5, -25; b 1/2
	t -62.5, -12.5; b 1/2
	t -87.5, 0; b 1/2
	t -100, -25; b 1/2
	t -75, -37.5; b 1/2

	t -50, -50; b 3/2
	t -75, -25; b 1/4
	d -62.5, -12.5; b 1/4
	d -50, 0; b 2
end

end
