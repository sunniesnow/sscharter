include Math
Integer.alias_method :/, :quo

Sunniesnow::Charter.open 'special' do

title "Le Porteur d'Ombre"
artist '黒皇帝 feat. AKA'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '13'
difficulty_sup '+'

offset 2.254
bpm 220

notes = group do
bg_note 0, 0, 8
tp_drop 0, 0, 1, relative: false do
	h 4*sqrt(2), -4, 6
	h -4*sqrt(2), 4, 6; b 3
	h 4*sqrt(2), 4, 3
	h -4*sqrt(2), -4, 3; b 3
	hexagram 2; b 2
end

=begin
8.times do |i|
	prog = i/8
	x, y = 4*sqrt(2)*(1-prog), 4*(1-prog)
	bg_note x, y
	bg_note -x, y
	bg_note x, -y
	bg_note -x, -y
	b 1/2
end
=end
b 8
end

transform duplicate notes do
	horizontal_flip
	beat_translate 16
end

b 12
16.times do |i|
	prog = i/16
	angle, radius = 4*PI*prog, 4*prog
	bg_note radius*cos(angle)*(1+prog/2), radius*sin(angle)
	b 1/4
end

def kicks x0, dir, first_flick: false, all_flick: false, delta: 1, tp_dir: x0 <=> 0
	tp_drop tp_dir*8, 0, 1, preserve_beat: false do
		4.times do |i|
			x, y = x0 + 2*dir*i/3, 4-8*i/3
			i.zero? && first_flick || all_flick ? f(x, y, PI/2-tp_dir*PI/2) : t(x, y)
			b delta
		end
	end
end
kicks -4, -1, first_flick: true
tp_chain 0, -8, 1 do
	h 6, 0, 3; b 4
end

kicks 1, -1
b 4

kicks -6, 1
b 2
tp_chain 0, 8, 1 do
	h 1, 3, 1; b 2
end

kicks 6, 1
tp_chain 0, 8, 1 do
	h -4, 3, 1; b 2
end
tp_chain 0, -8, 1 do
	h -7, -1, 1; b 5/4
end
tp_drop 8, 8, 1 do
	1.upto 3 do |i|
		x, y = 8-i, -4+i
		d x, y; b 1/4
	end
end

tp_chain 0, -8, 1 do
	h 4, 0, 3
end
kicks 0, -1, first_flick: true, delta: 1/2, tp_dir: -1; b 2
kicks -4, -1, delta: 1/2; b 2

kicks 0, 1, first_flick: true, delta: 1/2, tp_dir: 1; b 2
kicks 4, 1, delta: 1/2; b 2

kicks -1, -1, first_flick: true, delta: 1/2; b 1/4
kicks 7, -1, delta: 1/2; b 7/4
notes = group do
	kicks -7, 1, first_flick: true, delta: 1/2; b 1/4
	kicks 1, 1, delta: 1/2; b 7/4
end
transform notes do
	vertical_flip
end

def chain x0, y0, x1, y1, n, delta
	tp_drop 8, 0, 1 do
		n.times do |i|
			prog = i/(n-1)
			x = x0 + (x1-x0)*prog
			y = y0 + (y1-y0)*prog
			i.zero? ? t(x, y) : d(x, y)
			b delta
		end
	end
end
kicks -8, 1, all_flick: true; b 1/2
chain -1.5, 4, 0.5, -4, 4, 1/8; b 1/2
chain 3, -4, 1, 4, 4, 1/8; b 1/2
chain 3.5, 4, 5.5, -4, 4, 1/8; b 1/2
chain 8, -4, 6, 4, 8, 1/16

6.times do |i|
	angle = PI/6 + 2*PI*i/6
	x, y = 4*cos(angle), 4*sin(angle)
	bg_note x, y; b 1/3
end
hexagram 1/2
5.times do |i|
	notes = tp_drop 8, 0, 1, preserve_beat: false do
		t 3, -4; b 1
		t 3, 0; b 1
	end
	transform(notes) { vertical_flip } if i > 2
	transform(duplicate notes) { horizontal_flip }
	b 1/2
	tp_drop 0, i > 2 ? -8 : 8, 1 do
		t 0, i > 2 ? 2 : -2; b 1
	end
	tp_drop 0, i >= 2 ? -8 : 8, 1 do
		t 0, i >= 2 ? 2 : -2; b 1/2
	end
end

notes = tp_drop 8, 0, 1 do
	t 3, 4; b 1/2
	t 5, 2; b 1/2
	t 3, 0; b 1
	t 3, -4; b 1/2
end
transform(duplicate notes) { horizontal_flip }
b -1; tp_chain(0, 8, 1) { t 0, -2 }; b 1
tp_chain -8, 0, 1 do
	t -1, 0; b 1/4
end
tp_chain 8, 0, 1 do
	t 1, 1; b 1/4
end
tp_chain 8, 8, 1 do
	f -4, 2, :ul; b 1/2
end
tp_chain -8, 8, 1 do
	f 4, -2, :dr; b 1/2
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2-2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i; b 1/2
	end
	next if i == 3
	tp_drop 0, 8, 1 do
		t 0, -2; b 1/2
	end
end
tp_drop -8, 0, 1 do
	t -1, 2; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, 3; b 1/4
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, 2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, 2+2*(-1)**i; b 1/2
	end
	next if i == 3
	tp_drop 0, 8, 1 do
		t 0, 2; b 1/2
	end
end
b 1/4
tp_drop -8, 0, 1 do
	t -2, -3; b 1/4
end

3.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2-2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i; b 1/2
	end
	next if i == 2
	tp_drop 0, 8, 1 do
		t 0, -2; b 1/2
	end
end
b 1/4
tp_drop 8, 0, 1 do
	t 2, -1; b 1/4
	t 3, 0
end
tp_drop -8, 0, 1 do
	t -3, 0; b 1/2
end
tp_drop 8, 0, 1 do
	t 1, 2; b 1/4
end
tp_drop -8, 0, 1 do
	t -2, 3; b 1/4

	t -3, 4
end
notes = group preserve_beat: false do
	1.upto 6 do |i|
		bg_note -i, 2*sin(i/6*PI); b 1/6
	end
end
transform duplicate notes do
	rotate PI
	beat_translate 3/2
end
tp_drop 8, 0, 1 do
	t 3, 4; b 1/2
end
d 4, 2; b 1/2
d 5, 0; b 1/2
t -2, -2; b 1/2
d -3, 0; b 1/4
d -4, -1; b 1/4
d -5, -2; b 1/4
d -6, -1; b 1/4
bg_note 0, 0
t 1, 2; b 1/4
d 2, 3; b 1/4
d 3, 2; b 1/4
d 4, 1; b 1/4

tp_drop 8, 0, 1 do
	t 3, 0
end
tp_drop -8, 0, 1 do
	t -3, 0; b 1
end
tp_drop 0, 16, 1 do
	3.times do |i|
		2.times do |j|
			t -5+10*j, -3.5+2.5*i
			bg_note -6+12*j, -3.5+2.5*i
		end
		b 1/3
	end
end
hexagram 1/2
tp_drop 8, 0, 1 do
	t 3, 4
end
tp_drop -8, 0, 1 do
	t -3, 4; b 1/2
end
tp_drop 0, -8, 1 do
	t 0, 2; b 1/2
end
tp_drop 8, 0, 1 do
	t 3, 0
end
tp_drop -8, 0, 1 do
	t -3, 0; b 1/2
	t -1, 2; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, 3; b 1/4
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, 2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, 2+2*(-1)**i; b 1/2
	end
	next if i == 3
	tp_drop 0, -8, 1 do
		t 0, 2; b 1/2
	end
end
tp_drop 8, 0, 1 do
	t -1, -2; b 1/6
	d 1/3, -2-2/3; b 1/6
	d 5/3, -2-4/3; b 1/6
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2-2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i; b 1/2
	end
	next if i == 3
	tp_drop 0, 8, 1 do
		t 0, -2; b 1/2
	end
end
b 1/4
t -2, -3; b 1/4

notes = tp_drop 8, 0, 1 do
	t 3, -4; b 1/2
	t 5, -2; b 1/2
	t 3, 0; b 1
	t 3, 4; b 1/2
end
transform(duplicate notes) { horizontal_flip }
b -1; tp_chain(0, -8, 1) { t 0, 2 }; b 1
tp_chain -8, 0, 1 do
	t -1, 0; b 1/4
end
tp_chain 8, 0, 1 do
	t 1, -1; b 1/4
end
tp_chain 8, 8, 1 do
	f -4, -2, :dl; b 1/2
end
tp_chain -8, 8, 1 do
	f 4, 2, :ur; b 1/2
end

group preserve_beat: false do
	b 1/2
	7.times do |i|
		tp_chain 0, -8*(-1)**i, 1 do
			t 0, 0; b 1
		end
	end
end
tp_drop 8, 8, 1 do
	t -1, 3; t 6, 1; b 1
end
tp_drop -8, -8, 1 do
	t -2, -1; t 3, -3; b 1
end
tp_drop -8, 8, 1 do
	t -6, 1; t 1, 3; b 1
end
tp_drop 8, -8, 1 do
	t -3, -3; t 2, -1; b 1
end

tp_drop -8, 8, 1 do
	t -2, 1; t 3, 3; b 1
end
tp_drop 8, -8, 1 do
	t -1, -3; t 6, -1; b 1
end
tp_drop 8, 8, 1 do
	t -3, 3; t 2, 1; b 1
end
tp_drop -8, -8, 1 do
	t -6, -1
end
tp_chain -8, -8, 1 do
	6.times do |i|
		prog = i/6
		x, y = 1+(8-3*cos(PI/2-2*PI/5)*2-1)*prog, -3+(3*sin(PI/2-2*PI/5)+3)*prog
		t x, y if i.even?
		d x, y if i == 5
		b 1/6
	end
end

group preserve_beat: false do
	5.times do |i|
		angle = PI/2 + 2*PI/5 - 2*PI*i/5
		x, y = 8-3*cos(PI/2-2*PI/5) + 3*cos(angle), 3*sin(angle)
		tp_chain 8*cos(angle+PI), 8*sin(angle+PI), 1 do
			t x, y; b 3/4
		end
	end
end
0.upto 8 do |i|
	angle = PI/8 + 2*PI*i/8
	x, y = -5+3/cos(PI/8)*cos(angle), 3/cos(PI/8)*sin(angle)
	tp_chain 8*cos(angle+PI), 8*sin(angle+PI), 1 do
		t x, y
		bg_note x, y if i == 8
		b 1/2 if i < 8
	end
end

tp_chain 0, 8, 1 do
	0.upto 6 do |i|
		prog = i/6
		x, y = 3 + 3*prog, 4 - 5*prog
		i==0 || i==6 ? t(x, y) : d(x, y)
		bg_note 3 - 3*prog, 4 - 5*prog
		b 1/4 if i < 6
	end
end
tp_chain 0, 8, 1 do
	0.upto 3 do |i|
		prog = i/3
		x, y = -4 - 2*prog, 2 - 5*prog
		i==0 ? t(x, y) : i==3 ? f(x, y, :l) : d(x, y)
		bg_note -4 + 2*prog, 2 - 5*prog
		b 1/2 if i < 3
	end
end
tp_chain 0, -8, 1 do
	f 6, 3, :r; bg_note 6, 3; b 1
end

group preserve_beat: false do
	8.times do |i|
		5.times do |j|
			bg_note -8, 4-2*j
			bg_note 8, 4-2*j
			b j == 4 ? 2 : 3/2
		end
	end
end
hexagram 1/2
8.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i; b 1/2
	end
	tp_drop 0, 8, 1 do
		t 0, 0; b 1/2
	end unless i == 7
end
tp_drop 8, 0, 1 do
	3.times do |i|
		x, y = 1 - 4*i/3, 2 + 2*i/3
		i.zero? ? t(x, y) : d(x, y)
		b 1/6
	end
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, 2-2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, 2+2*(-1)**i; b 1/2
	end
	tp_drop 0, -8, 1 do
		t 0, 0; b 1/2
	end
end

tp_drop -8, 0, 1, preserve_beat: false do
	4.times do |i|
		x, y = -3, 4 - i
		i.zero? ? t(x, y) : d(x, y)
		b 1/4
	end
end
tp_drop 8, 0, 1 do
	t 3, 0; b 1/2
end
tp_drop 0, -8, 1 do
	t 0, 0; b 1/2
end
tp_drop 8, 0, 1 do
	t 3, -4
end
tp_drop -8, 0, 1 do
	t -3, 0; b 1/2
end
tp_drop 0, 8, 1 do
	t 0, 0; b 1/2
end
tp_drop -8, 0, 1 do
	t -3, -4
end
tp_drop 8, 0, 1 do
	4.times do |i|
		x, y = 3-i, -i/2
		i.zero? ? t(x, y) : d(x, y)
		b 1/8
	end
end
tp_drop -8, 0, 1 do
	t -1, -2; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, -3; b 1/4
	t 3, -4
end
tp_drop -8, 0, 1 do
	t -3, 0; b 1/2
end
tp_drop 8, 0, 1 do
	f 5, 0, :ul; b 1/2
end

hexagram 1/2
8.times do |i|
	tp_drop 8, 0, 1 do
		t 3, 2-2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, 2+2*(-1)**i; b 1/2
	end
	tp_drop 0, -8, 1 do
		t 0, 0; b 1/2
	end unless i == 7
end
tp_drop 8, 0, 1 do
	3.times do |i|
		x, y = 1 - 4*i/3, -2 - 2*i/3
		i.zero? ? t(x, y) : d(x, y)
		b 1/6
	end
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i unless i == 3; b 1/2
	end
	tp_drop 0, 8, 1 do
		t 0, 0; b 1/2
	end unless i == 3
end
b -1/4
tp_drop -8, 0, 1 do
	t -1, -3; b 1/4
end
tp_drop 8, 0, 1 do
	t 1, -2; b 1/4
end
tp_drop -8, 0, 1 do
	t -3, -1; b 1/4
	t -2, 0
end
tp_drop 8, 0, 1 do
	t 5, -2; b 3/4
	t 2, 3
end
tp_drop -8, 0, 1 do
	t -5, 1; b 3/4
	t -3, 4
end
tp_drop 8, 0, 1 do
	t 3, 0; b 1/2
end

group preserve_beat: false do
	12.times do |i|
		prog = 1-i/12
		x, y = -14*prog + 8*prog**2, 2-14*prog + 16*prog**2
		bg_note x, y; b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -6, 4, :ur
end
tp_chain 8, 0, 1 do
	12.times do |i|
		prog = i/12
		x, y = 6-14*prog + 8*prog**2, -14*prog + 16*prog**2
		i.zero? ? f(x, y, :dl) : d(x, y); b 1/8
	end
	4.times do |i|
		prog = i/4
		x, y = prog*3, 2+2*prog
		d x, y; b 1/8
	end
end

hexagram 1/2
6.times do |i|
	tp_drop 8, 0, 1 do
		t 3, 2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, 2-2*(-1)**i; b 1/2
	end
	tp_drop 0, -8, 1 do
		t 0, 0; b 1/2
	end
end
tp_drop 8, 0, 1 do
	t 3, 4; b 1/4
end
tp_drop -8, 0, 1 do
	t -1, 3; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, 2; b 1/4
end
tp_drop -8, 0, 1 do
	t -2, 1; b 1/4
	t -3, 0
end
tp_drop 8, 0, 1 do
	t 3, 4; b 1/2
end
tp_drop 0, -8, 1 do
	t 0, 0;  b 1/2
end

4.times do |i|
	tp_drop 8, 0, 1 do
		t 3, -2+2*(-1)**i
	end
	tp_drop -8, 0, 1 do
		t -3, -2-2*(-1)**i; b 1/2
	end
	tp_drop 0, 8, 1 do
		t 0, 0; b 1/2
	end
end

notes = tp_drop 8, 0, 1 do
	t 3, 0; b 1/2
	t 5, -2; b 1/2
	t 3, -4; b 1/2
end
transform(duplicate notes) do
	translate 0, 2
	rotate PI
	translate 0, -2
end
tp_drop 0, 8, 1 do
	t 0, 0; b 1/2
end
tp_drop 8, 0, 1 do
	4.times do |i|
		x, y = 3-i, i
		i.zero? ? t(x, y) : d(x, y)
		b 1/8
	end
end
tp_drop -8, 0, 1 do
	t -3, 4; b 1/2
	t -5, 2; b 1/2
	t -3, 0; b 1/2
end
b -1
tp_drop 8, 0, 1 do
	t 5, 2; b 1/2
	t 3, 4; b 1/2
end

hexagram 1/2
notes = group do
	tp_drop -8, 0, 1, preserve_beat: false do
		4.times do |i|
			x, y = -2 - i, 4 - 2*i
			t x, y; b 1/2
		end
	end
	tp_drop 8, 0, 1 do
		4.times do |i|
			x, y = 2 - i, 2 - 2*i
			t x, y; b 1/2
		end
	end
end
transform duplicate notes do
	rotate PI
	beat_translate 2
end
b 2

tp_drop 8, 0, 1, preserve_beat: false do
	4.times do |i|
		x, y = 4 + i, 3 - 2*i
		t x, y; b 1/2
	end
end
tp_drop -8, 0, 1 do
	b 1/4
	4.times do |i|
		x, y = -3 + i, 2 - 2*i
		t x, y; b 1/2
	end
	b -1/4
end
tp_drop 8, 0, 1, preserve_beat: false do
	2.times do |i|
		x, y = 3 - i, -3 + 2*i
		t x, y; b 1/2
	end
end
tp_drop -8, 0, 1 do
	b 1/4
	2.times do |i|
		x, y = -4 - i, -2 + 2*i
		t x, y; b 1/2
	end
	b -1/4
end
tp_drop 8, 0, 1 do
	4.times do |i|
		x, y = 1 + i, 1 + i
		i.zero? ? t(x, y) : d(x, y)
		b 1/8
	end
end
tp_drop -8, 0, 1 do
	8.times do |i|
		x, y = 0 - i, 4 - i
		i.zero? ? t(x, y) : d(x, y)
		b 1/16
	end
end

def chain2
	group do
		tp_drop -8, 0, 1 do
			f -8, -4, :l
		end
		tp_chain 8, 0, 1 do
			6.times do |i|
				x, y = -4+i*2, 2-i
				i.zero? ? t(x, y) : d(x, y)
				bg_note -6+i*2, -2+i
				b 1/4
			end
		end
	end
end
chain2
transform(chain2) { horizontal_flip }
chain2
transform(chain2) { horizontal_flip }
tp_drop -8, 0, 1 do
	f -8, -4, :l
end
tp_drop 8, 0, 1 do
	t 8, -4; b 1/4
	t 7, -2; b 1/4
end
tp_drop -8, 0, 1 do
	t -7, 0; b 1/4
end
tp_drop 8, 0, 1 do
	t 7, 2; b 1/4
end
tp_chain -8, 0, 1, preserve_beat: false do
	4.times do |i|
		prog = i/4
		x, y = -8 + 6*prog, 4 - 8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
tp_chain 8, 0, 1 do
	4.times do |i|
		prog = i/4
		x, y = 8 - 6*prog, 4 - 8*prog
		d(x, y); b 1/4
	end
end

grid 64
tp_drop 0, 8, 1, preserve_beat: false do
	15.times do |i|
		h -2*(-1)**i, -4, 7; b 8
	end
end
tp_drop 0, 8, 1 do
	[
		[2, 8],
		[-8, 4], [-6, 2], [-4, 2],
		[8, 4], [4, 2], [2, 2],
		[-4, 6], [-6, 2],
		[4, 8],
		[-4, 4], [-6, 2], [-8, 2],
		[6, 6], [4, 2],
		[-6, 4], [-4, 4],
	].each do |x, delta|
		h x, -4, delta - 1
		b delta
	end
end

group preserve_beat: false do
	16.times do |i|
		5.times do |j|
			bg_note -8, 4-2*j
			bg_note 8, 4-2*j
			b j == 4 ? 2 : 3/2
		end
	end
end

group preserve_beat: false do
	[
		[-4, %w[Shae 'ri nov so 'lar], [1, 1, 1, 1, 4]],
		[-2, %w[Von mjrn melu a 'r], [2, 6, 1, 1, 1, 3]],
		[-4, %w[Ner quo sae ior], [3/2, 3/2, 1, 2]],
		[-4, %w[A 'oln y'aer], [2, 2, 6]],
		[-2, %w[Ae ia suo 'qia noi 'laer], [2, 4, 3/2, 3/2, 1, 8]]
	].each_with_index.reduce 0 do |cur, ((initial, words, deltas), j)|
		b initial
		cur += initial
		sums = deltas.each_with_object([0]) { |delta, sums| sums.push sums.last + delta }
		words.zip(deltas, sums[...-1]).each_with_index do |(word, delta, sum), i|
			bg_note -words.size+1 + i*2, 3+(-1)**j, sums.last - sum, word
			b delta
			cur += delta
		end
		r = (cur / 8).ceil * 8
		b r - cur
		r
	end
end

2.times do |i|
	tp_chain 8, 0, 1 do
		i.zero? ? f(4, 0, :r) : t(4, -1); b 2
		d 1, 0 if i==1; b 1
		t -4, -1; b 1/2
		d -3, 0; b 1/2

		t -2, -1; b 1/2
		d -1, 0; b 1/2
		d 0, -1; b 1
		t 2, 0; b 1/2
		d 3, -1; b 1/2
		d 4, 0; b 1
	end

	tp_chain -8, 0, 1 do
		t -3, -1; b 1/2
		t -2, 0; b 3/2
		t 1, -1; b 1
		t 4, 0; b 1/2
		d 3, -1; b 1/2

		t 2, 0; b 1/2
		t 1, -1; b 1/2
		d 0, 0; b 1/2
		d -1, -1; b 1/2
		t -2, 0; b 1
		d -4, -1; b 1
	end

	tp_chain 8, 0, 1 do
		t 3, 0; b 1
		d 1, -1; b 1
		d -1, 0; b 1
		t -4, -1; b 1/2
		d -3, 0; b 1/2

		t -2, -1; b 1/2
		d -1, 0; b 1/2
		d 0, -1; b 1/2
		d 1, 0; b 1/2
		t 2, -1; b 1
		t 4, 0; b 1
	end

	next if i == 1
	tp_chain -8, 0, 1 do
		t -3, -1; b 1/2
		d -2, 0; b 1/2
		d -1, -1; b 1
		t 1, 0; b 1
		t 4, -1; b 1/2
		d 3, 0; b 1/2

		t 2, -1; b 1/2
		t 1, 0; b 1/2
		d 0, -1; b 1/2
		d -1, 0; b 1/2
		t -2, -1; b 1
		t -4, 0; b 1
	end
end

diamond_grid 7
b 4

b 5/2
tp_drop -8, 0, 1 do
	t 1, -2; b 1/4
end
tp_drop 8, 0, 1 do
	t 3, -3; b 1/4
end
tp_drop -8, 0, 1 do
	f 0, -4, :ul
end
tp_chain 0, -8, 1 do
	4.times do |i|
		d -i, -4+i; b 1/4
	end

	f -1, -1, :dr; b 1/2
end
def pattern second = false; group do
	tp_chain 0, -8, 1 do
		4.times do |i|
			d 1+i, -3+i; b 1/4
		end
		t 0, 0; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			d -2-i, -2+i; b 1/4
		end
		t 1, 1; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			x, y = 3+i, -1+i

			i == 3 ? t(x, y) : d(x, y)
			b 1/4
		end
		t -2, 2; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			d -4-i, i; b 1/4
		end
		t 3, 3; b 1/4
	end
	tp_chain 0, -8, 1 do
		d 2, 2; b 1/4
		t -4, 2; b 1/4
	end
	tp_chain 0, -8, 1 do
		d -3, 1; b 1/4
		t 5, 1; b 1/4
	end
	tp_chain 0, -8, 1 do
		d 4, 0; b 1/4
		t -6, 0; b 1/4
	end
	tp_chain 0, -8, 1 do
		d -5, -1; b 1/4

		t -1, -1; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			d 1+i, -3+i; b 1/4
		end
		t 0, 0; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			d -2-i, -2+i; b 1/4
		end
		t 1, 1; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			x, y = 3+i, -1+i

			i == 3 ? t(x, y) : d(x, y)
			b 1/4
		end
		t -2, 2; b 1/2
	end
	tp_chain 0, -8, 1 do
		4.times do |i|
			d -4-i, i; b 1/4
		end
		t 3, 3; b 1/4
	end
	tp_chain 0, -8, 1 do
		d 4, 2; b 1/4
		t -2, 2; b 1/4
	end
	tp_chain 0, -8, 1 do
		d -3, 1; b 1/4
		t 1, 1; b 1/4
	end
	tp_chain 0, -8, 1 do
		d 2, 0; b 1/4
		t 0, 0; b 1/4
	end
	tp_chain 0, -8, 1 do
		d -1, -1; b 1/4

		(t 1, -1; b 1/2) unless second
	end
end; end
pattern
transform pattern true do
	horizontal_flip
end
group preserve_beat: false do
	hexagon 16-1; b 16
	hexagon 4-1; b 4
	hexagon 4; b 4
end

notes = group preserve_beat: false do
	4.times do |i|
		bg_note 6*(-1)**i, -3; b 1/2
		4.times do |j|
			bg_note 6*(-1)**i, -0.5+1.5*j; b 1/4
		end
	end
	8.times do |i|
		bg_note 6-0.5*(-1)**i, -3+i; b 1/4
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 8
end
transform duplicate notes do
	beat_translate 16
end

def r_pos cur
	y = 4 - 16*(1/2 - (cur/4 - (cur/4).floor)).abs
	x = 8/sqrt(3) - y.abs/sqrt(3)
	[x, y]
end
notes = tp_drop 8, 0, 1 do
	([1]*6 + [3/4, 1/4, 1/2, 1/2] + [1]*6 + [1/4, 1/2, 1/4, 1/2] + [1/6]*3 + [1/2]*8).reduce 0 do |cur, delta|
		x, y = r_pos cur
		delta == 1/6 && cur % (1/2) != 0 ? d(x, y) : t(x, y)
		b delta
		cur + delta
	end
end
transform duplicate notes do
	rotate PI
end

16.times do |i|
	tp_chain 8*(-1)**i, 0, 1 do
		x, y = r_pos i/4
		t x*(-1)**i, y*(-1)**i; b 1/4
	end
end

tp_drop 8, 0, 1 do
	f 4/sqrt(3), -4, :r; b 4
end

b 5/2
tp_drop -16, 0, 1 do
	t -1, 2; b 1/4
end
tp_drop 16, 0, 1 do
	t 1, 1; b 1/4
end
tp_drop -16, 0, 1 do
	f -2, 0, :dl
end
tp_chain 0, -16, 1 do
	4.times do |i|
		d -2-i, -i; b 1/4
	end
end

def four_key data
	tp_drop 0, 18, 1 do
		data.each do |indices|
			(indices.is_a?(Array) ? indices : [indices]).each do |i|
				t -6+4*i, -4
			end
			b 1/4
		end
	end
end
four_key [
	[2, 3], [], 1, 0,
	[2, 3], 1, 0, [],
	[2, 3], 1, 2, 1,
	[0, 3], [], 0, 1,

	[2, 3], 0, 1, [],
	[2, 3], 1, 2, 1,
	[0, 3], 1, 2, 3,
	[0, 1], 2, [0, 1], 2,

	[0, 1], [], 3, 2,
	[0, 1], 2, 3, [],
	[0, 1], 2, 3, 2,
	[0, 1], [], 2, 3,
]

tp_chain 0, -16, 1, preserve_beat: false do
	t -4, -2; b 1/4
	t -1, 0; b 1/4
	t -4, 2; b 1/2
	t 7, 4; b 1/4
	t 1, 2; b 1/4
	t 7, 0; b 1/4
	t 1, -2; b 1/4
	t 4, -4; b 1/4
	d 3, -3; b 1/4
	t -6, -2; b 1/4
	t 3, 0; b 1/4
	t -6, 2; b 1/4
	d -4, 3; b 1/4
	t 6, 4; b 1/4
	d 2, 3; b 1/4
end
tp_drop -16, 0, 1 do
	t -7, -2; b 1/2
	t -7, 2; b 1/2
	4.times do |i|
		x, y = 4-i, 4-i
		i.zero? ? t(x, y) : d(x, y)
		b 1/8
	end
	t 4, 0; b 1/2
end
tp_drop 16, 0, 1 do
	4.times do |i|
		x, y = 7-i, -4+i
		i.zero? ? t(x, y) : d(x, y); b 1/16
	end
	d 3, 0; b 1/8
	d 2, -1; b 1/8
	t -3, -2; b 1/4
end
tp_drop -16, 0, 1 do
	t 0, 0; b 1/4
end
tp_drop 16, 0, 1 do
	f -3, 2, :ul; b 1/2
end
tp_drop -16, 0, 1 do
	f 3, 4, :dl; b 1/2
end

four_key [
	[0, 1], [], [2, 3], 1,
	[2, 3], 1, 0, [],
	[2, 3], 1, 2, 3,
	[0, 1], 2, [0, 1], [2, 3],

	[0, 1], 2, 3, [],
	[0, 1], 2, 3, 2,
]
tp_chain 0, -16, 1, preserve_beat: false do
	4.times do |i|
		t i.even? ? -7 : 3, -3+6/4*i; b 1/4
	end
	4.times do |i|
		t i.even? ? -5 : 5, 3-7/4*i; b 1/4
	end
end
tp_drop 16, 0, 1 do
	t -2, -3; b 1/2
	t -2, 0; b 1/4
	d 3, 1.5; b 1/4
	t 0, 3; b 1/2
	4.times do |i|
		x, y = -i, -1/2-i/2
		i.zero? ? t(x, y) : d(x, y); b 1/16
	end
	d 5, -9/4; b 1/4
end

four_key [
	[0, 1], [], 3, 2,
	[0, 1], 2, 3, [],
	[0, 1], 3, 2, 1,
	[0, 3], [], [0, 1], [2, 3]
]

notes = tp_drop 12, -12, 1, preserve_beat: false do
	t -3, -3; b 1/2
	t -2, -1; b 1/2
	t 0, 1; b 1/2
end
transform duplicate notes do
	rotate PI
	beat_translate 3/2
end
def pattern second = false; group do
	6.times do |i|
		prog = i/6
		x, y = -8 + (prog-1/3)**2*9, -2+6*prog
		i.zero? ? t(x, y) : d(x, y) if second || i!=3; b 1/4
	end
end; end
tp_chain 0, -16, 1 do
	pattern
	transform(pattern true) { rotate PI }
	t -3, -3; b 1/4
	(1...4).each do |i|
		x, y = -7+1.5*i, -2+1.5*i
		d x, y; b 1/4
	end
end
tp_drop -16, 0, 1, preserve_beat: false do
	b -1
	f -7, -2, :ur
end

four_key [
	[2, 3], [], 2, 3,
	[0, 1], 2, 3, [],
	[0, 1], 2, 1, 2,
	[0, 3], [], 2, 1,

	[2, 3], 0, 1, [],
	[2, 3], 1, 3, 2,
	[0, 3], 1, 2, 3,
	[0, 1], 2, [0, 1], 2,

	[0, 1], [], 2, 3,
	[0, 1], 2, 3, [],
	[0, 1], 2, 1, 2,
	[0, 3], [], 1, 2,
]

def chain3 x0, y0, x1, y1, no_first = false
	3.times do |i|
		x, y = x0 + (x1-x0) * i/3, y0 + (y1-y0) * i/3
		i.zero? ? t(x, y) : d(x, y) if !no_first || i != 0
		b 1/4
	end
end
tp_chain 0, -16, 1, preserve_beat: false do
	chain3 -7, -3, -1, 0
	chain3 -1, 0, -7, 3, true
	chain3 7, 3, 1, 0
	chain3 1, 0, 7, -3
	4.times do |i|
		x, y = -1-i, -2+1.5*i
		i.zero? ? t(x, y) : d(x, y)
		b 1/4
	end
	mark :m
end
tp_drop 16, 0, 1 do
	f 7, -3, :ur; b 3/4
	f 2, -2, :ur; b 3/4
end
tp_drop -16, 0, 1 do
	f -7, 3, :dl; b 3/4
	f -2, 2, :dl; b 3/4
end
tp_drop 16, 0, 1 do
	f 7, -3, :u; b 1
end

group preserve_beat: false do
	7.times do |i|
		tp_drop -(-1)**i*16, 0, 1 do
			x, y = [5, 8, 5, 2, 5, 8, 5][i] * -(-1)**i, 4-8*i/6
			i==6 ? f(x, y, :u) : t(x, y); b 1/2
		end
	end
end
at :m, preserve_beat: true, update_mark: true do
	[false, true, true, false, true, true, false].each_with_index do |two, i|
		x, y = [5, 8, 5, 2, 5, 8, 5][i] * (-1)**i, 4-8*i/6
		t x, y; b 1/4
		d x-1*(-1)**i, y+1 if two; b 1/4
	end
	d -5, -1; b 1/4
	d -5, 2; b 1/4
end

tp_drop -16, 0, 1, preserve_beat: false do
	0.upto 12 do |i|
		prog = i/12
		x, y = -2*prog-3*sin(PI*prog) + 3*(-1)**i, 4-8*prog
		i.zero? ? f(x, y, :dl) : i==12 ? f(x, y, :u) : t(x, y); b 1/4
	end
end
at :m, preserve_beat: true, update_mark: true do
	[true, false, true, true, true, true, false].each_with_index do |two, i|
		prog = 2*i/12
		t 7-2*(1-(1-prog)**2), 4-8*prog; b 1/4
		if two
			prog = (2*i+1)/12
			d -3-2*prog-3*sin(PI*prog), 4-8*prog
		end
		b 1/4
	end
	b -1/4
	(1...4).each do |i|
		prog = i/4
		x, y = 5, -4+8*prog
		d x, y; b 1/4
	end
end

tp_drop 16, 0, 1 do
	32.times do |i|
		x, y = -6+4*(i%4), 4 - 8*i/32
		t x, y; b 1/8
		at :m, update_mark: true do
			d x, y if 0b01010001010101010001010101010001[i] == 1
			b 1/8
		end
	end

	t -6, -4
end
group preserve_beat: false do
	%w[Shae 'ri nov so].each_with_index do |word, i|
		bg_note -2+2*i, 4, word; b 1
	end
end
at :m, preserve_beat: true, update_mark: true do
	8.times do |i|
		prog = i/8
		angle, radius = -PI/2-PI/12 - 2*PI*prog, 4/cos(PI/12)*(1-prog)
		x, y = radius*cos(angle)*1/(2*tan(PI/12)), radius*sin(angle)
		i.zero? ? t(x, y) : d(x, y) unless i==3; b 1/4
	end
	tp_drop(-16, 0, 1) { t -3, 1 }
	t 0, 0; b 1/4
	d -4, 2; b 1/4
	tp_drop(-16, 0, 1) { t 4, -1 }
	t 7, 0; b 1/4
	tp_drop(16, 0, 1) { t 2, -3 }
	t -1, -4; b 1/4
	tp_drop(16, 0, 1) { f 8, -3, :ur }
	4.times do |i|
		prog = i/4
		x, y = 5+8*prog-7*prog**2, -4+8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

hexagram 1/2
group preserve_beat: false do
	8.times do |i|
		2.times do
			notes = group do
				bg_note -6*(-1)**i, 4; b 1/2
				4.times do |j|
					bg_note (-4+j)*(-1)**i, 4; b 1/4
				end
			end
			transform duplicate notes do
				horizontal_flip
				beat_translate 3/2
			end
			transform duplicate notes do
				vertical_flip
			end
			transform duplicate notes do
				horizontal_flip
				vertical_flip
				beat_translate 3/2
			end
			b 3/2
		end
		notes = group do
			8.times do |j|
				bg_note -8+j%2, -4+j; b 1/4
			end
		end
		transform duplicate notes do
			horizontal_flip
		end
	end
end
tp_chain 8, 0, 1 do
	h 6, 4, 4, "'lar"
end
tp_drop 12, 12, 1 do
	4.times do |i|
		t -7, 0; t -3, -1; b 1/2
	end
	4.times do |i|
		t -8, -3; t -4, -4; b 1/2
	end
	4.times do |i|
		t -5, -1; t -1, -2; b 1/2
	end
end
tp_chain -8, 0, 1 do
	h -7, 2, 1, "Von"
end
tp_drop -12, 12, 1 do
	4.times do |i|
		t 7, 0; t 3, -1; b 1/2
	end
end
b -1/4
tp_drop 12, 12, 1 do
	t -4, 1; t 0, 0; b 1/4
end

tp_chain 8, 0, 1 do
	h 6, 3, 3, 'mjrn'
end
tp_drop -12, 12, 1 do
	t 2, 2; d 6, 3; b 1/2
end
tp_drop 12, 12, 1 do
	3.times do |i|
		t -4, 1; t 0, 0; b 1/2
	end
	4.times do |i|
		t -5, -2; t -1, -3; b 1/2
	end

	t -3, 3; t 1, 2; b 1/4
end
tp_drop -12, 12, 1 do
	t 2, 1; t 6, 2; b 1/4
end
tp_drop 12, 12, 1 do
	t -4, 1; t 0, 0; b 1/4
end
tp_drop -12, 12, 1 do
	t 3, -1; t 7, 0; b 1/4
end
group preserve_beat: false do
	bg_note -6, 1, 1/2, 'me'; b 3/2
	bg_note 4, 2, 1/2, 'lu'; b 3/2
	bg_note -8, 2, 'a'
end
tp_drop 12, 12, 1 do
	5.times do
		t -5, -1; t -1, -2; b 1/2
	end
end
b -1/4
tp_drop -12, 12, 1 do
	t 2, -1; t 6, 0; b 1/4
end
tp_drop 12, 12, 1 do
	t -4, 2
	8.times do |i|
		x, y = -i, 1-i/2
		i.zero? ? t(x, y) : d(x, y); b 1/16
	end
end

tp_drop -12, 12, 1 do
	6.times do |i|
		tp_chain -8, 0, 1 do
			h -6, 3, 2, "'r"
		end if i == 2
		t 2, -1; t 6, 0; b 1/2
	end
end
notes = group do
	tp_drop 12, 12, 1 do
		t -5, 1; t -1, 0; b 1/4
	end
	tp_drop -12, 12, 1 do
		t 0, -1; t 4, 0; b 1/4
	end
	tp_drop 12, 12, 1 do
		t -6, -1; t -2, -2; b 1/4
	end
	tp_drop -12, 12, 1 do
		t 1, -3; t 5, -2; b 1/4
	end

	tp_drop 12, 12, 1 do
		3.times { t -7, -3; t -3, -4; b 1/2 }
	end
end
transform notes do
	horizontal_flip
	translate -2, 2
end
group preserve_beat: false do
	b -3/2
	bg_note 7, 2, 1/2, 'Ner'; b 3/2
	bg_note -8, 1, 1/2, 'quo'; b 3/2
	bg_note 8, 0, 'sae'
end
tp_drop 12, 12, 1 do
	3.times { t -8, -2; t -4, -3; b 1/2 }
end
tp_drop -12, 12, 1 do
	t 6, -3; t 2, -4; b 1/2
	t 5, -1; b 1/8
	t 1, -2; b 1/8
end
tp_drop 12, 12, 1 do
	t -6, 0; b 1/8
	t -2, -1; b 1/8
end

tp_chain 8, 0, 1 do
	h 4, 1, 1, 'ior'
end
tp_drop -12, 12, 1 do
	d 4, 1; t 0, 0; b 1/2
end
tp_drop 12, 12, 1 do
	t -4, 3; t 0, 2; b 1/2
	t -5, 1; b 1/8
	t -1, 0; b 1/8
end
tp_drop -12, 12, 1 do
	t 0, -1; t 4, 0; b 1/4
end
tp_drop 12, 12, 1 do
	t -6, -1; t -2, -2; b 1/2
end
tp_drop -12, 12, 1 do
	t -1, 3; t 3, 4; b 1/4
end
tp_drop 12, 12, 1 do
	t -2, 2; t -6, 3; b 1/4
end
tp_drop -12, 12, 1 do
	t 4, 2; b 1/8
	t 0, 1; b 1/8
end
tp_drop 12, 12, 1 do
	t -3, 0; t -7, 1; b 1/4
end
tp_drop -12, 12, 1 do
	t 1, -1; t 5, 0; b 1/2
end
notes = group do
	tp_drop 12, 12, 1 do
		t -6, -3; b 1/16
		d -5, -2; b 1/16
		t -2, -4; b 1/16
		d -1, -3; b 1/16
	end
	tp_drop -12, 12, 1 do
		t 5, -2; b 1/16
		d 4, -1; b 1/16
		t 1, -3; b 1/16
		d 0, -2; b 1/16
	end

	tp_drop 12, 12, 1 do
		t -5, -1; t -1, -2; b 1/2
	end
end
transform notes do
	translate -2, 0
end
group preserve_beat: false do
	b -1/2
	bg_note -8, 3, 1, 'A'; b 2
	bg_note 8, 4, 1, "'oln"; b 2
end
notes = group do
	tp_drop -12, 12, 1 do
		t 3, 2; t 7, 3; b 1/4
	end
	tp_drop 12, 12, 1 do
		t 1, 1; t -3, 2; b 1/4
	end
	tp_drop -12, 12, 1 do
		f 4, 0, :ur; t 8, 1; b 1/2
	end
end
transform notes do
	translate 0, -2
end
notes = group do
	tp_drop 12, 12, 1 do
		t 0, 1; t -4, 2; b 1/4
	end
	tp_drop -12, 12, 1 do
		t 1, 0; t 5, 1; b 1/4
	end
	tp_drop 12, 12, 1 do
		t -1, -1; t -5, 0; b 1/4
	end
	tp_drop -12, 12, 1 do
		t 2, -2; t 6, -1; b 1/4
	end
	tp_drop 12, 12, 1 do
		f -2, -3, :ul; t -6, -2; b 1/2
	end
end
transform notes do
	translate -2, 2
end
tp_drop -12, 12, 1 do
	f 1, 3, :ur; t 5, 4; b 1
end

hexagram 1/2
tp_chain -8, 0, 1 do
	h -7, 1, 5, "y'aer"
end
tp_drop -12, 12, 1 do
	4.times do |i|
		t 0, -1; t 4, 0; b 1/2
	end
	4.times do |i|
		t 1, -4; t 5, -3; b 1/2
	end

	4.times do |i|
		t 2, 0; t 6, 1; b 1/2
	end
end
tp_chain 8, 0, 1 do
	h 4, 4, 1, 'ae'
end
tp_drop 12, 12, 1 do
	4.times do |i|
		t -1, -2; t -5, -1; b 1/2
	end
end
b -1/4
tp_drop -12, 12, 1 do
	t 2, -1; t 6, 0; b 1/4
end

tp_chain -8, 0, 1 do
	h -4, 2, 3, 'ia'
end
tp_drop 12, 12, 1 do
	t 0, 1; d -4, 2; b 1/2
end
tp_drop -12, 12, 1 do
	5.times do |i|
		t 2, -1; t 6, 0; b 1/2
	end
end
tp_drop -12, 12, 1 do
	t 2, 1; t 6, 2; b 1/4
end
tp_drop 12, 12, 1 do
	t 0, 0; t -4, 1; b 1/4
end
tp_drop -12, 12, 1 do
	t 3, -1; t 7, 0; b 1/4
end
tp_drop 12, 12, 1 do
	t -1, -2; t -5, -1; b 1/4
end

group preserve_beat: false do
	b 1
	bg_note 6, -2, 1/2, 'suo'; b 3/2
	bg_note -5, -1, 1/2, "'qia"; b 3/2
end
tp_drop -12, 12, 1 do
	3.times do |i|
		t 4, -3+i*2; t 8, -2+i*2; b 1/3
	end
end
tp_drop 12, 12, 1 do
	3.times do |i|
		t -3, -2+i*2; t -7, -1+i*2; b 1/3
	end
end
tp_drop -12, 12, 1 do
	3.times do |i|
		t 2, 3-i*2; t 6, 4-i*2; b 1/3
	end
end
tp_drop 12, 12, 1 do
	f -1, 0, :ul; t -5, 1; b 1
end

bg_note 0, 3, 3, 'noi'
notes = group do
	13.times do |i|
		tp_drop -(-1)**i*12, 12, 1 do
			i==12 ? f(2*(-1)**i, 2, :ur) : t(2*(-1)**i, 2)
			t 6*(-1)**i, 3; b 1/4
		end
	end
end
b 3/4

bg_note 0, -1, 3, "'la"
transform duplicate notes do
	horizontal_flip
	translate 0, -4
	beat_translate 4
end
b 4

bg_note 0, 0, 7, 'er'
4.times do |i|
	tp_drop -12, 12, 1 do
		t 4, 4-i*2; b 1/6
	end
	tp_drop 0, 16, 1 do
		t 0, 3-i*2; b 1/6
	end
	tp_drop 12, 12, 1 do
		t -4, 4-i*2; b 1/6
	end
end

16.times do |i|
	x, y = [6, 2, -6, -2][i%4], 2-(i/4).floor*2 + [1, 0, 1, 0][i%4]
	dx = -(-1)**(i/2).floor
	tp_drop 12*dx, 12, 1 do
		t x, y; b 1/16
		d x-dx, y+1 if i >= 8; b 1/16
	end
end

notes = group do
	tp_drop -12, 12, 1 do
		t 2, 3; t 6, 4; b 1/4
	end
	tp_drop 12, 12, 1 do
		t 0, 1; t -4, 2; b 1/4
	end
	tp_drop -12, 12, 1 do
		t 3, 0; t 7, 1; b 1/4
	end
	tp_drop 12, 12, 1 do
		t -1, -2; t -5, -1; b 1/4
	end
	tp_drop -12, 12, 1 do
		f 4, -3, :ur; t 8, -2; b 1/2
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/2
end
b 3/2
5.times do |i|
	3.times do |j|
		x, y = -5+5*j, 4-i*2
		tp_drop -12*(x<=>0), x.zero? ? 16 : 12, 1 do
			i.even? ? i==4 ? f(x, y, :u) : t(x, y) : d(x, y)
		end
	end
	b 1/4 unless i == 4
end

b 1
grid 8
4.times do |i|
	x, y = 8*(-1)**i, 4-8*(i/2).floor
	tp_chain -x, -y, relative: false, relative_beat: 1 do
		h x, y, 8
	end
end

transform @events do
	scale 12.5
end

end
