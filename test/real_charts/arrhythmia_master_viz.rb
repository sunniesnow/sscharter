Integer.alias_method :/, :quo
include Math

name = 'master_viz'
Sunniesnow::Charter.open name do

title 'Arrhythmia'
artist 'XinG'
charter 'RNOVA'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'

offset -0.256
bpm 150

b 6

bpm 154
tp_chain 72, 72, 1 do
	h 50, 25, 3; b 2
end
tp_chain -72, -72, 1 do
	t -25, -25; b 1

	t -50, 0; b 2
	t -25, 0; b 1

	bpm 158
	h -50, 25, 3; b 2
end
tp_chain 72, -72, 1 do
	t 25, -25; b 1

	t 50, 0; b 3
end

tp_chain 0, 100, 1 do
	h 50, -25, 3; b 2
end
tp_chain -72, 72, 1 do
	t -25, -25; b 1

	t -50, -25; b 2
	t -50, 25; b 1

	t -25, 25; b 2
	t 25, 25; b 1

	t 50, 25; b 1
	tp_chain -72, -72, 1, preserve_beat: false do
		t -25, 0; b 1
		t 0, -25; b 1
	end
	t 25, 0; b 1
	t 0, 25; b 1

	f 0, 0, :l; b 2
	t -75, -12.5; b 1/2
	t -62.5, -25; b 1/2

	t -50, -12.5; b 2
	t 0, 25; b 1
	
	f 0, 0, :r; b 2
	t 75, -12.5; b 1/2
	t 62.5, -25; b 1/2

	t 50, -12.5; b 2
	t 0, 37.5; b 1
	
	bpm 154
	f 0, 12.5, :d; b 2
	t -12.5, -25; b 1/2
	t 0, -37.5; b 1/2

	t 12.5, -25; b 1
	t 0, 25; b 1
	tp_chain 100, 0, 1, preserve_beat: false do
		t -25, 0; b 1
		h -75, 0, 3
	end
	t 25, 0; b 1

	h 75, 0, 3; b 3
end

bpm 150
b 4

bpm 158
tp_chain 0, -100, 1 do
	h 0, 0, 3; b 4
end

bpm 160
turntable 16
tp_chain -100, 0, 1, preserve_beat: false do
	f -50, 0, :r; b 5/2
	t 0, -25; b 1/2
	t -36, -36; b 1/2
	t -36, 36; b 1/2
	mark :m
end
tp_chain -100, 0, 1 do
	f 0, -50, :u; b 1
	5.times do |i|
		angle = PI/2 - PI*i/4
		x, y = 50 * cos(angle), 50 * sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	b 3/4
	t 36, -36; b 1/2
	t 36, 36; b 1/2

	t 12.5, 0; b 3/4
	f 50, 0, :r; b 5/4
end
at :m do
	b 1/4
	t -12.5, 0; b 5/4
	f -50, 0, :l
end
notes = tp_chain -72, 72, 1 do
	4.times do |i|
		angle = PI/2 * 3/4 - PI/4 * i
		t 50*cos(angle), 50*sin(angle); b 1/2
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1/4
end

tp_chain 0, -100, 1 do
	t 0, 0; b 1
end
tp_chain 100, 0, 1 do
	t 12.5, -25; b 1/4
	t -12.5, -25; b 1/2
	f 50, 0, :r; b 3/4
end
tp_chain 72, 72, 1 do
	3.times do |i|
		angle = 3/4 * PI + PI/4 * i
		t 50*cos(angle), 50*sin(angle); b 1/2
	end
end

notes = tp_chain -72, -72, 1 do
	4.times do |i|
		angle = -PI/2 * 3/4 + PI/2 * i/4
		x, y = 50*cos(angle), 50*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1
end
b 1
f 0, 50, :d; b 1/4
notes = tp_chain 0, 100, 1 do
	3.times do |i|
		d 0, 25-25*i; b 1/4
	end
	5.times do |i|
		angle = -PI/2 + PI/8*i
		d 50*cos(angle), 50*sin(angle); b 1/4 if i != 4
	end
end
transform(duplicate notes) { horizontal_flip }

tp_chain 72, 72, 1 do
	b 1
	t 0, 0; b 1
	t -75, -25; b 1
	t 75, -25; b 1

	tp_chain 0, -100, 1, preserve_beat: false do
		4.times do
			t 0, 0; b 1
		end
		mark :m
	end
	f 50, 25, :ur; b 1
	f -50, 25, :ul; b 1
	f -50, -25, :dl; b 1
	f 50, -25, :dr; b 1

	at :m do
		4.times do |i|
			t -50 + 12.5*i, -50 + 25*i; b 1/2
		end
	end
	5.times do |i|
		t 50 - 12.5*i, -50 + 25*i; b 1/2
	end
end
notes = tp_chain -100, 0, 1 do
	t -50, 0; b 1/2
end
transform(duplicate notes) { horizontal_flip }
tp_chain 100, 0, 1 do
	t 50, 37.5; b 1/4
	t -50, -37.5; b 1/4
	t 50, -37.5; b 1/4
	t -50, 37.5; b 1/4

	h 0, 0, 2; b 3
end
tp_chain 72, 72, 1 do
	t 0, 37.5
	tp_chain 72, 72, 1 do
		5.times do |i|
			x, y = 62.5 - 12.5*i, 37.5 - 12.5*i
			i.zero? ? t(x, y) : d(x, y); b 1/4 if i != 4
		end
	end

	f -62.5, -25, :r; b 3/4
	f -37.5, 0, :l; b 3/4
	f -12.5, 25, :r; b 1
end
tp_chain -100, 0, 1 do
	t 0, -50; b 1/2
	t 37.5, -50; b 1/2
	t 75, -50; b 1/2

	tp_chain 0, 100, 1 do
		t -50, 25; b 1/4
		t -37.5, 12.5; b 1/2
	end
	t 50, 25; b 3/4
	t 50, 0; b 1/2
end
tp_chain 72, 72, 1 do
	5.times do |i|
		t 12.5*(-1)**i, 25 - 12.5*i; b 1/4
	end
	b 1/4
end
tp_drop 0, -100, 1 do
	t -37.5, -12.5
	t 37.5, -12.5; b 1/2
end

def pattern; group preserve_beat: false do
	8.times do |i|
		x, y = 50 - (-50 + 12.5*i).abs, -50 + 12.5*i
		i.zero? ? f(x, y, :ur) : d(x, y); b 1/4
	end
	t 0, 50; b 1/2
	t 25, 50; b 1/2
	t 50, 50; b 1/2
	t 50, 25; b 1/2
	h 50, 0, 3; b 4
end; end
tp_chain 100, 0, 1 do
	h 50, 25, 3/2; b 3/2
end
tp_chain -100, 0, 1 do
	h -50, 25, 3/2; b 3/2
end
tp_chain 0, 100, 1 do
	t 0, 0; b 1

	pattern
end
tp_chain 72, 72, 1 do
	transform(pattern) { rotate PI }
end
b 8

tp_chain -72, 72, 1 do
	t 62.5, 37.5; b 3/4
	t 87.5, 0; b 3/4
	t 62.5, -37.5; b 1/2
end
tp_chain 72, -72, 1 do
	t -62.5, -37.5; b 1/2
	d -87.5, -12.5; b 1/4
	d -100, 0; b 3/4
	d -75, 25; b 1/2

	d -50, 50
end
tp_chain 0, 100, 1 do
	h 0, 0, 3; b 4
end

notes = tp_chain 100, 0, 1 do
	t 50, -12.5; b 3/4
	t 25, 12.5; b 3/4
	f 50, 37.5, :r; b 1
end
transform(duplicate notes) do
	translate 0, -12.5
	rotate PI
	translate 0, 12.5
end
notes = group do
	tp_chain 100, 0, 1 do
		3.times { |i| t 50 - 50*i, -50; b 1/2 }
	end

	def chain x0, y0, sx, sy
		tp_chain -72*sx, -72*sy, 1 do
			4.times do |i|
				x, y = x0 + sx*12.5*i, y0 + sy*12.5*i
				i.zero? ? t(x, y) : d(x, y); b 1/4
			end
		end
	end
	chain 87.5, 37.5, -1, -1
	chain 12.5, 37.1, -1, -1
	chain 50, -50, -1, 1
	chain -25, -50, -1, 1
end

tp_chain 72, 72, 1 do
	t 25, 50; b 3/4
	t 0, 25
	tp_chain -72, 72, 1 do
		t 50, 25; b 3/4
		t 75, 0
	end
	t -25, 0; b 1
	t -87.5, -25; b 1/2
	t -62.5, -50; b 1/2
	t -37.5, -25; b 1/2

	h -12.5, -50, 3/2; b 3/2
end
tp_chain 72, -72, 1 do
	f 25, 0, :r; b 2
end
tp_chain -100, 0, 1 do
	t 0, 37.5; b 1/4
	d 12.5, 37.5; b 1/4

	d 25, 37.5; b 1/2
	3.times do |i|
		t 50, 37.5 - i*25; b 1/2
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 16
end
b 6

tp_chain -100, 0, 1 do
	8.times do |i|
		x, y = -100 + 12.5*i, -50 + 12.5*(i%2)
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	tp_chain 0, 100, 1, preserve_beat: false do
		4.times do |i|
			t 25*i, 0; b 1/2
		end
		mark :m
	end
	b 1/2
	3.times do |i|
		t -25-25*i, 0; b 1/2
	end

	t -25, -25; b 3/2
	t -72, 25; b 1/2
	t -50, 50; b 1/2
	t -25, 25; b 1/2
	t -50, -25; b 1/2
	t -50, 25; b 1/2
end
at :m do
	t 72, 25; b 1/2
	t 50, 50; b 1/2
	t 25, 25; b 1/2
	t 25, -25; b 3/2
	t 50, 25; b 1/2
	t 50, -25; b 1/2
end

tp_chain 0, 100, 1 do
	h 0, 0, 2
end
tp_chain -72, -72, 1 do
	17.times do |i|
		d asin(sin(PI*i/8))/(PI/2)*50, -asin(cos(PI*i/8))/(PI/2)*50; b 1/4 if i != 16
	end
end

b 12

def repeat1 second = false
notes = group do
	tp_chain -100, 0, 1 do
		t -75, 0; b 1
		t -50, 0; b 1
		t -25, 0; b 1/2
		t -12.5, 0; b 1/2

		t 0, 0; b 1
	end
	notes = tp_chain 100, 0, 1 do
		t 25, -25; b 1
		t 25, 25; b 1
	end
	transform duplicate notes do
		rotate PI
	end
end

transform duplicate notes do
	horizontal_flip
	beat_translate 6
end
b 6

notes = group do
	tp_chain 0, -100, 1 do
		f 0, 0, :u; b 1/2
	end
	tp_chain 0, 100, 1, preserve_beat: false do
		4.times do |i|
			t 75, 37.5 - 25*i; b 1/2
		end
	end
	tp_chain 0, 100, 1 do
		3.times do |i|
			b 1/4; t 37.5, 25 - 25*i; b 1/4
		end
	end
	b 1/2
	[[-1, 1], [1, 1], [-1, -1]].each do |sx, sy|
		tp_chain -72*sx, -72*sy, 1 do
			t 75*sx, 37.5*sy; b 1/2
		end
	end
end

transform duplicate notes do
	horizontal_flip
	beat_translate 4
end
b 4

tp_chain 0, -100, 1 do
	f 0, 0, :u; b 1/2
end
tp_chain 0, 100, 1, preserve_beat: false do
	4.times do |i|
		t 25, 50 - 25*i; b 1/2
	end
	3.times do |i|
		t 37.5 + 25*i, -50 + 25*i; b 1/2
	end
end
tp_chain 0, 100, 1 do
	3.times do |i|
		b 1/4; t -25, 37.5 - 25*i; b 1/4
	end
	b 1/2
	3.times do |i|
		t -37.5 - 25*i, -50 + 25*i; b 1/2
	end
end

notes = group do
	tp_chain 0, -100, 1 do
		t 0, 0; b 1/2
	end
	tp_chain 0, 100, 1 do
		t 75, 37.5; b 1/4
		t 75, 25; b 1/4
		tp_chain 0, 100, 1 do
			t 37.5, 12.5; b 1/4
			t 37.5, 0; b 1/4
		end
		t 75, -12.5; b 1/4
		t 75, -25; b 1/4
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 2
end
b 2

tp_chain 0, -100, 1 do
	t 0, 0; b 1
end
tp_chain 72, -72, 1, preserve_beat: false do
	t 25, 37.5; b 1
	t 25, -37.5; b 1
	t 50, 0; b 1
	mark :m
end
tp_chain -72, 72, 1 do
	t -25, -37.5; b 1
	t -25, 37.5; b 1
	t -50, 0; b 1

	4.times { t 0, 0; b 1 }
	at :m, update_mark: true do
		[[1, 1], [-1, 1], [-1, -1], [1, -1]].each do |sx, sy|
			f 50*sx, 25*sy, atan2(sy, sx); b 1
		end
	end

	5.times do |i|
		angle = 5/4*PI - PI/8*i
		x, y = 50*cos(angle), 50*sin(angle)
		i.zero? ? f(x, y, :ul) : d(x, y); b 1/8
	end
	b 3/8
	t 0, 28; b 1/2
	t -28, 0; b 5/4
	t -25, -25; b 3/4
	t -50, -25; b 1/2
	at :m, update_mark: true do
		5.times do |i|
			angle = 1/4*PI - PI/8*i
			x, y = 50*cos(angle), 50*sin(angle)
			i.zero? ? f(x, y, :dr) : d(x, y); b 1/8
		end
		b 3/8
		t 0, -28; b 1/2
		t 28, 0; b 1/2
		t 0, 0; b 3/4
		t 25, -25; b 3/4
		t 50, -25; b 1/2
	end

	f -75, -25, :ur; b 1
	h -25, 25, 2 unless second; b 3
	at :m do
		f 75, -25, :ul; b 1
		second ? h(0, 0, 2) : h(25, 25, 2); b 3
	end
end

tp_chain 0, 100, 1 do
	h 0, 0, 6; b 8
end unless second
return unless second

tp_chain -100, 0, 1, preserve_beat: false do
	5.times do |i|
		angle = 1/4*PI - PI/8*i
		x, y = 50*cos(angle), 50*sin(angle)
		i.zero? ? f(x, y, :dr) : d(x, y); b 1/8
	end
	b 3/8
	t 0, -28; b 1/2
	t 28, 0; b 5/4
	t 25, 25; b 3/4
	t 50, 25; b 1/2
	f 75, 25, :dl
end
tp_chain 100, 0, 1 do
	5.times do |i|
		angle = 5/4*PI - PI/8*i
		x, y = 50*cos(angle), 50*sin(angle)
		i.zero? ? f(x, y, :ul) : d(x, y); b 1/8
	end
	b 3/8
	t 0, 28; b 1/2
	t -28, 0; b 1/2
	t 0, 0; b 3/4
	t -25, 25; b 3/4
	t -50, 25; b 1/2

	f -75, 25, :dr; b 1
	h 0, 0, 2; b 3
end
end
repeat1

def repeat2
diamond_grid 24
tp_chain 0, 100, 1, preserve_beat: false do
	97.times do |i|
		d -50 - asin(sin(PI*i/8))/(PI/2)*50, asin(cos(PI*i/8))/(PI/2)*50; b 1/4
	end
end

tp_chain 0, 100, 1 do
	t 75, 50; b 3/4
	t 87.5, 12.5; b 3/4
	t 75, -25; b 1
end
tp_chain 0, -100, 1 do
	t 25, 25; b 1/2
	t 25, 50; b 1/2
	t 50, 50; b 1/2

	t 75, 50; b 3/4
	t 87.5, 12.5; b 3/4
	t 75, -25; b 1/2
	t 50, -25; b 3/4
	t 37.5, 12.5; b 3/4
	t 50, 50; b 1/2

	4.times do |i|
		t 75, 50 - 25*i; b 1/2
	end
	4.times do |i|
		x, y = 62.5 - 12.5*i, -50 + 12.5*i
		i.zero? ? f(x, y, :ul) : d(x, y); b 1/4
	end
	d 25, 0; b 1/4
	4.times do |i|
		d 25 + 12.5*i, 12.5 + 12.5*i; b 1/4 if i != 3
	end
end

tp_chain -72, 72, 1 do
	b 3/2
	t 25, 37.5; b 3/2
	t 75, 0; b 1

	t 25, -37.5; b 3/2
end
tp_chain 0, -100, 1 do
	h 75, 37.5, 11/2; b 5/2
end

b 4

tp_chain 72, 72, 1 do
	3.times do |i|
		t 50 - 25*i, -25*i; b i == 2 ? 1/2 : 3/4
	end
end
tp_chain -72, -72, 1 do
	3.times do |i|
		t -50 + 25*i, 25*i; b i == 2 ? 1/2 : 3/4
	end

	t 0, 0; b 3/4
	f -50, 0, :l
	tp_chain -100, 0, 1 do
		f 50, 0, :r; b 3/4
		f 0, 50, :u
	end
	f 0, -50, :d; b 1
	3.times do |i|
		t -25, -25 + 25*i; b 1/2
	end
end

diamond_grid 16
tp_chain 0, 100, 1, preserve_beat: false do
	65.times do |i|
		d 50 + asin(sin(PI*i/8))/(PI/2)*50, asin(cos(PI*i/8))/(PI/2)*50; b 1/4
	end
end

tp_chain 0, 100, 1 do
	t -75, 50; b 1
	t -75, 0; b 1
end
tp_chain 0, -100, 1 do
	t -25, -50; b 1
	t -25, 0; b 1
end

tp_chain 72, 72, 1 do
	t -62.5, 37.5; b 3/2
	t -100, 0; b 3/2
	t -62.5, -37.5; b 1
end

tp_chain -72, -72, 1 do
	h -25, 25, 3; b 4
end

notes = tp_chain 0, 100, 1 do
	2.times do |i|
		3.times do |j|
			x, y = -75 - 12.5*j, 50 - 50*i - 12.5*j
			j.zero? ? t(x, y) : d(x, y); b 1/4
		end
		b 1/4
	end
end
transform duplicate notes do
	rotate PI
	beat_translate 2
	translate -125, 0
end
b 2

b 2
notes = tp_chain 0, -100, 1 do
	4.times do |i|
		t 75, -37.5 + 25*i; b 1/2
	end
	mark :m
end
transform duplicate notes do
	beat_translate -2
	rotate PI
end

def pattern; group do
	t 37.5, 37.5; b 1/2
	t 12.5, 12.5; b 1/2
	t 12.5, -12.5; b 1/2
	t 25, -37.5; b 1/2
	t 50, -25; b 1/2
	t 62.5, 0; b 1/2
	t 50, 25; b 1/2
	t 25, 37.5; b 1/2
end; end
at :m, update_mark: true do
	pattern
end
notes = tp_chain 72, 72, 1 do
	pattern
	mark :n
end
transform(notes) { rotate PI }

at :m do
	4.times do |i|
		x, y = 12.5 * i, 0
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	5.times do |i|
		d 50 - 12.5*i, 12.5*i; b 1/4
	end
	d 0, 37.5; b 1/4
	d 0, 25; b 1/4
	d -12.5, 12.5; b 1/4
	3.times do |i|
		d -25 - 25*i, 0; b 1/4
	end
end
at :n, preserve_beat: true do
	b 1/4
	3.times do |i|
		d -12.5 - 12.5*i, 0; b 1/4
	end
	4.times do |i|
		d -50 + 12.5*i, 12.5*i; b 1/4
	end
end
tp_chain 0, 100, 1 do
	3.times do |i|
		d 0, 50 - 12.5*i; b 1/4
	end
	d 12.5, 12.5; b 1/4
	3.times do |i|
		d 25 + 25*i, 0; b 1/4
	end
	b 1/4
end

tp_chain 0, -100, 1 do
	h 0, 0, 2; b 4
end
end
repeat2

checkerboard 32
notes = group do
	notes = tp_chain 0, 100, 1 do
		t 0, 50; b 1/2
		t 25, 50; b 1/2
		5.times { |i| t 50, 50 - i*25; b 1/2 }
		t 25, -50; b 1/2
		mark :m
	end
	transform(duplicate notes) do
		rotate PI
		beat_translate 1/4
	end

	at :m, preserve_beat: true do
		f 0, -50, :u; b 1/4
		3.times { |i| d 0, -25 + i*25; b 1/4 }
		3.times { |i| d -i*25, 50; b 1/4 }
		d -50, 25; b 1/4
		4.times { |i| d -50 + i*25, 0; b 1/4 }
		3.times { |i| d 50, -i*25; b 1/4 }
		d 25, -50; b 1/4
	end

	notes = tp_chain -72, 72, 1 do
		4.times do |i|
			x, y = -50 + i*12.5, 50 - i*12.5
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
	end
	transform duplicate notes do
		beat_translate 1
		rotate PI
	end
	transform duplicate notes do
		beat_translate 2
		vertical_flip
	end
	transform duplicate notes do
		beat_translate 3
		horizontal_flip
	end
	b 3

	notes = tp_chain -100, 0, 1 do
		4.times do |i|
			x, y = -12.5 - i*12.5, 12.5 + i*12.5
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
	end
	transform duplicate notes do
		beat_translate 1
		rotate PI
	end
	transform duplicate notes do
		beat_translate 2
		vertical_flip
	end
	transform duplicate notes do
		beat_translate 3
		horizontal_flip
	end
	b 3
end

transform duplicate notes do
	horizontal_flip
	beat_translate 16
end
b 16

group preserve_beat: false do
	[156, 152, 146, 138, 128, 120, 108, [100, 92], 90, 90, 92, 96, 106, [110, 114], 128, 150, 160].each do |bpm_val|
		if bpm_val.is_a? Array
			bpm bpm_val[0]; b 1
			bpm bpm_val[1]; b 1
		else
			bpm bpm_val; b 2
		end
	end
end

grid 32
[100, 62.5, 87.5, 50].each do |x0|
	4.times do |i|
		[[1, 1], [-1, -1], [1, -1], [-1, 1]].each do |sx, sy|
			tp_chain 72*sx, 72*sy, 1 do
				t (x0 - 12.5*i)*sx, (50 - 12.5*i)*sy; b 1/4
			end
		end
	end
end

tp_drop 0, 100, 1 do
	16.times { t 0, 0; b 1/4 }
end

[12.5, 37.5, 62.5].each do |x0|
	4.times do |i|
		[[1, -1], [-1, 1], [1, 1], [-1, -1]].each do |sx, sy|
			tp_chain 72*sx, 72*sy, 1 do
				t (x0 + 12.5*i)*sx, (12.5 + 12.5*i)*sy; b 1/4
			end
		end
	end
end

tp_chain 72, 72, 1 do
	t 0, 0; b 12
end

repeat1 true

repeat2

notes = group do
	tp_chain -100, 0, 1 do
		f -25, 37.5, :r
	end
	tp_chain -100, 0, 1 do
		4.times do |i|
			x, y = -87.5 + 12.5*i, -37.5 + 12.5*i
			i.zero? ? t(x, y) : d(x, y); b 1/8
		end
		b 5/2
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/2
end
tp_chain 0, -100, 1, preserve_beat: false do
	4.times do |i|
		x, y = -25, -37.5 + 25*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
	b 1/2
	mark :l
end
tp_chain 0, -100, 1 do
	4.times do |i|
		x, y = 25, -37.5 + 25*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
	b 1/2
	mark :r
end

at :l do
	b 1/2
	t -50, 25; b 1/4
	t -62.5, 12.5; b 3/4
	f -25, -25, :dl; b 5/4
	f -25, 25, :ul; b 5/4
end
at :r, preserve_beat: true do
	t 0, 0; b 1/2
	t 50, -25; b 1/4
	t 62.5, -12.5; b 3/4
	f 25, 25, :ur; b 3/4
	t 0, 0; b 1/2
	f 25, -25, :dr; b 5/4
end

next if name == 'master'
last_beat = b
b! 0
bpm_v = bg_note 125, 50, last_beat
beat_v = 4.times.map { |i| bg_note 125, 25 - 25*i, last_beat }

@bpm_changes.each do |bpm_change|
	b! bpm_change.beat
	td(bpm_v, goto_beat: false) { text bpm_change.bpm.to_i.to_s }
end

b! 0
([3]*17 + [4]*26 + [3]*8 + [4]*42 + [3]*8 + [4]*28).each do |time_sig|
	beat_v.each_with_index do |event, i|
		if i >= time_sig
			td(event, goto_beat: false) { text '' }
			next
		end
		td(event, goto_beat: false) { text ?○ } unless i.zero?
		b i
		td(event, goto_beat: false) { text ?● }
		b 1
		td(event, goto_beat: false) { text ?○ } unless i == time_sig - 1
		b -i - 1
	end
	b time_sig
end

end
