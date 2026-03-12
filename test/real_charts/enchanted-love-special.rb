include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title 'enchanted love'
artist 'linear ring'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '13'

offset 0.033
bpm 190

2.times do
	tp_chain 0, 0, 0 do
		h 5, 0, 2; b 2/3
		d 1, 0; b 1/3
		d -1, 0; b 2/3
		d -5, 0; b 1/3
	end
	tp_chain 0, 0, 0 do
		b 2/3
		t -3, 0; b 1/3
		t -1, 0; b 2/3
		t 3, 0; b 1/3
	end
end

2.times do
	tp_chain 0, 0, 0 do
		h 5, 0, 2; b 2/3
		d 1, -1; b 1/3
		d -1, 1; b 2/3
		d -5, 0; b 1/3
	end
	tp_chain 0, 0, 0 do
		b 2/3
		t -3, 0; b 1/3
		t -1, 0; b 2/3
		t 3, 0; b 1/3
	end
end

2.times do
	tp_chain 0, 0, 0 do
		h 5, 0, 2; b 2/3
		t 1, 2; b 1/3
		t -1, -2; b 2/3
		t -5, 0; b 1/3
	end
	tp_chain 0, 0, 0 do
		b 2/3
		t -3, 0; b 1/3
		t -1, 0; b 2/3
		t 3, 0; b 1/3
	end
end

cur = 0
target = 8
2.times do |i|
	x = -6*(-1)**i
	group preserve_beat: false do
		4.times do |j|
			bg_note x, 3-j*2, target - cur
			(b 1/3; cur += 1/3) unless j == 3
		end
	end
	tp_chain 0, 0, 0 do
		t x, 3; b 2/3
		t x, -3; b 1/3
		mark i
	end
end
group preserve_beat: false do
	b 1/3; cur += 1/3
	5.times do |i|
		bg_note -4+i*2, -3, target - cur
		b 1/3; cur += 1/3
	end
end
tp_chain 0, 0, 0 do
	b 2/3
	t -2, -3; b 1/3
	t 0, -3; b 2/3
	t 4, -3; b 1/3
end

2.times do |i|
	group preserve_beat: false do
		3.times do |j|
			bg_note (-5+j)*-(-1)**i, 2-j, target - cur
			b 1/3; cur += 1/3
		end
	end
	at i, preserve_beat: true, update_mark: true do
		b 3
		t -5*(-1)**i, 2; b 2/3
		t -3*(-1)**i, 0; b 1/3
	end
end
2.times do |i|
	group preserve_beat: false do
		3.times do |j|
			bg_note -j*(-1)**i, 3-j, target - cur unless i == 1 && j == 0
			b 1/3; cur += 1/3
		end
	end
	at i, preserve_beat: true, update_mark: true do
		b 1
		t 0, 3; b 2/3
		t -2*(-1)**i, 1; b 1/3
	end
end

rhythm = [2/3, 1/3, 2/3, 1, 1/3, 2/3, 1/3]
notes = tp_chain 0, 8, 1 do
	14.times do |i|
		x = -8 + (i/2).round(half: :up)*2
		y = 4 - (i/2).round(half: :down)*4/3
		(i%7).zero? ? h(x, y, 2) : t(x, y)
		b rhythm[i%7]
	end
end

transform(duplicate notes) { horizontal_flip; beat_translate 8 }; b 8

notes = tp_chain 0, 8, 1 do
	7.times do |i|
		x = -6 + (i/2).round(half: :up)*2
		y = 3 - (i/2).round(half: :down)*2
		i.zero? ? h(x, y, 2) : t(x, y)
		b rhythm[i]
	end
end

transform(duplicate notes) { horizontal_flip; beat_translate 4 }; b 4

notes = group do
	tp_chain -8, 0, 1 do
		h -8, 4, 2; b 2/3
		t -8, 1; b 1/3
		t -6, 1; b 2/3
		t -6, -2; b 1/3
	end
	tp_chain 0, 8, 1 do
		b 2/3
		t -4, 2; b 1/3
		t -2, 2; b 2/3
		t -2, -1; b 1/3
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 4 }; b 4

diamond_grid 2/3
tp_chain -6, 24, relative_beat: 1, preserve_beat: false do
	5.times do |i|
		x, y = -1+i/2, 4-i*2
		i.zero? ? f(x, y, :d) : d(x, y); b 1/12
	end
end
tp_chain 0, 8, 1 do
	b 2/3
	t 6, 1; b 1/3
	t 8, 0; b 2/3
	t 6, -3; b 1/3
end
tp_chain 0, -8, 1 do
	b 2/3
	t -6, -3; b 1/3
	t -4, -2; b 2/3
	t -6, 0; b 1/3

	t -4, 1
end
tp_chain 0, 8, 1 do
	t 8, 4; b 2/3
	t 6, 1; b 1/3
	t 8, 0; b 2/3
	t 6, -3; b 1/3
end
tp_chain 0, 8, 1 do
	b 2/3
	t -5, 3; b 1/3
	t -3, 2; b 2/3
	t -5, 0; b 1/3

	diamond_grid 2/3
	t -3, -1
end
tp_chain 0, -8, 1 do
	f 7, -4, :r; b 2/3
	t 5, -1; b 1/3
	t 7, 0; b 2/3
	t 5, 3; b 1/3
end
tp_chain 0, 8, 1 do
	b 2/3
	t -4, 2; b 1/3
	t -2, 3; b 2/3
	t -4, -1; b 1/3

	t -2, 0
end
tp_chain 0, -8, 1 do
	t 6, -4; b 2/3
	t 4, 0; b 1/3
	t 6, -1; b 2/3
	t 4, 3; b 1/3
end
tp_chain 0, 8, 1 do
	b 2/3
	t -4, 2; b 1/3
	t -2, 3; b 2/3
	t -8, -1; b 1/3

	diamond_grid 2/3
	f -6, -2, :l
end
tp_chain 0, 8, 1 do
	t 6, 4; b 2/3
	t 4, 0; b 1/3
	t 2, 1; b 2/3
	t 0, -3; b 1/3
end
tp_chain 0, -8, 1 do
	b 2/3
	t -4, -2; b 1/3
	t -2, -1; b 2/3
	t -8, 1; b 1/3

	t -6, 2
end
tp_chain 0, -8, 1 do
	t 6, -4; b 2/3
	t 4, 0; b 1/3
	t 2, -1; b 2/3
	t 0, 3; b 1/3
end
tp_chain 0, -8, 1 do
	b 2/3
	t -2, -2; b 1/3
	t 0, -3; b 2/3
	t -6, 1; b 1/3

	diamond_grid 2/3
	t -8, 2
end
tp_chain 0, -8, 1 do
	f 8, -4, :r; b 2/3
	t 6, 0; b 1/3
	t 4, -1; b 2/3
	t 2, 3; b 1/3
	t 4, 4
end
tp_chain 0, -8, 1 do
	t -3, -4; b 2/3
	t -6, -1; b 1/3
	t -8, 0; b 2/3
	t -2, 1; b 1/3

	t 0, 2
end
tp_chain 0, 8, 1 do
	t 5, 4; b 2/3
	t 7, 2; b 1/3
	t 5, 1; b 2/3
	t 1, 0; b 1/3
	t 3, -1
end
tp_chain 0, 8, 1 do
	t -3, 4; b 2/3
	t -6, 0; b 1/3
	t -8, 1; b 2/3
	t -2, -3; b 1/3

	mark :m
end
turntable 28
30.times do |i|
	group preserve_beat: false do
		start = ((1-(1-i/30)**2)*90).floor/3
		b start
		(0...30-start).step(1/6) do |j|
			r = 12-j*(i+1)/4
			break if r <= 0
			a = -(j*(1/3+i/72)+i**2/3)*PI
			x, y = r*cos(a), r*sin(a)
			next if x.abs > 8 || y.abs > 4
			bg_note x, y; b 1/6
		end
	end
end

def da phase
	angle = PI/2 - phase/4*PI
	d 4*cos(angle), 4*sin(angle)
end
tp_chain 0, 8, 1 do
	4.times do |i|
		notes = group do
			h 0, 4, 3
			da 0; b 2/3
			da 2/3; b 1/3
			da 1; b 2/3
			da 5/3; b 1/3
			da 2 if i == 3; b 2/3
			da 8/3; b 1/3
			da 3; b 2/3
			da 11/3; b 1/3
		end
		transform(notes) { rotate PI } if i.odd?
	end

	2.times do |i|
		h 0, 4, 1
		da 0; b 2/3
		da 4/3; b 1/3
		da 2; b 2/3
		da 10/3; b 1/3
		h 0, -4, 1; b 2/3
		da 16/3; b 1/3
		da 6; b 2/3
		da 22/3; b 1/3
	end
	
	t 0, 4; b 1
	t 4, 0; b 1
	t 0, -4; b 1
	t -4, 0; b 1
	
	t 0, 4; b 2/3
	t 2*sqrt(3), 2; b 1/3
	t 4, 0; b 2/3
	t 2, -2*sqrt(3); b 1/3
	big_text 5/3, 'enchanted love'
	t 0, -4; b 2/3
	tp_drop 0, -8, 1 do
		t 3, 3; b 1/3
		t 1, 3; b 2/3
		t -3, 3; b 1/3
	end
end

def ta phase
	angle = -PI/2 - phase/4*PI
	t 4*cos(angle), 4*sin(angle)
end
def da phase
	angle = -PI/2 - phase/4*PI
	d 4*cos(angle), 4*sin(angle)
end
at :m do
	ta 0; b 2
	ta 2; b 5/3
	ta 11/3; b 1/3

	b 2/3
	ta 4+2/3; b 1/3
	ta 4+1; b 2/3
	ta 4+5/3; b 1
	ta 4+8/3; b 1
	ta 4+11/3; b 1/3

	b 2/3
	ta 2/3; b 1
	ta 5/3; b 1
	ta 8/3; b 1/3
	ta 3; b 2/3
	ta 11/3; b 1/3

	b 2/3
	ta 4+2/3; b 1/3
	ta 4+1; b 2/3
	ta 4+5/3; b 1/3
	ta 4+2; b 2/3
	ta 4+8/3; b 1/3
	ta 4+3; b 2/3
	ta 4+11/3; b 1/3

	8.times do |i|
		(i%2).zero? ? ta(i*2) : da(i*2); b 1/3
		da i*2+2/3 if i == 6; b 1/3
		da i*2+4/3; b 1/3
	end

	6.times do |i|
		i.zero? ? ta(i*2) : da(i*2); b 1/3
		da i*2+2/3; b 1/3
		da i*2+4/3; b 1/3
	end
end

tp_chain -16, 0, relative_beat: 1 do
	12.times do |i|
		x, y = 4-(1-i/12)**2*8, 0
		i.zero? ? f(x, y, :r) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1 do
	f 3, 2, :ur; b 2/3
	f -3, 2, :ul; b 1/3
end
tp_chain -16, 0, relative_beat: 1 do
	12.times do |i|
		x, y = 4-(1-i/12)**2*8, 0
		i.zero? ? t(x, y) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f -3, -2, :dl; b 2/3
	f 3, -2, :dr; b 1/3
end

tp_chain -16, 0, relative_beat: 1 do
	12.times do |i|
		x, y = 4-(1-i/12)**2*8, 0
		i.zero? ? f(x, y, :r) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1 do
	t 3, 2; b 1/3
	t 0, 2; b 1/3
	t -3, 2; b 1/3
end
tp_chain -16, 0, relative_beat: 1, preserve_beat: false do
	12.times do |i|
		x, y = 5-(1-i/12)**2*10, 0
		bg_note x/2-11/2, y; bg_note x/2+11/2, y
		i.zero? ? t(x, y) : d(x, y); b 1/12
	end
end
b 2/3
tp_drop 0, 8, 1 do
	f 0, -2, :d; b 2/3
end
tp_drop -8, 0, 1 do
	t 5, 2; b 1/3
	t 5, -2; b 1/3
end

tp_chain 18, 0, relative_beat: 1 do
	12.times do |i|
		x, y = 3*(i**2/16-i/2)-1, 0
		bg_note -6+i, 0, 1-i/12
		i.zero? ? f(x, y, :l) : d(x, y); b 1/12
	end
end
group preserve_beat: false do
	7.times do |i|
		bg_note 7, 3-i, 1-i/6; b 1/6
	end
end
tp_drop 0, -8, 1 do
	t 7, 3; b 2/3
	f 7, 3, :d; b 1/3
end
tp_drop 0, 8, 1 do
	3.times { t 7, -3; b 1/3 }
end
tp_drop 0, -16, 1 do
	bg_note 4, 0, 1/3; t 4, 0; b 1/3
	bg_note 0, 0, 1/3; t 0, 0; b 1/3
	bg_note -4, 0, 1/3; t -4, 0; b 1/3
end

tp_drop 3, 0, 0.5, relative: false, preserve_beat: false do
	2.times do
		4.times do |i|
			bg_note 3+i/4, -i, 1/3
		end
		f 4, -4, :dr; b 1
	end
end
notes = tp_chain -1, 0, 0.5, relative: false do
	4.times do |i|
		bg_note -3-i*sqrt(17)/4, 0, 1/3
	end
	8.times do |i|
		angle = PI-(1-(1-i/8)**2)*atan(4)
		r = sqrt(17)
		x, y = -3+r*cos(angle), r*sin(angle)
		i.zero? ? h(x, y, 1/3) : d(x, y); b 1/12
	end
	b 1/3
end
transform duplicate notes do
	translate 3, 0
	rotate atan 4
	vertical_flip
	translate -3, 0
	beat_translate 1
end
b 1
tp_drop 0, -3, 0.5, relative: false do
	6.times do |i|
		angle = i%3*PI/5
		x, y = -(-1)**(i/3).floor*(4*cos(angle)+1), 4*sin(angle)-3
		i == 2 ? f(x, y, :ul) : t(x, y); b 1/3
	end
end

tp_chain 8, 8, 1 do
	f 7, 0, :r
end
tp_chain -8, 8, 1 do
	36.times do |i|
		angle = PI+i/12*PI
		x, y = 6*cos(angle), i/12*sin(angle)
		case i
		when 0 then h x, y, 2/3
		when 24 then t x, y
		when 12...24 then tp_chain(0, 8, 1) { d x, y }
		else d x, y
		end
		b 1/12
	end
end
tp_drop 0, -16, 1 do
	bg_note 4, 0, 1/3; t 4, 0; b 1/3
	bg_note 0, 0, 1/3; t 0, 0; b 1/3
	bg_note -4, 0, 1/3; t -4, 0; b 1/3
end

tp_drop 0, 8, 1, preserve_beat: false do
	f 2, -3, :r; b 1
	f 8, -3, :l; b 1
end
tp_chain 8, 0, 1 do
	8.times do |i|
		angle = -PI+(1-(1-i/8)**2)*PI/2
		x, y = 6*cos(angle)-2, 3*sin(angle)+2
		i.zero? ? h(x, y, 1/3) : d(x, y); b 1/12
	end
	b 1/3
end
tp_chain 0, 8, 1 do
	8.times do |i|
		angle = -PI/2-(1-(1-i/8)**2)*PI/2
		x, y = 6*cos(angle)-2, 3*sin(angle)+2
		i.zero? ? h(x, y, 2/3) : d(x, y); b 1/12
	end
	b 1/3
end
tp_drop 0, -5, 0.5, relative: false do
	f 4, -2, :r; b 1/3
	f 3, 0, :l; b 1/3
	f 1, 2, :r
	tp_drop 8, 8, 1 do
		d 1, 2; b 1/3
	end
	f -1, 2, :l; b 1/3
	f -3, 0, :r; b 1/3
	f -4, -2, :l; b 1/3
end

tp_drop 0, 8, 1, preserve_beat: false do
	b 2
	t 4, 4; b 2
	f -8, -3, :l; b 1
	f -6, -2, :l; b 1
	t 5, 3; b 2/3
	f 6, 1, :r; b 3/4
end

square = group preserve_beat: false do
	b 1
	4.times do |i|
		angle = PI/4+i*PI/2
		x0, y0 = sqrt(2)*2*cos(angle), sqrt(2)*2*sin(angle)
		dx, dy = cos(angle+3*PI/4), sin(angle+3*PI/4)
		4.times do |j|
			bg_note x0+j*dx, y0+j*dy
		end
	end
end
transform duplicate square do
	translate -3, -2
end
transform duplicate square do
	translate -3, -2
	beat_translate 2
end
transform duplicate square do
	translate 2, 2
	rotate PI/12
	translate -5, -4
	beat_translate 4
end
transform square do
	translate -2, 2
	rotate -PI/6
	translate -1, -4
	beat_translate 6
end

tp_chain 0, -8, 1 do
	is = 12.times.map { |i| 1-(1-i/12)**2 }
	angles = [
		*is.map { |i| PI/2+i*PI/6 },
		*is.map { |i| 2*PI/3-i*PI/3 },
		*is.map { |i| PI/3+i*(PI/6+PI/4) },
		*is.map { |i| 3*PI/4-i*(PI/4+PI/3) }
	]
	angles.each_with_index do |a, i|
		x, y = 7*cos(a)-3, 4*sin(a)-1
		i.zero? ? f(x, y, :l) : d(x, y); b 1/6
	end

	12.times do |i|
		angle = PI/4-(1-(1-i/12)**2)*PI/4
		x, y = -2+5*sqrt(2)*cos(angle), -4+5*sqrt(2)*sin(angle)
		i.zero? ? f(x, y, :dr) : d(x, y); b 1/12
	end
end
5.times do |i|
	angle = PI/4-PI/4*i/4
	x, y = -2+5*sqrt(2)*cos(angle), -4+5*sqrt(2)*sin(angle)
	bg_note x, y, 2/3
end
tp_drop 0, 8, 1 do
	5.times { |i| bg_note -2+i, -4+i, 2/3 }
	t -2, -4; b 2/3
	1.upto(4) { |i| bg_note -2+i*sqrt(2), -4 }
	t -2, -4; b 1/3
end
tp_drop 8, 0, 1 do
	t 8, -1; b 1/3
	t 6, 1; b 1/3
	t 7, 4; b 1/3
end
tp_drop -8, 0, 0.5 do
	h -4, 3, 1/6; b 1/3
	h -2, 0, 1/6; b 1/3
	h -5, -3, 1/6; b 1/3
end

tp_chain -8, 0, 1 do
	12.times do |i|
		angle = PI/2*(1-i/12)
		bg_note 5*cos(angle)-8, 5*sin(angle)-4
		angle = atan(3/4)*(1-i/12)
		r = 8/3*5
		x, y = r*cos(angle)-12, r*sin(angle)-4
		i.zero? ? f(x, y, :d) : d(x, y); b 1/12
	end
end
tp_drop -4, 5, 0.5, relative: false do
	t -6, 0; b 1/3
	t -5, -2; b 1/3
	t -3, -3; b 1/3
	tp_chain 8, 0, 1 do
		t 7, 1; b 1/3
	end
	t 0, -4; b 1/3
	tp_chain 0, -8, 1 do
		f 5, 4, :r; b 2/3
	end
	t 3, 0; b 1/3
	t 2, 2; b 1/3
end

tp_chain 0, -8, 1 do
	f 1, 4, :l
end
tp_chain 8, 4, relative_beat: 1/2 do
	12.times do |i|
		x, y = 8-16*i/12, -3/PI*sin(PI*i/6)
		i.zero? ? h(x, y, 2/3) : d(x, y); b 1/12
	end
end
9.times do |i|
	x, y = 6-i*3/2, 2/PI*sin(PI*i/4) + (-1)**i
	f x, y, i.even? ? :u : :d; b 1/3
end

tp_drop -8, -8, 1, preserve_beat: false do
	f 2, 3, :r; b 1
	f 7, 4, :r; b 1
end
tp_drop -6, -2, 0.5, relative: false do
	b 2/3
	t -8, 3; b 1/3
	t -6, 4; b 2/3
	t -3, 3; b 1/3
	t -2, 1
end
tp_drop -8, 0, 1, preserve_beat: false do
	6.times do |i|
		angle = PI/3-i*PI/3
		x, y = 3*cos(angle)+4, 3*sin(angle)-1
		i%3==0 ? t(x, y) : d(x, y); b 1/3
	end
end
tp_chain 8, 8, 1 do
	b 2/3
	f -5, -3, :l; b 4/3
end

tp_chain 8, 0, 1, preserve_beat: false do
	(14*3).times do |i|
		angle = PI+i/12*PI
		x, y = 4*cos(angle), 4*sin(angle)
		case i
		when 0, 12, 24 then f x, y, angle+PI/2
		when 7, 10, 7+12, 10+12 then nil
		else d x, y
		end
		b 1/3
	end
	mark :m
end
turntable 2
notes = tp_chain 12, -6, relative_beat: 2 do
	12.times do |i|
		x, y = 6-12*i/12, 6/PI*sin(PI*i/12)
		i.zero? ? h(x, y, 2) : d(x, y); b 1/6
	end
	b 2
end

turntable 2
transform duplicate notes do
	rotate PI
	beat_translate 4
end
b 4

turntable 6
tp_chain 16, -8, relative_beat: 2 do
	36.times do |i|
		prog = 1-(1-i/36)**2
		x, y = 8-16*prog, 9/PI*sin(PI*prog)
		i.zero? ? h(x, y, 6) : d(x, y); b 1/6
	end
end
at(:m) { f 0, 4, :d }
tp_drop 0, 8, 1 do
	b 2/3
	t 2, 0; b 1/3
	t -2, 0; b 1
end

tp_chain 0, 9, relative_beat: 1 do
	12.times do |i|
		bg_note 0, -4+i/2, 1-i/12 if i.even?
		x, y = 0, 3*(i**2/32-i/4)-5/2
		i.zero? ? f(x, y, :d) : d(x, y); b 1/12
	end
	t 0, 2; b 1/6
	d 0, 3; b 1/6
	d 0, 4; b 2/3
end
diamond_grid 1
tp_drop 0, 8, relative_beat: 1 do
	f -6, 0, :d; f 6, 0, :d; b 1
end
tp_chain 0, 0, 0 do
	15.times do |i|
		angle = PI/2-4*PI*i/15
		r = 4*i/15
		x, y = r*cos(angle), r*sin(angle)
		bg_note x, y, [1, 5-i/3].min
		t x, y; b 1/3
	end
end

tp_chain 0, 16, relative_beat: 1 do
	12.times do |i|
		x, y = 0, 4-(1-(1-i/12)**2)*8
		i.zero? ? f(x, y, :d) : d(x, y); b 1/12
	end
end
tp_drop 8, 0, 1 do
	f 0, 2, :d; b 2/3
	t 0, -2; b 1/3
end
tp_chain 0, 45/8*PI, relative_beat: 1 do
	8.times do |i|
		angle = -PI*5/4*i/8
		x, y = 2*cos(angle)-2, 3*sin(angle)-1
		i.zero? ? t(x, y) : d(x, y); b 1/12
	end
	t -sqrt(2)-2, 3/sqrt(2)-1; b 1/3
	6.times do |i|
		x, y = 1+6*i/6, 4-6*(i/6)**2
		i.zero? ? t(x, y) : d(x, y); b 1/6
	end
	
	f 7, -2, :r; b 1
end
tp_drop 0, 8, 1 do
	f 7, -2, :r; b 1
end
tp_drop 0, 16, 1 do
	bg_note 4, 0, 1/3; t 4, 0; b 1/3
	bg_note 0, 0, 1/3; t 0, 0; b 1/3
	tp_chain -8, 0, 1 do
		f 5, 4, :r
	end
	bg_note -4, 0, 1/3; t -4, 0; b 1/3
end
tp_drop 0, -16, 1 do
	bg_note -4, 0, 1/3; t -4, 0; b 1/3
	bg_note 0, 0, 1/3; t 0, 0; b 1/3
	bg_note 4, 0, 1/3; t 4, 0; b 1/3
end

tp_chain -8, 0, 1 do
	f 8, 1, :r
end
tp_chain -4, 8, relative_beat: 1 do
	12.times do |i|
		x, y = -8+8*i/12, -(1-i/6)**2*4
		i.zero? ? h(x, y, 5/3) : d(x, y); b 1/6
	end
	12.times do |i|
		x, y = 8*i/12, -(1-i/6)**2*4
		i.zero? ? h(x, y, 5/3) : d(x, y); b 1/6
	end

	f 8, -4, :r
end
group preserve_beat: false do
	b 1
	tp_chain 0, -8, 1 do
		f 7, 3, :r; b 5/3
	end
	tp_chain 0, -8, 1 do
		f -7, 3, :l; b 3/4
	end
end if false
tp_chain -8, 8, 1 do
	turntable 1
	4.times do |i|
		angle = PI/4+i*PI/2
		1.upto 4 do |j|
			x, y = j*cos(angle), j*sin(angle)
			bg_note x, y, 1
			[angle+PI/16, angle-PI/16].each do |a|
				x, y = j*cos(a), j*sin(a)
				bg_note x, y, 1
			end if j >= 3
		end
	end
	h 0, 0, 1/3; b 1
	10.times do |i|
		angle = PI/8 + PI/4*i # PI/8*3 + PI/4*i
		x, y = 4*cos(angle), 4*sin(angle)
		case i
		when 9 then f x, y, :r
		when 0 then f x, y, :r; b 1/3
		when 5 then f x, y, :l; b 1/3
		else t x, y; b 1/3
		end
	end
	mark :m
end

tp_chain 0, -8, 1 do
	f 7, 3, :r if false; b 1
end
tp_drop 8, 0, 1 do
	t 0, 0; b 1
	t 5, -2; b 2/3
	t 7, 3; b 1/3
	t 8, 1; b 2/3
end
tp_drop 0, 8, 1 do
	f 5, 0, :r; b 1/3
end
at :m, update_mark: true do
	b 5/3
	t -8, 1; b 1/3
	h -6, -1, 1/3; b 1
	h -2, 0, 1/3; b 1
end

tp_drop 0, 8, 1 do
	f 0, -3, :l; b 1
	f -7, -2, :l; b 1
end
tp_drop -8, 0, 1 do
	t -5, 3; b 1
end
tp_drop 0, 8, 1 do
	f -8, 1, :l; b 2/3
	f -4, -2, :l; b 1/3
end
at :m, update_mark: true do
	d 7, 0; b 1
	h 1, 4, 1/3; b 1
	h 8, 2, 1/3; b 1
	t 6, -2; b 1
end

tp_drop 0, -8, 1 do
	f 4, 4, :r; b 1
end
tp_chain -8, 8, 1 do
	t -1, 1; b 1/3
	t 1, 0; b 1/3
	t -1, -1; b 1/3
end
tp_chain -8, 0, 1 do
	t 3, 3; b 2
end
at :m, update_mark: true do
	d -6, -2; b 2
	t -3, -3; b 2/3
	4.times do |i|
		x, y = -3/2+i, 3-2*i
		t x, y; b 1/3
	end
end

tp_drop 0, 8, 1 do
	f 4, -1, :r; b 1
end
tp_drop 0, -8, 1 do
	f 6, 2, :r; b 1
end
tp_drop 8, 0, 1 do
	t 2, 4; b 2/3
end
tp_drop 0, 8, 1 do
	f 7, 0, :r; b 4/3
end
at :m, update_mark: true do
	b 2/3
	t -4, -2; b 1
	t -7, 1; b 1/3
	h -3, 3, 1/3; b 1
	t 0, 1; b 2/3
	t -3, -1; b 1/3
end

tp_drop 0, -8, 1 do
	f 5, 2, :r; b 1
end
tp_chain 8, 0, 1 do
	t 7, -1; b 2/3
	t 5, -4; b 1/3
end
tp_drop -8, 0, 1 do
	t -6, -1; b 1
end
tp_chain -8, 0, 1 do
	t -8, 2; b 2/3
end
tp_drop 0, 8, 1 do
	f -5, -3, :l; b 1/3
end
at :m, update_mark: true, preserve_beat: true do
	12.times do |i|
		angle = -3*PI/4+PI*2*i/12
		x, y = 4*cos(angle), 4*sin(angle)
		i.zero? ? h(x, y, 1) : d(x, y); b 1/6
	end
end
tp_chain -8, 8, 1 do
	12.times do |i|
		angle = -PI/4+PI*2*i/12
		x, y = 4*cos(angle), 4*sin(angle)
		i.zero? ? h(x, y, 1) : d(x, y); b 1/6
	end
end

note = tp_drop 0, 8, 1 do
	15.times do |i|
		bg_note 7-i, 3-i/14*6
	end
	f 7, 3, :d
end
transform duplicate note do
	horizontal_flip
	beat_translate 1
end
tp_chain 14, 6, 1 do
	d -7, -3; b 1
end
tp_chain -14, 6, 1 do
	h 7, -3, 1/3; b 1
end
tp_chain -7, 6, 0.5 do
	h 0, 0, 1/3
	tp_chain 7, 6, 0.5 do
		d 0, 0; b 1
	end
	t 4, 0
end
tp_drop 0, 8, 1 do
	f -4, 0, :l; b 2/3
end

group preserve_beat: false do
	n = 93
	n.times do |i|
		start = ((1-(1-i/n)**2)*n).floor / 3
		angle = PI/4*(1-i/n)
		x0, y0 = [[-8+16*rand, 4], [8,-4+8*rand]].sample
		speed = 1/2+3/2*i/93
		group preserve_beat: false do
			b start
			(n-start*3).to_i.times do |j|
				x, y = x0-j*speed*cos(angle), y0-j*speed*sin(angle)
				break if x.abs > 8 || y.abs > 4
				bg_note x, y; b 1/3
			end
		end
	end
end

tp_drop -12, 12, 1 do
	kicks = [
		1/3,
		8/3, 4/3,
		1, 5/3, 4/3,
		11/3, 1/3,
		1, 2, 2/3, 1/3
	]
	kicks = kicks.size.times.map { kicks[..._1].sum }
	cur = 0
	4.times do |i|
		n = 11
		angle = PI/3 - PI/4*i/3
		scale = [8/cos(angle), 4/sin(angle)].min
		x0, y0 = scale*cos(angle), scale*sin(angle)
		dx, dy = x0*2/(n-1), y0*2/(n-1)
		n.times do |j|
			x, y = x0-j*dx, y0-j*dy
			if kicks.include? cur
				f x, y, j.even? ? :dr : :ul
			else
				t x, y
			end
			if i == 3 && (1..3).include?(j)
				tp_none { d x, y }
			end
			b 1/3
			cur += 1/3
		end
		b 1/3
		cur += 1/3
	end
end

(-1...24).each_with_index do |i, j|
	x, y = (-6+i%6*2)*(1+i/72), -4+(1-j/25)**2*8
	x = -x if (i/6).floor.even?
	tp_chain 0, -8+i/4, 0.5 do
		if i%6==0 || i==-1
			f x, y, x < 0 || i==-1 ? :l : :r
		else
			t x, y
		end
		b 1/3
	end
end

4.times do |i|
	x0, y0 = 8-i*2, -4+i*4/3
	notes = group do
		tp_drop 0, 8, 1 do
			t x0, y0
		end
		3.times do |j|
			break if i == 3 && j == 1
			tp_drop -8, 0, 1 do
				t -x0, y0+j*2; b 1/3
			end
		end
	end
	transform(notes) { horizontal_flip } if i.odd?
end
notes = group do
	bg_note 0, 0, 4+2/3
	tp_chain 0, 0, 0, preserve_beat: false do
		d 0, 0; b 1/3
		mark :l
	end
	tp_chain 0, 0, 0 do
		t 0, 0; b 1/3
		mark :r
	end
end
b 1/3

[
	[1,1], [2,2], [3,3], [4,2], [5,1],
	*5.times.map { |i| [6-i*6/5, -i*6/5] }
].each_with_index do |(x, y), i|
	at(:l, update_mark: true) { t -x, y; bg_note -x, y, 4+1/3-i/3; b 1/3 }
	at(:r ,update_mark: true) { t x, y; bg_note x, y, 4+1/3-i/3; b 1/3 }
end
at(:l) { d 0, -6 }
at(:r) { t 0, -6; bg_note 0, -6, 1 }
transform notes do
	translate 0, 3/2
	scale 4/5
end
b 4

h 0, 0, 1; b 1
tp_chain 0, 24, relative_beat: 1 do
	4.times do |i|
		x, y = 0, 4-i*2
		i.zero? ? f(x, y, :d) : d(x, y); b 1/12
	end
end
b 2/3
tp_chain 8, 0, 1 do
	t -7, -3; b 2/3
end
tp_chain -8, 0, 1 do
	t 5, 3; b 1/3
	t 7, 2; b 2/3
end
tp_chain -8, 0, 1 do
	t -4, 1; b 1/3

	h -6, 0, 1/3
end
tp_drop 8, 0, 1 do
	h 2, 0, 1/3; b 1
	h 4, -3, 1/3
end
tp_drop -8, 0, 1 do
	h -7, -3, 1/3; b 1
end
tp_chain 0, -8, 1 do
	t -2, -4; b 1/3
	t 1, -3; b 1/3
	t -1, -2; b 1/3
	t 3, 0; b 1/3
	t 0, 1; b 1/3
	t 4, 2; b 1/3
end

tp_drop 0, -8, 1 do
	h -3, 3, 3; b 1
end
tp_chain 0, 8, 1 do
	t 6, 1; b 2/3
	t 8, -1; b 1/3
	t 6, -2; b 2/3
	t 0, -3; b 1/3
	t 2, -2; b 2/3
	t 3, 1; b 1/3
end

notes = tp_chain 0, 8, 1 do
	6.times do |i|
		angle = PI+i/6*3*PI/4
		x, y = 5*cos(angle), 3*sin(angle)
		i.zero? ? h(x, y, 2/3) : d(x, y); b 1/6
	end
end
transform duplicate notes do
	rotate PI
	beat_translate 1
end
b 1
tp_chain 0, 8, 1 do
	h -6, 3, 1/6; b 1/3
	h 0, 1, 1/6; b 1/3
	t -5, 0; b 1/3
	h 2, -1, 1/6; b 1/3
	h -3, -2, 1/6; b 1/3
	h 4, -3, 1/6; b 1/3

	h 0, -4, 3; b 1
end
tp_chain 0, 8, 1 do
	t 6, -1; b 1
	t 6, 2; b 2/3
	t 0, 3; b 1/3
	t 2, 2; b 2/3
	t 3, -1; b 1/3

	h 5, -2, 1/3
end
tp_drop -8, 0, 1 do
	h -3, -3, 1/3; b 1
	h -5, 0, 1/3
end
tp_drop 8, 0, 1 do
	h 8, 2, 1/3; b 1
end
6.times do |i|
	x, y = -2*(-1)**i, 3-i
	tp_chain -x*4, 0, 1 do
		i==2 ? t(x, y) : f(x, y, i.even? ? :l : :r); b 1/3
	end
end

tp_drop 0, 8, 1 do
	h -4, -4, 1; b 1
	t 0, -4; b 2/3
end
tp_chain -8, 0, 1 do
	h -3, -1, 4/3; b 1/3
end
tp_chain 8, 0, 1 do
	h 4, -2, 1; b 2
end

tp_chain 0, 8, 1 do
	h 0, 2, 2; b 1
end
tp_chain 8, 0, 1 do
	t 5, 3; b 1
end
tp_chain 0, 8, 1 do
	h 6, 0, 2; b 2/3
end
tp_chain -8, 0, 1 do
	t -4, 2; b 4/3
end

tp_chain 0, -8, 1 do
	h 0, 4, 8; b 2
end
tp_chain 8, 0, 1 do
	f 6, 2, :r; b 2
end

tp_chain 0, 8, 1 do
	t 5, 3; b 1
	t 2, 0; b 1
	f 7, -1, :r; b 2/3
	t 4, -3; b 4/3
end

tp_chain 0, 8, 1 do
	h 0, -4, 3; b 2
end
tp_chain 8, 0, 1 do
	f -6, 0, :l; b 2
end

tp_drop 0, 8, 1, preserve_beat: false do
	h 3, -4, 8
	4.times do
		b 2/3
		d 3, -4; b 1/3
		d 3, -4
	end
end
tp_chain 0, 8, 1 do
	t -5, -3; b 1
	t -2, 0; b 1
	f -7, 1, :l; b 2/3
	t -4, 3; b 4/3

	t -2, 0; b 2
	f 1, 1, :l; b 2
end

tp_chain 0, -8, 1 do
	h 0, 4, 4; b 2
end
tp_chain 8, 0, 1 do
	f 6, 0, :r; b 2
end

tp_chain 0, 8, 1 do
	h 0, -3, 3; b 1
end
tp_chain -8, 0, 1 do
	t -2, 1; b 1
	f -3, -1, :l; b 2
end

tp_chain 8, 0, 1 do
	t 1, 3; b 1
	t 2, 1; b 1
	f 3, -1, :r; b 2/3
	t 4, -3; b 4/3
end

group preserve_beat: false do
	24.times do |i|
		x, y = 4*cos(2*PI*i/24), 4*sin(2*PI*i/24)
		bg_note x, y, 64+8-9/16
	end
	(32+4).times do |i|
		angle1 = PI/2-2*PI*i/30
		angle2 = -2*PI/12*i/30
		[angle1, angle2].product 5.times.to_a do |a, j|
			x, y = j*cos(a), j*sin(a)
			bg_note x, y
		end
		b 2
		b 1/16 if i==35
	end
end

notes = tp_chain 0, -8, 1 do
	4.times do |i|
		dx, dy = 16/8, 8/7
		x0, y0 = 8-dx*i*2, -4+dy*i*2
		h x0, y0, 2; b 2/3
		d x0-dx, y0; b 1/3
		d x0-dx, y0+dy; b 2/3
		d x0-dx*2, y0+dy; b 1/3+2
	end
end
b -8
bg_notes = group do
	bg_note 8, 4; b 4
	bg_note 8, 2; b 2
	bg_note 8, 0; b 2
	bg_note 8, -2
end

transform duplicate notes do
	horizontal_flip
	beat_translate 16
end
b 14
tp_drop 0, 8, 1 do
	h 0, 0, 2; b 2/3
	d 0, 0; b 1/3
	d 0, 0; b 2/3
	d 0, 0; b 1/3
end

transform duplicate bg_notes do
	horizontal_flip
	beat_translate 32
end
8.times do |i|
	x, y = (4+4*i/8)*(-1)**i, -4
	tp_drop 0, 8-6*i/8, 1 do
		h x, y, 2; b 2/3
		d x, y; b 1/3
		d x, y; b 2/3
		d x, y; b 1/3 + 2
	end
end

b 50; t 0, 0

transform(@events) { scale 12.5 }

end
