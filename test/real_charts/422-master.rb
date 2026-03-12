Integer.alias_method :/, :quo
include Math

Sunniesnow::Charter.open 'master' do

title '４２２'
artist 'flicknote'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '13'

offset 1.0
bpm 188

#==========
# Intro
#==========
tp_drop 0, 12, 1 do
	tp_chain do
		t -4, -4; b 1/12
		d -2, -3; b 1/12
		d 0, -2; b 5/6
	end
	t 6, -4; b 1
	t 2, -4; b 1
	t -2, -4; b 1

	t -6, -4; b 3
	t 0, -4; b 1/2
	t -3, -4; b 1/2
	
	tp_chain do
		t 2, -4; b 1/12
		d 4, -3; b 1/12
		d 6, -2; b 5/6
	end
	t -7, -4; b 1
	t -1, -4; b 1
	t -7, -4; b 1

	t 3, -4; b 2
	t 8, -4; t -7, -4; b 2-1/8
	tp_chain do
		t -2, -4; b 1/8-1/12
		d -4, -3; b 1/12

		d -6, -2
	end
	t 5, -4; b 1
end
t -5, -3; t 3, -2; b 1
t -2, 0; t 4, 1; b 1
t -3, 3; b 1/16
t 6, 3; b 1-1/16

t -7, 4; b 1/24
t 8, 4; b 1-1/24
t -8, 1; b 1
t -4, 0; t 4, 1; b 1
t 0, -2; b 1

def chain x0, y0, angle, n = 4, triplet = false
	dr = triplet ? 1 : sqrt(2)
	t x0, y0; bg_note x0, y0
	tp_none do
		n.times do |i|
			x = x0 + i*dr*cos(angle)
			y = y0 + i*dr*sin(angle)
			d x, y; bg_note x, y; b triplet ? 1/6 : 1/4
		end
	end
end
grid 8
tp_drop 0, 8, 1 do
	t -6, -4; chain 4, -4, PI/2
	chain -4, -3, PI/2
	chain 6, -2, PI/2
	chain -6, -1, PI/2

	chain 8, 0, 3*PI/4
	chain -8, 1, -PI/4
	chain 4, 0, 3*PI/4, 2
	chain -4, 2, -PI/4, 2
	chain 2, -2, 3*PI/4, 3, true
	chain -2, 4, -PI/4, 3, true
end

#==========
# Theme 1
#==========
tp_chain 0, 8, 1 do
	([1/4]*4 + [1/6]*4 + [1/12, 1/12, 1/6,0]).each_with_index do |delta_beat, i|
		prog = i/11
		x, y = -3 + (prog**2 + prog)/2*11, -3 + prog*7
		i.zero? ? f(x, y, :ur) : d(x, y); b delta_beat
	end
end
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
def verse1; group do
tp_chain 0, -8, 1 do
	([1/4]*8 + [0]).each_with_index do |delta_beat, i|
		next b delta_beat if i == 1
		prog = i/8
		x, y = 2 - prog*9, 4 - prog**2 * 8
		i.zero? ? f(x, y, :l) : d(x, y); b delta_beat
	end
end
b -1/2
tp_chain 8, 0, 1 do
	t 1, -1; b 1/2

	f 3, 1, :r; b 1/2
end
6.times do |i|
	tp_chain -8*(-1)**i, 0, 1 do
		t 0+i/6*3 - (-1)**i*3, -3+i/6*6; b 1/4
	end
end
tp_chain -8, 0, 1 do
	([1/4]*8 + [0]).each_with_index do |delta_beat, i|
		prog = i/8
		x, y = (prog - 2*prog**2) * 7, 3 - prog*7
		i.zero? ? f(x, y, :dr) : d(x, y); b delta_beat
	end
end

tp_chain 0, 8, 1 do
	([1/4]*4 + [1/6]*4 + [1/12, 1/12, 1/6,0]).each_with_index do |delta_beat, i|
		prog = i/11
		x, y = 3 - (prog**2 + prog)/2*11, -3 + prog*7
		i.zero? ? f(x, y, :ul) : d(x, y); b delta_beat
	end
end
tp_chain 8, 0, 1 do
	([1/4]*8 + [0]).each_with_index do |delta_beat, i|
		next b delta_beat if i == 1
		prog = i/8
		x, y = -1 - prog**2*6, 4 - prog*8
		i.zero? ? f(x, y, :d) : d(x, y); b delta_beat
	end
end
b -1/2
tp_chain -8, 0, 1 do
	t 3, 2; b 1/2

	8.times do |i|
		prog = i/8
		x, y = 5+4*cos(PI/2-prog*PI) - prog*6, 4*sin(PI/2-prog*PI)
		i.zero? ? f(x, y, :dr) : d(x, y); b 1/4
	end
end
8.times do |i|
	tp_chain -8*(-1)**i, 0, 1 do
		t -2-i/8*4 - (-1)**i*2, -4+i/8*8; b 1/4
	end
end
end; end
verse1

tp_chain -8, 0, 1 do
	([1/4]*4 + [1/6]*4 + [1/12, 1/12, 1/6,0]).each_with_index do |delta_beat, i|
		prog = i/11
		x, y = -8 + (prog**2 + prog)/2*11, 4 - prog*7
		i.zero? ? f(x, y, :dr) : d(x, y); b delta_beat
	end
end
tp_chain 0, 8, 1 do
	b -1
	t 2, 4; b 1
	([1/4]*8 + [0]).each_with_index do |delta_beat, i|
		prog = i/8
		x, y = 7-prog**2*5, 3 - 6*(3*prog-2*prog**2)
		i.zero? ? f(x, y, :d) : d(x, y); b delta_beat
	end
end
b -1
tp_drop 0, 8, 1 do
	t -8, -3; b 1/2
	t -6, -4; b 1/2
end

def chain x0, y0, right = true
	tp_chain right ? -8 : 8, 0, 1 do
		4.times do |i|
			x, y = x0 + (i+(i/4)**2*2) * (right ? 1 : -1), y0 + i
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
	end
end
chain -4, -3
chain 2, -4
chain -3, 1
chain 3, 0

diamond_grid 8
2.times do |i|
	8.times do |j|
		x = [6,2,3,-1][i] - j/8*3 - (j/8)**2*2 - 2*(-1)**j
		y = (4-j)*(i<2 ? 1 : -1) + [0,-1/2,0,1/2][i]
		tp_chain -8*(-1)**j, 0, 1 do
			t x, y; b 1/4
		end
	end
end

notes = group do
	notes1 = tp_drop -8, 0, 1 do
		t -2, -4; b 1/6
		d -2, -8/3; b 1/6
		d -2, -4/3; b 1/6
	end
	transform(duplicate notes1) do
		translate 0, 4/3
		horizontal_flip
		beat_translate 1/2
	end
	b 1/2
	6.times do |i|
		tp_drop -8*(-1)**i, 0, 1 do
			t -(-1)**i, i/6*4; b 1/6
		end
	end
end
transform duplicate notes do
	compound_linear 1, -0.5, 0, 1
	vertical_flip
	translate -5, 0
	beat_translate 2
end
transform notes do
	compound_linear 1, -0.5, 0, 1
	translate -2, 0
end
b 2

tp_chain 0, 8, 1 do
	([1/4]*4 + [1/6]*4 + [1/12, 1/12, 1/6,0]).each_with_index do |delta_beat, i|
		prog = i/11
		x, y = -8 + prog*14, -4+prog**2*8
		i.zero? ? f(x, y, :r) : d(x, y); b delta_beat
	end
end
transform(verse1) { horizontal_flip }

group preserve_beat: false do
	hexagon 1/2; b 4
	hexagon 1/2; b 4
	hexagon 1/2; b 3/2
	hexagon 1/2; b 5/2
	turntable 1/2; b 2
	turntable 1/2; b 2
end
def chain1 x0, y0, right = true
	tp_chain right ? -8 : 8, 0, 1 do
		5.times do |i|
			x, y = x0 + (i+(i/4)**2*2) * (right ? 1 : -1), y0 + i
			i%4==0 ? t(x, y) : d(x, y); b 1/4 if i < 4
		end
	end
end
notes = group do
	chain1 -4, -4
	chain1 2, -3
	chain1 -3, -1
	chain1 3, 0
end
transform(notes) { rotate PI; translate 4, 0 }

notes = group do
	chain1 -4, -4
	chain1 2, -3
	chain1 -3, -2
	chain 3, -1
end
transform(notes) { horizontal_flip; translate 2, 0 }

def grapes x0, y0, down = true, triplet = false
	y = y0
	(triplet ? [1/4]*2+[1/6]*3 : [1/4]*4).each_with_index do |delta_beat, i|
		tp_chain 8*(-1)**i, 0, 1 do
			t x0+(1-i%2)*6, y; b delta_beat
			y += (down ? -1 : 1)*delta_beat*4
		end
	end
end
grapes -8, 3
grapes -5, 0
grapes -2, -4, false
grapes 1, 0, false, true

notes = group do
	tp_drop 0, -8, 1 do
		6.times do |i|
			prog = i/6
			x, y = 1-5*prog-2*prog**2, 4-prog**2*5
			i.zero? ? f(x, y, :l) : d(x, y); b 1/6
		end
	end
	4.times do |i|
		tp_chain 8*(-1)**i, 0, 1 do
			t -2+(-1)**i, -i; b 1/4
		end
	end
end
transform(duplicate notes) do
	rotate PI
	beat_translate 2
end
b 2

#==========
# Interlude 1
#==========
grid 30
tp_drop 8, -8, 1, preserve_beat: false do
	16.times do |i|
		t 4, 4; b 1
	end
end
t 1, 4; b 1/16
d -1, 3; b 1/6-1/16
d -3, 2; b 5/6
t -6, 0; b 1/2
t -8, -1; b 1/2
d -6, -3; b 1/2
t -4, -4; b 1/2
d -2, -3; b 1/2
t 0, -2; b 1/2

d 2, -3; b 1/2
t 4, -4; b 1
t 2, -1; b 1
t -1, 0; b 1/2
d -3, -1; b 1/2
d -4, 1; b 1/4
d -5, 2; b 1/4

f -6, 3, :l; b 1/2
d -8, 2; b 1/2
t -7, 0; b 1/2
t -5, -1; b 1
t -2, 1; b 1/2
d 0, 2; b 1/2
t 2, 1; b 1/2

d 1, -1; b 1/2
t 2, -3; b 1/2
t 0, -4; b 1/2
t -1, -2; b 1/2
t -3, -1; b 1/2
t -5, 0; b 1/2
t -7, -1; b 1/2
t -6, -3; b 1/2

tp_drop -8, 8, 1, preserve_beat: false do
	16.times do |i|
		t -4, -4; b i==14 ? 1/2 : 1
	end
end
t 4, 4; b 1/2
d 2, 3; b 1/2
t 0, 2; b 1/2
t -1, 0; b 1
t 2, -3; b 1
t 6, -4; b 1/2

b 1/2
t 8, -1; b 1/4
d 7, 0; b 1/4
d 6, 1; b 1/2
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
tp_drop 8, 8, 1, preserve_beat: false do
	16.times do |i|
		t 4, -4; b 1
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
t -7, 2; b 1/2
def chain x0, y0, angle, head = :tap
	4.times do |i|
		x, y = x0 + i*sqrt(2)*cos(angle), y0 + i*sqrt(2)*sin(angle)
		if i.zero?
			case head
			when :tap then t(x, y)
			when :drag then d(x, y)
			when :flick then f(x, y, angle)
			end
		else
			d(x, y)
		end
		b 1/4
	end
end
chain -8, 0, -PI/4
chain -4, -4, PI/4
chain 0, 0, 3*PI/4

tp_drop -8, -8, 1, preserve_beat: false do
	16.times do |i|
		t -4, 4; b 1
	end
end
4.times do |i|
	notes = group do
		#cur = 0
		#([1/2]*2+[1/4]*4).each_with_index do |delta_beat, j|
		#	x, y = 2+cur, -4+cur*3
		#	j.zero? ? t(x, y) : d(x, y); b delta_beat
		#	cur += delta_beat
		#end
		t 2, -4; b 1/2
		d 3, -3; b 1/2
		d 4, -2; b 1/4
		d 4, -1; b 1/4
		d 4, 0; b 1/4
		d 4, 1; b 1/4
	end
	transform notes do
		rotate PI/2*i
		translate 2, 0
	end
end

chain 4, -4, PI/4, :flick
chain 8, 0, 3*PI/4, :drag
chain 4, 4, -3*PI/4, :drag
chain 0, 0, -PI/4, :drag

t 4, -4; b 3/4
t 6, 0; b 3/4
t 1, -1; b 1/2
t 0, -3; b 1
t 4, -4; b 1

#==========
# Interlude 2
#==========
# piano: horizontal tip points
# kick: vertical tip points
group preserve_beat: false do
	b 2
	bg_note -3, 1, 14, 'I'; b 2
	bg_note -1, 1, 12, 'do'; b 1
	bg_note 1, 1, 11, "n't"; b 1
	bg_note 3, 1, 10, 'know'; b 2
	bg_note -2, -1, 8, 'what'; b 1
	bg_note 0, -1, 7, 'to'; b 1
	bg_note 2, -1, 6, 'say'
end
tp_chain -8, 0, 1 do
	f -6, -2, :l
end
tp_drop 0, 8, 1 do
	f 6, 2, :ur; b 3/2
	t 8, -2; b 5/2
end

tp_drop 0, -8, 1 do
	b 3/2
	t -6, 2; b 3/2
	t -8, -2; b 1
end

tp_chain -8, 0, 1, preserve_beat: false do
	8.times do |i|
		angle = -PI + i/8*PI
		x, y = 6*cos(angle), 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	tp_chain 8, 0, 1 do
		cur = 0
		([1/2]+[1/4]*2+[1/6]*6).each_with_index do |delta_beat, i|
			angle = cur/2*PI
			x, y = 6*cos(angle), 4*sin(angle)
			i.zero? ? t(x, y) : d(x, y); b delta_beat
			cur += delta_beat
		end
	end
end
tp_drop 0, 8, 1 do
	t 6, -2; b 3/2
	t 8, 2; b 5/2
end

tp_chain -8, 0, 1, preserve_beat: false do
	f -6, 0, :l; b 2
	tp_chain 8, 0, 1 do
		f 7, -1, :r; b 2
	end
end
tp_drop 0, -8, 1 do
	b 1
	t -7, 3; b 3/2
	t -8, -2; b 1
	t -5, 1; b 1/2
end

group preserve_beat: false do
	b 2
	bg_note -3, 1, 14, 'I'; b 2
	bg_note -1, 1, 12, 'do'; b 1
	bg_note 1, 1, 11, "n't"; b 1
	bg_note 3, 1, 10, 'know'; b 2
	bg_note -2, -1, 8, 'what'; b 1
	bg_note 0, -1, 7, 'to'; b 1
	bg_note 2, -1, 6, 'think'
end
tp_chain -8, 0, 1 do
	f -7, 3, :l
end
tp_drop 0, -8, 1 do
	f 6, -2, :ur; b 3/2
	t 8, 2; b 5/2
end

tp_drop 0, 8, 1 do
	b 1
	t -6, -2; b 2
	t -8, 2; b 1
end

tp_drop -8, 0, 1, preserve_beat: false do
	t -5, -3; b 2
	f -7, 0, :l; b 2
end
tp_drop 0, -8, 1 do
	t 6, 2; b 3/2
	t 8, -2; b 5/2
end

tp_drop 8, 0, 1, preserve_beat: false do
	f 7, 4, :r; b 2
	f 6, 0, :r; b 2
end
tp_drop 0, 8, 1 do
	b 1/2
	t -6, -2; b 1
	t -8, 2; b 3/2
	t -5, -1; b 1/2
	t -2, 1; b 1/4
	t 0, 0; b 1/4
end

group preserve_beat: false do
	b 2
	bg_note -2, 1, 10, 'What'; b 2
	bg_note 0, 1, 8, 'made'; b 2
	bg_note 2, 1, 6, 'me'; b 2
	bg_note -2, -1, 4, 'feel'; b 1
	bg_note 0, -1, 3, 'this'; b 1
	bg_note 2, -1, 2, 'way'
end
tp_chain -8, 0, 1 do
	f -5, 2, :l
end
tp_drop 0, -8, 1 do
	f 2, -1, :ur; b 3/2
	t 6, 1; b 5/2
end

tp_drop 0, 8, 1 do
	b 1/2
	t -8, -1; b 1/2
	t -6, -2; b 3/2
	t -7, 3; b 3/2
end

tp_chain -8, 0, 1, preserve_beat: false do
	cur = 0
	([1/2]+[1/4]*12+[1/6]*3).each_with_index do |delta_beat, i|
		angle = PI - cur/4*2*PI
		x, y = 6*cos(angle), 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b delta_beat
		cur += delta_beat
	end
end
tp_drop 0, -8, 1 do
	t 6, 1; b 3/2
	t 8, -1; b 5/2
end

tp_drop 8, 0, 1, preserve_beat: false do
	f 7, 2, :r; b 2
	t 6, -3; b 1
	t 5, 0; b 1
end
tp_drop 0, 8, 1 do
	b 1/2
	t -6, 3; b 1
	t -8, -1; b 3/2
	t -5, 1; b 1
end

# piano: vertical tip points
# kick: horizontal tip points
diamond_grid 17
group preserve_beat: false do
	b -2
	bg_note -6, 0, 22, 'What'; b 1
	bg_note -4, 0, 21, 'is'; b 1
	bg_note -2, 0, 20, 'go'; b 4
	bg_note 0, 0, 16, 'ing'; b 4
	bg_note 2, 0, 12, 'on'; b 4
	bg_note 4, 0, 8, 'my'; b 4
	bg_note 6, 0, 4, 'mind'; b 4
end
tp_drop 8, 0, 1, preserve_beat: false do
	t 8, 1; b 1
	t 6, -2; b 1
	t 3, -1; b 1
	t 1, 1; b 1
end
tp_drop 0, 8, 1 do
	f -4, -2, :l; b 5/2
	t -6, -3; b 1/2
	t -4, -4; b 1/2
	t -2, -3; b 1/2
end

tp_drop -8, 0, 1, preserve_beat: false do
	t -3, -1; b 1
	t -4, 2; b 1
	t -6, 0; b 1
	t -5, -3; b 1
end
tp_drop 0, -8, 1 do
	f 4, 2, :r; b 2
	8.times do |i|
		prog = i/8
		angle = -PI/2 - prog*PI
		x, y = 5 + 6*cos(angle) + 3*prog**2, 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tp_drop 8, 0, 1, preserve_beat: false do
	t 8, 4; b 1
	t 8, 1; b 1
	t 8, -2; b 1
	t 6, -4; b 1
end
tp_drop 0, 8, 1 do
	16.times do |i|
		prog = i/16
		x, y = -8+14*(2-sqrt(12*(prog-1/2)**2+1)), -4*cos(prog*3*PI)
		i.zero? ? f(x, y, :r) : d(x, y); b 1/4
	end
end

tp_drop -8, 0, 1, preserve_beat: false do
	t -8, 4; b 1
	t -7, 1; b 1
	t -4, 1; b 1
	t -3, 4; b 1
end
tp_drop 0, -8, 1 do
	f 3, 1, :r; b 1/2
	t 6, 2; b 1/2
	t 8, 4; b 1/2
	10.times do |i|
		prog = i/10
		angle = PI/2 + prog*3*PI/2
		x, y = 4+4*cos(angle), 4*sin(angle) + prog*4
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tp_drop 8, 0, 1, preserve_beat: false do
	t 8, 4; b 1
	t 8, 0; b 1
	t 8, -4; b 1
	t 8, 1; b 1
end
tp_drop 0, 8, 1 do
	([1/4]*8 + [1/6]*12).each_with_index do |delta_beat, i|
		prog = i/20
		x, y = -7*cos(prog*2*PI)-prog, 4*cos(prog*5*PI)
		i.zero? ? f(x, y, :dr) : d(x, y); b delta_beat
	end
end

big_text 4, 'Ohh'
tp_drop 0, -8, 1 do
	t 6, -3
end
tp_drop -8, 0, 1 do
	t -8, -4; b 1
	t -8, 1; b 1
end
tp_drop 0, -8, 1 do
	12.times do |i|
		prog = i/12
		if i.even?
			x, y = -2+10*(1-prog**2), 4-prog*8
		else
			x, y = -8*prog, 4-prog**2*8
		end
		t x, y; b 1/6
	end
end

#==========
# Theme 2
#==========
group preserve_beat: false do
	b 2
	bg_note -2, 3, 12, 'Eve'; b 1
	bg_note 0, 3, 11, 'ry'; b 1
	bg_note 2, 3, 10, 'time'; b 2
	bg_note -3, -3, 8, 'that'; b 1
	bg_note -1, -3, 7, 'I'; b 1
	bg_note 1, -3, 6, 'see'; b 2
	bg_note 3, -3, 4, 'you'; b 2
end
tp_drop 0, 8, 1 do
	6.times do |i|
		prog = i/6
		x, y = -2+prog*10, -4+prog**2*3
		i.zero? ? f(x, y, :r) : d(x, y); b 1/4
	end
	b -1/2
	t -1, -2; b 1/2
	t -4, -1; t 8, -1; b 1/4
	d 7, 0; b 1/4
end
tp_chain -8, 0, 1 do
	t 0, 0; b 1/4
end
tp_chain 8, 0, 1 do
	t 3, 1; b 1/4
end
tp_chain -8, 0, 1 do
	t -1, 2; b 1/4
end
tp_chain 8, 0, 1 do
	t 2, 3; b 1/4
end
tp_drop 0, -8, 1 do
	t -7, 4; t 3, 4; b 1/4
	d -6, 3; b 1/4
	t 4, 1; b 1/6
	d 3, 0; b 1/6
	d 2, -1; b 1/6
end

tp_drop 0, 8, 1 do
	t -8, -2; t 2, -2; b 1/4
	d 3, -3; b 1/4
end
tp_chain -8, 0, 1 do
	t -5, -4; b 1/4
end
tp_chain 8, 0, 1 do
	t -1, -3; b 1/4
end
tp_chain -8, 0, 1 do
	t -4, -2; b 1/4
end
tp_chain 8, 0, 1 do
	t 0, -1; b 1/4
end
tp_drop 0, 8, 1 do
	t -6, 0; t 1, 0; b 1/4
	d -5, 1; b 1/4
end
tp_chain 8, 0, 1 do
	t 4, 1; b 1/4
end
tp_chain -8, 0, 1 do
	t -2, 2; b 1/4
end
tp_chain 8, 0, 1 do
	t 3, 3; b 1/4
end
tp_chain -8, 0, 1 do
	t -3, 4; b 1/4
end
tp_drop 0, -8, 1 do
	t -4, 3; t 6, 3; b 1/4
	d 5, 2; b 1/4
	t 0, 0; b 1/6
	d 1, -1; b 1/6
	d 2, -2; b 1/6
end

tp_drop 0, 8, 1 do
	t 2, -3; t 8, -3; b 1/4
	d 1, -4; b 1/4
end
tp_chain 8, 0, 1 do
	t 5, -2; b 1/4
end
tp_chain -8, 0, 1 do
	t -2, -1; b 1/4
end
tp_chain 8, 0, 1 do
	t 4, 0; b 1/4
end
tp_chain -8, 0, 1 do
	t -3, 1; b 1/4
end
tp_drop 0, -8, 1 do
	t -4, 2; t 6, 2; b 1/4
	d 7, 3; b 1/4
end
tp_chain -8, 0, 1 do
	t -6, 4; b 1/4
end
tp_chain 8, 0, 1 do
	t 1, 3; b 1/4
end
tp_chain -8, 0, 1 do
	t -7, 2; b 1/4
end
tp_chain 8, 0, 1 do
	t 0, 1; b 1/4
end
tp_drop 0, -8, 1 do
	t -5, 0; t 1, 0; b 1/4
	t -4, -1; b 1/4
	t 0, -2; b 1/4
	d 1, -3; b 1/4
end

tp_drop 0, 8, 1 do
	t -4, -4; t 3, -4; b 1/4
	d 4, -3; b 1/4
end
tp_chain -8, 0, 1 do
	t -2, -2; b 1/4
end
tp_chain 8, 0, 1 do
	t 3, -1; b 1/4
end
tp_drop 0, -8, 1 do
	t -3, 0; b 1/6
	d -4, 1; b 1/6
	d -5, 2; b 1/6
	t -5, 3; t 6, 3; b 1/4
	d 5, 4; b 1/4
end
tp_drop 0, 8, 1 do
	t 8, 2
	6.times do |i|
		x, y = 1-i, 2-i
		i.zero? ? t(x, y) : d(x, y); b 1/6
	end
end
tp_chain 8, 0, 1 do
	t 5, -4; b 1/4
end
tp_chain -8, 0, 1 do
	t 0, -3; b 1/4
end
tp_chain 8, 0, 1 do
	t 6, -2; b 1/4
end
tp_chain -8, 0, 1 do
	t 1, -1; b 1/4
end

group preserve_beat: false do
	b 1
	bg_note -3, 3, 11, 'Can'; b 1
	bg_note -1, 3, 10, 'not'; b 1
	bg_note 1, 3, 9, 'pro'; b 1
	bg_note 3, 3, 8, 'cess'; b 2
	bg_note -2, -3, 6, 'that'; b 2
	bg_note 0, -3, 4, 'fee'; b 2
	bg_note 2, -3, 2, 'ling'; b 2
end
tp_drop 0, -8, 1 do
	t 0, 0; t 8, 0; b 1/4
	d -1, 1; b 1/4
end
tp_chain 8, 0, 1 do
	t 3, 1; b 1/4
end
tp_chain -8, 0, 1 do
	t -3, 2; b 1/4
end
tp_drop 0, -8, 1 do
	t 4, 3; b 1/6
	d 5, 2; b 1/6
	d 6, 1; b 1/6
	t -6, 0; t 6, 0; b 1/4
	d 5, -1; b 1/4
end
8.times do |i|
	tp_chain -8*(-1)**i, 0, 1 do
		t 2 - (i/2).floor - 3*(-1)**i, -4 + i
		b 1/4
	end
end

tp_drop 0, -8, 1 do
	t -5, 4; t 3, 4; b 1/4
	d -6, 3; b 1/4
end
tp_chain 8, 0, 1 do
	t 6, 2; b 1/4
end
tp_chain -8, 0, 1 do
	t -1, 1; b 1/4
end
tp_chain 8, 0, 1 do
	t 5, 0; b 1/4
end
tp_chain -8, 0, 1 do
	t -2, -1; b 1/4
end
tp_drop 0, 8, 1 do
	t -3, -2; t 6, -2; b 1/4
	d -4, -3; b 1/4
end
8.times do |i|
	tp_chain 8*(-1)**i, 0, 1 do
		t -3 + (i/2).floor + 4*(-1)**i, -4 + i
		b 1/4
	end
end

tp_drop 0, -8, 1 do
	t -3, 4; t 5, 4; b 1/2
	t -1, 2; t 7, 2; b 1/2
end
tp_drop 0, 8, 1 do
	t -1, -1; t 6, -1; b 1/2
	t -3, -3; t 3, -3; b 1/2
end
6.times do |i|
	prog = i/6
	if i.even?
		tp_chain -8, 0, 1 do
			t -6 - 2*(1-(1-prog)**2), -4 + prog*8
		end
	else
		tp_chain 8, 0, 1 do
			t 1-5*(1-(1-prog)**2), -4 + prog*8
		end
	end
	b 1/4
end
tp_drop 0, -8, 1 do
	t -8, 4; t -4, 4; b 1/2
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
def pattern triplet = false; group do
	tp_drop 8, 8, 1 do
		t -8, 4
	end
	tp_drop -8, -8, 1 do
		t 4, -4; b 1/2
	end
	tp_chain 0, 8, 1 do
		t 3, 2; b 1/4
		t 1, 2; b 1/4
		t 1, 0; b 1/4
		t -1, 0; b 1/4
		if triplet
			t -1, -2; b 1/6
			d 1, -2; b 1/6
			d 3, -2; b 1/6
		else
			t -1, -2; b 1/4
			t -3, -2; b 1/4
		end
	end
	tp_drop -8, 0, 1, preserve_beat: false do
		t -4, -4; b 1/4
		d -5, -3; b 1/4
		t -6, 0; b 1/2
		t -4, 4
	end
	tp_drop 8, 0, 1 do
		t 4, -4; b 1/2
		t 6, 0; b 1/4
		d 5, 1; b 1/4
		t 4, 4; b 1/4
	end
	tp_drop -8, 8, 1 do
		d 2, 2; b 1/4
		d 0, 0; b 1/4
		d -2, -2; b 1/4
	end
end; end
pattern

transform(pattern true) { horizontal_flip }

tp_drop -8, -8, 1, preserve_beat: false do
	t -8, 4; b 1/2
	t -6, 2; b 1/2
	t -4, 0; b 1/2
	t -2, -2; b 1/2
end
tp_chain 8, 8, 1 do
	t 4, -4; b 1/4
	t 5, -3; b 1/2
	t 5, -1; b 1/2
	t 5, 1; b 1/2
	t 5, 3; b 1/4
end
[
	[4, 4],
	[3, 3],
	[2, 0],
	[3, -1],
	[4, -4],
	[5, -3],
	[6, 0],
	[5, 1],
	[4, 4],
].each_with_index do |(x, y), i|
	if i.even?
		tp_drop(8, 0, 1) { t x, y }
		tp_drop(-8, 0, 1) { t -x, -y; b 1/4 unless i==8 }
	else
		s = (-1) ** (i/2).floor
		tp_drop(8*s, 0, 1) { d x*s, y*s; b 1/4 }
	end
end

b 1/4
tp_drop -8, 8, 1 do
	d 2, 2; b 1/4
	d 0, 0; b 1/4
	d -2, -2; b 1/4
end
tp_drop 0, 8, 1 do
	t -2, 2; b 1/6
	d -4, 2; b 1/6
	d -6, 2; b 1/6
end
tp_chain -8, 0, 1 do
	t -6, 0
end
tp_chain 8, 0, 1 do
	t 6, 0; b 3/4
end
tp_chain 0, 8, 1 do
	t 3, 2; b 1/4
	t 1, 2; b 1/4
	t 1, 0; b 1/4
end
tp_drop 0, -8, 1 do
	t -1, 0; b 1/6
	d -3, 0; b 1/6
	d -5, 0; b 1/6
	t -3, -2; b 1/6
	d -1, -2; b 1/6
	d 1, -2; b 1/6
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
tp_drop -8, -8, 1, preserve_beat: false do
	t -8, 4; b 1/4
	d -7, 3; b 1/4
end
tp_drop 8, 8, 1 do
	t 3, -2; b 1/2
end
notes = group do
	t 1.1, -45.4; b 1/4
	t -89.9, -36.9; b 1/4
	t -16.2, -17.7; b 1/4
	t -97.8, -4.2; b 1/4
	t -28.3, 9.7; b 1/4
	t -88.0, 21.3; b 1/4
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
		d 16.2, 19.5; b 1/3
		d -3.9, -3.2; b 1/3
		d -25.7, -18.4; b 1/6
		f 20.0, -28.7, :r; b 3/2
	end
	tp_chain 100, 0, 1 do
		t 45.3, 33.6; b 1/2
		d 75.4, 38.4; b 1/3
		d 62.2, 1.2; b 1/3
		d 34.8, -19.3; b 1/3
		f 80.8, -29.4, :r; b 3/2
	end
end
transform notes do
	scale 1/12.5
end

grid 15/2
tp_drop 0, 14, 1 do
	t 3, -4; t 7, -4; b 1/4
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
	t -1, -4; t 1, -4; b 1/2
end
f -3, -2, :ul; f 3, -2, :ur; b 3/2

#==========
# Finale
#==========
finale1 = group do
tp_drop -8, 8, 1, preserve_beat: false do
	f -7, -3, :ul; b 1/2
	t -5, 1; b 1/2
	t -4, -1; b 1/2
	t -2, 3; b 1/2
end
tp_drop 8, -8, 1 do
	b 1/4
	t -1, -2; b 1/2
	t 1, 2; b 1/2
	t 2, -3; b 1/2
	t 4, 1; b 1/4
end
tp_chain 0, -8, 1 do
	t -2, -3; b 1/6
	t 0, -2; b 1/6
	t -1, -1; b 1/6
	t 1, 0; b 1/4
end
tp_drop -8, 8, 1, preserve_beat: false do
	t -3, 1; b 1/2
	t -2, 4; b 1/4
end
tp_drop 8, -8, 1 do
	b 1/4
	t 2, 3; b 1/2
end
tp_drop -8, -8, 1, preserve_beat: false do
	b 1/4
	t -1, 1; b 1/2
	t 2, 1; b 1/4
end
tp_drop 8, 8, 1 do
	t 4, 2; b 1/2

	t 7, 2; b 1/2
end
tp_chain 0, 8, 1 do
	t 5, 0; b 1/6
	t 3, -1; b 1/6
	t 4, -2; b 1/6
	t 2, -3; b 1/4
end
tp_drop 8, -8, 1 do
	t 7, -4; b 1/4
end
tp_drop -8, 8, 1 do
	t -1, -2; b 1/4
end
tp_drop 8, -8, 1 do
	t 6, 0; b 1/4
end
tp_chain 0, -8, 1 do
	t 0, 1; b 1/6
	t 2, 2; b 1/6
	t -1, 3; b 1/6
	t 1, 4; b 1/4
end
tp_drop -8, -8, 1 do
	t -6, 3; b 1/4
end
tp_chain 0, 8, 1 do
	t -4, 0; b 1/6
	t -6, -1; b 1/6
	t -3, -2; b 1/6
	t -5, -3; b 1/4
end
tp_drop 8, -8, 1 do
	t 2, -4; b 1/4
end

tp_drop -8, 8, 1 do
	t -1, -1; b 1/4
end
tp_drop 8, -8, 1 do
	t 4, -2; b 1/4
end
tp_drop -8, 8, 1 do
	t 0, 2; b 1/4
end
tp_drop 8, -8, 1 do
	t 5, 1; b 1/4
end
tp_drop -8, 8, 1 do
	t 1, 0; b 1/4
end
tp_drop 8, -8, 1 do
	t 7, -1; b 1/4
end
tp_drop -8, 8, 1 do
	t 2, 3; b 1/4
end
tp_drop 8, -8, 1 do
	t 8, 2; b 1/4
end
tp_drop -8, -8, 1 do
	t 1, 2; b 1/4
end
tp_drop 8, 8, 1 do
	t 5, 3; b 1/4
end
tp_chain 0, 8, 1 do
	t 3, 0; b 1/6
	t 5, -1; b 1/12
	d 3.5, -1.5; b 1/12
	t 2, -2; b 1/6
	t 4, -3; b 1/4
end
tp_drop -8, -8, 1 do
	t -2, -3; b 1/4
end
tp_drop 8, 8, 1 do
	t 1, 1; b 1/4
end
tp_drop -8, -8, 1 do
	t -3, 0; b 1/4
end

tp_drop 8, -8, 1 do
	t -1, 2; b 1/4
end
tp_drop -8, 8, 1 do
	t -7, 3; b 1/4
end
tp_drop 8, -8, 1 do
	t -2, -2; b 1/4
end
tp_drop -8, 8, 1 do
	t -8, -1; b 1/4
end
tp_drop 8, -8, 1 do
	t 2, 3; b 1/4
end
tp_drop -8, 8, 1 do
	t -4, 4; b 1/4
end
tp_drop 8, -8, 1 do
	t 1, -1; b 1/4
end
tp_drop -8, 8, 1 do
	t -5, 0; b 1/4
end
tp_chain 0, 8, 1 do
	t 3, 2; b 1/6
	t 1, 1; b 1/6
	t 4, 0; b 1/6
	t 2, -1; b 1/4
end
tp_drop 8, 8, 1 do
	t 7, 1; b 1/4
end
tp_drop -8, -8, 1 do
	t 2, -4; b 1/4
end
tp_drop 8, 8, 1 do
	t 8, -3; b 1/4
end
tp_drop -8, -8, 1 do
	t -1, -3; b 1/4
end
tp_drop 8, 8, 1 do
	t 5, -2; b 1/4
end

tp_drop -8, 8, 1 do
	t -2, 1; b 1/4
end
tp_drop 8, -8, 1 do
	t 4, 0; b 1/4
end
tp_drop -8, 8, 1 do
	t -1, 4; b 1/4
end
tp_drop 8, -8, 1 do
	t 5, 3; b 1/4
end
tp_drop -8, 8, 1 do
	t -5, -1; b 1/4
end
tp_drop 8, -8, 1 do
	t 1, -2; b 1/4
end
tp_drop -8, 8, 1 do
	t -4, 3; b 1/4
end
tp_drop 8, -8, 1 do
	t 2, 2; b 1/4
end
tp_drop -8, -8, 1 do
	t -7, -3; b 1/4
end
tp_drop 8, 8, 1 do
	t -1, -2; b 1/4
end
tp_drop -8, -8, 1 do
	t -8, 1; b 1/4
end
tp_drop 8, 8, 1 do
	t -2, 2; b 1/4
end
tp_drop -8, -8, 1 do
	t -4, -4; b 1/4
end
tp_drop 8, 8, 1 do
	t 2, -3; b 1/4
end
tp_drop -8, -8, 1 do
	t -5, 0; b 1/4
end
tp_drop 8, 8, 1 do
	t 1, 1; b 1/4
end

tp_chain 0, -8, 1 do
	t -2, 1; b 1/6
	t 0, 2; b 1/6
	t -1, 3; b 1/6
	t 1, 4; b 1/4
end
tp_drop -8, -8, 1 do
	t -5, 3; b 1/4
end
tp_drop 8, 8, 1 do
	t 3, -1; b 1/4
end
tp_drop -8, -8, 1 do
	t -3, -2; b 1/4
end
tp_drop 8, 8, 1 do
	t 5, -3; b 1/4
end
tp_drop -8, -8, 1 do
	t -1, -4; b 1/4
end
tp_drop 8, -8, 1 do
	t 7, 0; b 1/4
end
tp_drop -8, 8, 1 do
	t 1, 1; b 1/4
end
tp_drop 8, -8, 1 do
	t 8, 3; b 1/4
end
tp_drop -8, 8, 1 do
	t 2, 4; b 1/4
end
tp_drop 8, -8, 1 do
	t 4, -2; b 1/4
end
tp_drop -8, 8, 1 do
	t -2, -1; b 1/4
end
tp_drop 8, -8, 1 do
	t 5, 2; b 1/4
end
tp_drop -8, 8, 1 do
	t -1, 3; b 1/4
end

def chain x0, y0, direction
	dx = %i[dr ur].include?(direction) ? 2 : -2
	dy = %i[ur ul].include?(direction) ? 1 : -1
	tp_chain 0, -dy*4, 1 do
		t x0, y0; b 1/6
		d x0+dx, y0+dy; b 1/12
		d x0+2*dx, y0+2*dy; b 1/12
		d x0+3*dx, y0+3*dy; b 1/6
	end
end
notes = group do
	tp_drop 8, 8, 1 do
		t 2, -1; b 1/4
	end
	tp_drop -8, -8, 1 do
		t -4, 0; b 1/4
	end
	chain 1, 1, :ur
end
transform(duplicate notes) do
	horizontal_flip
	translate 1, -1
	beat_translate 1
end
transform(duplicate notes) do
	translate -2, -2
	beat_translate 2
end
b 2
tp_drop -8, 8, 1 do
	t 3, 3; b 1/4
end
tp_drop 8, -8, 1 do
	t 8, 2; b 1/4
end
tp_drop -8, -8, 1 do
	t 2, -1; b 1/4
end
tp_drop 8, 8, 1 do
	t 7, -2; b 1/4
end

tp_drop -8, 8, 1 do
	t -2, 4; b 1/4
end
tp_drop 8, -8, 1 do
	t 4, 3; b 1/4
end
tp_chain 0, 8, 1 do
	t 0, 2; b 1/6
	t 2, 1; b 1/12
	d 0.5, 0.5; b 1/12
	t -1, 0; b 1/6
	t 1, -1; b 1/4
end
tp_drop -8, -8, 1 do
	t -4, -2; b 1/4
end
tp_drop 8, 8, 1 do
	t 5, 0; b 1/4
end
tp_drop -8, -8, 1 do
	t -5, 1; b 1/4
end
end
notes = group do
	tp_drop -8, 0, 1 do
		t -7, 2; tp_none { d -7, 2 }; b 1/2
		f -8, 4, :ul; b 3/2
	end
end
transform(duplicate notes) { horizontal_flip }

current_beat = beat
finale1_start = finale1.find { %i[tap flick].include? _1.type }.beat
finale1.each do |note|
	next unless %i[tap flick].include? note.type
	next unless note.beat % 1 == 0 || note.beat - finale1_start == 31/2
	b! note.beat; d note[:x], note[:y]
end
b! current_beat

grid 24
def pattern second = false; group do
	tp_drop -8, 0, 1 do
		t -4, 4
	end
	d -4, 4
	tp_drop 8, 0, 1 do
		t 4, 4; b 1/4
	end
	tp_drop -8, 0, 1 do
		t -2, 3; b 1/4
	end
	tp_drop 8, 0, 1 do
		t 2, 2
	end
	d 2, 2 if second; b 1/4
	tp_drop -8, 0, 1 do
		t -2, 1; b 1/4
	end
	tp_drop 8, 0, 1 do
		t 1, 0
	end
	d 1, 0; b 1/6
	tp_drop -8, 0, 1 do
		t -1, -1; b 1/12
	end
	d 0, -1.5; b 1/12
	tp_drop 8, 0, 1 do
		t 1, -2; b 1/6
	end
	tp_drop -8, 0, 1 do
		t -1, -3
	end
	d -1, -3 unless second; b 1/4
	tp_drop 8, 0, 1 do
		t 2, -4; b 1/4
	end
	4.times do |i|
		tp_chain -8, 0, 1 do
			x, y = -4-i, -2 + (i%3)*2
			t x, y
			d x, y if i % 2 == 0
			b 1/4
		end
		tp_chain 0, 8, 1 do
			t 0, -4; b 1/4
		end
	end
end; end
pattern

transform(pattern true) do
	rotate PI
end

5.times do |i|
	x, y = 1+i, 3-i
	tp_drop 8*(-1)**i, 8, 1 do
		t x*(-1)**i, y
	end
	tp_drop -8*(-1)**i, 8, 1 do
		d -x*(-1)**i, y; b 1/4
	end
end
tp_drop -8, 0, 1 do
	t -2, -1; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, -2; b 1/4
end
tp_drop -8, 0, 1 do
	t -2, -3; b 1/4
end
tp_drop 0, 8, 1, preserve_beat: false do
	4.times do
		b 1/4; t 0, -4; b 1/4
	end
end
tp_drop 0, -8, 1 do
	t 4, 2; tp_none { d 4, 2 }; b 1/2
	t 2, 0; b 1/2
	t -2, 0; tp_none { d -2, 0 }; b 1/2
	t -4, 2; b 1/2
end

tp_drop 8, 0, 1 do
	t 2, 3; tp_none { d 2, 3 }; b 1/4
end
tp_drop -8, 0, 1 do
	t -2, 2; b 1/4
end
tp_drop 8, 0, 1 do
	t 1, 1; b 1/6
end
tp_drop -8, 0, 1 do
	t -1, 0; b 1/12
end
d 0, -0.5; b 1/12
tp_drop 8, 0, 1 do
	t 1, -1; b 1/6
end
tp_drop -8, 0, 1 do
	t -1, -2; tp_none { d -1, -2 }; b 1/2
end
tp_drop 0, 8, 1 do
	t -7, -3; t 7, -3; tp_none { d 7, -3 }; b 1/2
end

tp_drop 8, 0, 1, preserve_beat: false do
	t 4, -4; b 1/4
	t 3, -3; b 1/2
	t 5, -1; b 1/2
	t 3, 1; b 1/2
	t 5, 3; b 1/4
end
tp_drop -8, 0, 1 do
	t -4, -4; tp_none { d -4, -4 }; b 1/2
	t -6, -2; b 1/2
	t -4, 0; tp_none { d -4, 0 }; b 1/2
	t -6, 2; b 1/2
end
6.times do |i|
	x, y = -(-1)**i, 3-i
	tp_drop x*8, 0, 1 do
		t x, y; tp_none { d x, y } if i.zero?; b 1/12
	end
	d 0, y-0.5 if i == 4; b 1/12
end
tp_drop 0, -8, 1 do
	t -1, -3; tp_none { d -1, -3 }; b 1/4
end
tp_drop 8, 0, 1 do
	t 3, -2; b 1/4
end
tp_drop -8, 0, 1 do
	t -3, -3; b 1/4
end
tp_drop 8, 0, 1 do
	t 3, -4; b 1/4
end
tp_drop 0, 8, 1, preserve_beat: false do
	4.times do
		b 1/4; t 0, -4; b 1/4
	end
end
tp_drop 0, -8, 1 do
	t -4, 2; tp_none { d -4, 2 }; b 1/2
	t -2, 0; b 1/2
	t 2, 0; tp_none { d 2, 0 }; b 1/2
	t 4, 2; b 1/2
end

notes = group do
	3.times do |i|
		tp_drop 0, 8, 1 do
			t -6+2*i, 4-2*i; b 1/2
		end
		tp_drop -8, 0, 1 do
			t -6+2*i, 2-2*i; b 1/2
		end
	end
end
transform(duplicate notes) do
	horizontal_flip
	beat_translate 1/4
end
6.times do |i|
	x, y = -(-1)**i, 3-i
	tp_drop x*8, 0, 1 do
		t x, y; b 1/6
	end
end
group preserve_beat: false do
	b -4
	d -6, 4; b 1
	d -4, 2; b 1
	d -2, 0; b 1/2
	d 2, 0; b 1/2
	d -1, 3; b 1/2
	d 1, 0; b 1/2
end

def fd x, y, duration, flick = false
	direction = x < 0 ? PI : 0
	tp_drop 8*(x<=>0), 8, 1 do
		flick ? f(x, y, direction) : t(x, y)
	end
	tp_drop 8*(x<=>0), -8, 1 do
		d x, y
		group preserve_beat: false do
			b duration; d x+2*cos(direction), y+2*sin(direction)
		end if duration && duration > 0
		4.times do |i|
			bg_note x+i*cos(direction), y+i*sin(direction)
		end
	end
end
def pattern second = false; group do
		2.times do |j|
		5.times do |i|
			fd -(1+i)*(-1)**i, [-3,1][j]+i/2, second && i==4 && 1/4
			b 1/4
		end
		b 1/4
	end
	fd 1, -1, 1/8, true; b 1/4
	fd -1, -1, 1/8, true; b 1/4
	fd 1, 1, second && 1/8, true; b 1/4
	fd -1, 1, nil, true; b 1/4
end; end
pattern

transform(pattern true) { rotate PI }

b 4

tp_drop 0, 12, 1 do
	t -4, -4; b 1/16
	d -2, -4; b 1/12-1/16
	d 0, -4; b 1/8-1/12
	d 2, -4; b 1/6-1/8
	d 4, -4; b 5/6+7
end

tp_drop 0, -12, 1 do
	t 3, 4; b 1/6
	d 1, 4; b 1/6
	d -1, 4; b 1/6
	d -3, 4; b 7/2
end

transform @events do
	scale 12.5
end

check

end
