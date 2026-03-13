include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'master' do

title 'world.execute(me);'
artist 'Mili'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_sup '+'
difficulty_color :master
difficulty '12'

offset 0.204
bpm 130

tp_chain -100, 0, 1 do
	t -75, 25, 'Switch'; b 1
	t -12.5, 25, 'on'; b 3/4
	t 25, 25, 'the'; b 1/4
	t 37.5, 12.5, 'po-'; b 1/4
	t 50, 25, 'wer'; b 1/2
	t 75, 25, 'line'; b 3/4
end
tp_chain -100, 0, 1 do
	t -75, 0, 'Re-'; b 1/2

	t -50, 0, 'mem-'; b 1/2
	t -25, 0, 'ber'; b 1/2
	t 0, 0, 'to'; b 1/2
	t 25, 0, 'put'; b 1/2
	t 50, 0, 'on'; b 1/2
end
big_text 1, 'PROTECTION'
tp_drop 0, 100, 1 do
	t -37.5, -25; b 1/2
	t 0, -25; b 1/2
	t 37.5, -25; b 1/2
end

tp_chain 100, 0, 1 do
	t 75, 25, 'Lay'; b 1
	t 12.5, 25, 'down'; b 3/4
	t -25, 25, 'your'; b 1/4
	t -37.5, 12.5, 'pie-'; b 1/4
	t -50, 25; b 1/2
	t -75, 25, 'ces'; b 3/4
end
tp_chain 100, 0, 1 do
	t 37.5, 0, 'And'; b 1/2

	t 12.5, 0, 'let\'s'; b 1/2
	t -12.5, 0, 'be-'; b 1/2
	t -37.5, 0, 'gin'; b 1/2
end
big_text 2, 'OBJECT CREATION'
tp_drop 0, 100, 1 do
	t 75, -25; b 1/2
	t 37.5, -25; b 1/2
	t 0, -25; b 1/2
	t -37.5, -25; b 1/2
	t -75, -25; b 1/2
end

tp_chain 0, 100, 1 do
	t -75, 50, 'Fill'; b 1
	t -62.5, 25, 'in'; b 3/4
	t -50, 0, 'my'; b 1/4
	t -18.75, 0, 'da-'; b 1/4
	t -37.5, -25; b 1/2
	t -25, -50, 'ta'; b 3/4
end
tp_chain 0, 100, 1 do
	t -25, 37.5, 'pa-'; b 1/2

	t -12.5, 12.5, 'ra-'; b 1/2
	t 0, -12.5, 'me-'; b 1/2
	t 12.5, -37.5, 'ters'; b 1/2
end
big_text 2, 'INITIALIZATION'
tp_drop -100, 0, 1 do
	t 62.5, 50; b 1/2
	t 50, 25; b 1/4
	t 18.75, 25; b 1/4
	t 37.5, 0; b 1/2
	t 25, -25; b 1/2
	t 12.5, -50; b 1/2
end

tp_chain 0, 100, 1 do
	t -50, 50, 'Set'; b 1
	t -50, 25, 'up'; b 3/4
	t -62.5, 0, 'our'; b 1/4
	t -37.5, -12.5, 'new'; b 1/4
	t -62.5, -25; b 1/2
	t -50, -50, 'world'; b 3/4
end
tp_chain 0, 100, 1 do
	t 50, 50, 'And'; b 1/2

	t 50, 25, 'let\'s'; b 1/2
	t 50, 0, 'be-'; b 1/2
	t 50, -25, 'gin'; b 1/2
	t 50, -50, 'the'; b 1/2
end
big_text 3/2, 'SIMULATION'
notes = tp_drop 100, 0, 1 do
	t -37.5, 37.5; b 1/2
	t -62.5, 12.5; b 1/2
	t -37.5, -12.5; b 1/2
	t -62.5, -37.5; b 1/2
end
transform duplicate notes do
	horizontal_flip
end

grid 31
tp_chain 0, 100, 1, preserve_beat: false do
	4.times do
		t 75, 50; b 1
		t 75, -50; b 1
		t -75, -50; b 1
		t -75, 50; b 1
	end
	4.times do
		t -75, -50; b 1
		t 75, -50; b 1
		t 75, 50; b 1
		t -75, 50; b 1
	end
end
tp_chain -100, 0, 1 do
	t -50, 25; b 1
	t -25, 37.5; b 1/2
	t -12.5, 12.5; b 1/2
	t 25, 12.5; b 1
	t 50, 25; b 1/2
	t 25, 37.5; b 1/2

	b 1/2
	t -50, -37.5; b 1/2
	t -37.5, 0; b 1/2
	t -12.5, -12.5; b 1/2
	t 25, 37.5; b 1/2
	t 37.5, 12.5; b 1/2
	t 25, -12.5; b 1/2
	t 37.5, -37.5; b 1/2

	t -50, -37.5; b 1/2
	t -25, -37.5; b 1/2
	t -12.5, 0; b 1/2
	t 12.5, -12.5; b 1/2
	t 37.5, -12.5; b 3/2
	t 62.5, 25; b 1/2

	b 1/2
	t -12.5, 0; b 7/4
	f -50, -37.5, :r; b 1/4
	t -62.5, -12.5; b 1/2+3/8
	t -50, 25; b 3/8
	t -12.5, 25; b 1/4

	t 0, 12.5; b 1
	t 37.5, 37.5; b 2/3
	t 12.5, -12.5; b 1/3
	t 0, -25; b 1
	t -50, -37.5; b 1
	
	t 50, 25; b 1/2
	t 25, 37.5; b 1/2
	t 12.5, 12.5; b 1/2
	t -37.5, 25; b 1/2
	t 25, -12.5; b 1/2
	t 0, -25; b 1/2
	t 25, -50; b 1/2
	t 37.5, 25; b 1/2

	t 0, 0; b 2/3
	t -25, -25; b 1/3
	t -37.5, -37.5; b 2/3
	t -25, 25; b 1/3
	t -37.5, 37.5; b 2/3
	t 25, 25; b 1/3
	t 37.5, 37.5; b 1/2
	t 12.5, -12.5; b 1/4
	t 25, -25; b 1/4

	t 37.5, -37.5; b 1
	t 0, -12.5; b 3/4
	t 25, 50; b 1/2
	f 62.5, 25, :l; b 1/4
	t 87.5, 12.5; b 3/4
	t -62.5, 25; b 1/4
	t -37.5, 37.5; b 1/4
	t -25, 12.5; b 1/4
end

tp_drop 0, -50, 1, relative: false, preserve_beat: false do
	2.times do
		8.times { t -100, -50; b 1 }
		8.times { t 100, -50; b 1 }
	end
end

group preserve_beat: false do
	bg_note 100, 50, 'If'; b 1
	bg_note 100, 25, 'I\'m'; b 3/4
	bg_note 100, 0, 'a'; b 1/4
	bg_note 87.5, -12.5, 'set'; b 1/4
	bg_note 100, -25, 'of'; b 1/2
	bg_note 100, -50, 'points'; b 3/4
	bg_note 75, 50, 'Then'; b 1/2

	bg_note 75, 30, 'I'; b 1/2
	bg_note 75, 10, 'will'; b 1/2
	bg_note 75, -10, 'give'; b 1/2
	bg_note 75, -30, 'you'; b 1/2
	bg_note 75, -50, 'my'; b 1/2
end

b 2
80.times do
	start = rand(20)/4
	stop = 5 + rand(8)/16
	group preserve_beat: false do
		b start
		bg_note -37.5+rand(76), -37.5+rand(76), stop - start
	end
end
b 4+1/2
big_text 3/2, 'DIMENSION'; b 1/2
t -50, 50; b 1/16
(1...6).each do |i|
	d -50, 50-100/6*i; b 1/16
end
(0...6).each do |i|
	d -50+100/6*i, -50; b 1/16
end
b 1/4

group preserve_beat: false do
	bg_note -100, 50, 'If'; b 1
	bg_note -100, 25, 'I\'m'; b 3/4
	bg_note -100, 0, 'a'; b 1/4
	bg_note -87.5, -12.5, 'cir-'; b 1/4
	bg_note -100, -25; b 1/2
	bg_note -100, -50, 'cle'; b 3/4
	bg_note -75, 50, 'Then'; b 1/2

	bg_note -75, 30, 'I'; b 1/2
	bg_note -75, 10, 'will'; b 1/2
	bg_note -75, -10, 'give'; b 1/2
	bg_note -75, -30, 'you'; b 1/2
	bg_note -75, -50, 'my'; b 1/2
end

b 2
24.times do |i|
	angle = i * PI/12 - 3*PI/4
	bg_note 50*cos(angle), 50*sin(angle), 5-i/6
	b 1/6
end
b 1/2
big_text 3/2, 'CIRCUMFERENCE'; b 1/2
12.times do |i|
	angle = i * PI/6 - 3*PI/4
	x, y = 50*cos(angle), 50*sin(angle)
	i == 0 ? t(x, y) : d(x, y)
	b 1/16
end
b 1/4

group preserve_beat: false do
	bg_note 100, 50, 'If'; b 1
	bg_note 100, 25, 'I\'m'; b 3/4
	bg_note 100, 0, 'a'; b 1/4
	bg_note 87.5, -12.5, 'sine'; b 1/4
	bg_note 100, -25; b 1/2
	bg_note 100, -50, 'wave'; b 3/4
	bg_note 70, 50, 'Then'; b 1/2

	bg_note 80, 100/3, 'you'; b 1/2
	bg_note 70, 50/3, 'can'; b 1/2
	bg_note 80, 0, 'sit'; b 1/2
	bg_note 70, -50/3, 'on'; b 1/2
	bg_note 80, -100/3, 'all'; b 1/2
	bg_note 70, -50, 'my'; b 1/2
end

b 2
32.times do |i|
	x = -150+300*i/32
	bg_note x, -200/(3*PI)*sin(3*PI/200*x), 5-i/8
	b 1/8
end
b 1
big_text 1, 'TANGENTS'
12.times do |i|
	x, y = -50+100*i/12, 50-100*i/12
	i == 0 ? t(x, y) : d(x, y)
	b 1/16
end
b 1/4

group preserve_beat: false do
	bg_note -100, 50, 'If'; b 1/2
	bg_note -100, 30, 'I'; b 1/4
	bg_note -87.5, 20, 'a-'; b 1/4
	bg_note -100, 10, 'pproach'; b 1/2
	bg_note -100, -10, 'in-'; b 1/2
	bg_note -100, -30, 'fi-'; b 1/4
	bg_note -87.5, -40, 'ni-'; b 1/4
	bg_note -100, -50, 'ty'; b 3/4
	bg_note -75, 50, 'Then'; b 1/2

	bg_note -75, 25, 'you'; b 1/2
	bg_note -75, 0, 'can'; b 1/2
	bg_note -75, -25, 'be'; b 1/2
	bg_note -75, -50, 'my'; b 1/2
end

b 2
32.times do |i|
	x = -150+300*i/32
	bg_note x, -37.5+6000/(x+200), 4-i/8
	group(preserve_beat: false) { b 5-i/8; bg_note x, -37.5 }
	b 1/8
end
big_text 2, 'LIMITATIONS'
t -50, 0; b 1/16
(1...8).each { |i| d -50+50*i/8, 50*i/8; b 1/16 }
t 0, 50; b 1/2
t 0, 0; b 1/16
(1...8).each { |i| d 50*i/8, -50*i/8; b 1/16 }
t 50, -50; b 1/2

def broken_line points, duration = 0, count = 4
	points.each_cons 2 do |(x1, y1), (x2, y2)|
		count.times do |i|
			x = x1 + (x2 - x1) * i / count
			y = y1 + (y2 - y1) * i / count
			bg_note x, y, duration
		end
	end
end
group preserve_beat: false do
	b 1
	broken_line [[-75, 0], [-25, 0]], 3/2
	broken_line [[0, 25], [75, 25]], 3/2, 6
	broken_line [[0, -25], [75, -25]], 3/2, 6
	broken_line [[-25, 0], [0, 25]]
	b 3/2
	broken_line [[-25, 0], [0, -25]]
end.tap do |circuit|
	transform circuit do
		scale 1.25
		translate 0, 25
	end
end

tp_drop 0, -100, 1 do
	t -37.5, -37.5, 'Switch'; b 1
	t 0, -37.5, 'my'; b 1
	t 37.5, -37.5, 'cu-'; b 1/2
	t 62.5, -37.5, 'rrent'; b 1
end
group preserve_beat: false do
	(0..12).each do |i|
		x = -100+200*i/12
		y = 50*sin(PI*x/100)
		i == 0 ? t(x, y, 'To') : d(x, y); b 1/8
	end
	b 3/8
	(0..12).each do |i|
		x = -100+200*i/12
		i == 0 ? t(x, 0, 'to') : d(x, 0); b 1/8
	end
end
b 1/2

bg_note -12.5, 50, 'A-'; b 1/2
bg_note 12.5, 50, 'C'; b 3/2
bg_note -12.5, -50, 'D-'; b 1/2
bg_note 12.5, -50, 'C'; b 1/2
bg_note -87.5, -37.5, 'And'; b 1/2
bg_note -62.5, -37.5, 'then'; b 1/2

group preserve_beat: false do
	b 1
	dx, dy = sqrt(3)*12.5, 1.5*12.5
	(-7..7).each do |i|
		(-4..4).each do |j|
			x, y = (i + j%2/2)*dx, j*dy
			group(preserve_beat: false) { b rand(16)/16; bg_note x, y, 5 }
		end
	end
end

tp_drop 0, -100, 1 do
	t -37.5, -37.5, 'blind'; b 1
	t 0, -37.5, 'my'; b 1
	t 37.5, -37.5, 'vi-'; b 1/2
	t 62.5, -37.5, 'sion'; b 1
end
dizzy = group preserve_beat: false do
	(0..12).each do |i|
		r = 50*i/12
		angle = PI/2 + 3*PI*i/12
		x, y = r*cos(angle), r*sin(angle)
		i == 0 ? t(x, y, 'So') : d(x, y); b 1/8
	end
end
transform duplicate dizzy do
	vertical_flip
	beat_translate 2
end.tap { _1[0][:text] = 'so' }
b 1/2

bg_note -12.5, 50, 'di-'; b 1/2
bg_note 12.5, 50, 'zzy'; b 3/2
bg_note -12.5, -50, 'di-'; b 1/2
bg_note 12.5, -50, 'zzy'; b 1/2
bg_note -87.5, -37.5, 'Oh'; b 1/2
bg_note -62.5, -37.5; b 1/2

def circle x, y, r, duration = 0, count = 8
	count.times do |i|
		bg_note x+r*cos(2*PI*i/count), y+r*sin(2*PI*i/count), duration
	end
end
group preserve_beat: false do
	b 1
	broken_line [[0,3],[-0.66,2.25],[-0.5,1.26]], 1, 3
	broken_line [[0,3],[0.75,2.34],[1.60,2.05]], 1, 3
	broken_line [[0,3],[0,2],[-0.32,1.05],[-0.90,0.24]], 1, 3
	broken_line [[0,2],[0.46,1.11],[0.31,0.13]], 1, 3
	circle 0, 3.3, 0.3, 1, 6
end.tap do |man|
	transform man do
		scale 40
		translate 0, -80
	end
end

tp_drop 0, -100, 1 do
	t -37.5, -37.5, 'we'; b 1
	t 0, -37.5, 'can'; b 1
	t 37.5, -37.5, 'tra-'; b 1/2
	t 62.5, -37.5, 'vel'; b 1
end
broken_line [[-75,0], [100,0]], 2, 10
broken_line [[0,-75],[0,100]], 2, 10
cone = group preserve_beat: false do
	t 0, 0, 'To'; b 1/8
	notes = group do
		(1..8).each do |i|
			d 50*i/8, 50*i/8; b 1/8
		end
	end
	transform(duplicate notes) { horizontal_flip }
end
transform duplicate cone do
	vertical_flip
	beat_translate 2
end.tap { _1[0][:text] = 'to' }
b 1/2

bg_note -12.5, 50, 'A.-'; b 1/2
bg_note 12.5, 50, 'D'; b 3/2
bg_note -12.5, -50, 'B.-'; b 1/2
bg_note 12.5, -50, 'C'; b 1/2
bg_note -75, -37.5, 'And'; b 1

group preserve_beat: false do
	2.times do |i|
		angle0 = 2*PI*i/2
		64.times do |j|
			angle = angle0 + 4*PI*j/64
			r = 200*(1-j/64)
			x, y = r*cos(angle), r*sin(angle)
			group(preserve_beat: false) { b j/16; bg_note x, y }
		end
	end
end

tp_drop 0, -100, 1 do
	t -37.5, -37.5, 'we'; b 1
	t 0, -37.5, 'can'; b 1
	t 37.5, -37.5, 'u-'; b 1/2
	t 62.5, -37.5, 'nite'; b 1
end
t -75, 25, 'So'; b 1/2

group preserve_beat: false do
	b 3/2
	points = [[0,40],[20,35],[40,37],[42,10],[30,-20],[15,-30],[0,-37]]
	points += points.map { |(x,y)| [-x,y] }.reverse[1..]
	broken_line points, 3/2, 3
end
notes = tp_drop 0, 0, 1, relative: false, preserve_beat: false do
	b 1/2
	t 100, 12.5; b 1/2
	t 100, -12.5; b 1
	t -100, 12.5; b 1/2
	t -100, -12.5; b 3/2
end
t -75, 0, 'deep-'; b 1/2
t -75, -25, 'ly'; b 1
t 75, 25, 'so'; b 1/2
t 75, 0, 'deep-'; b 1/2
t 75, -25, 'ly'; b 3/2

if_i_can = tp_chain -100, 50, beat_speed: 50*sqrt(5), preserve_beat: false do
	t 0, 50, 'If'; b 1
	t 50, 25, 'I'; b 1/2
	t 75, 12.5, 'can'; b 1/2
end
transform duplicate if_i_can do
	horizontal_flip
	beat_translate 2
end
quavers = tp_drop 0, 0, relative: false, relative_beat: 1 do
	f -50, -37.5, :l; b 1/2
	t -62.5, -12.5; b 1/2
	t -62.5, 25; b 1/2
	t -50, 50; b 1/2
end
transform duplicate quavers do
	rotate PI
	beat_translate 2
end
b 2

group preserve_beat: false do
	b 2
	big_text 3/2, 'STIMULATIONS'
end
two_sides = tp_chain 0, 0, relative_beat: 1/2, relative: false do
	t 37.5, 37.5, 'give'; b 1/2
	t -12.5, -37.5, 'you'; b 1/2
	t -12.5, 37.5, 'all'; b 1/2
	t 37.5, -37.5, 'the'; b 1/2
	t -62.5, 37.5; b 1/2
	t 62.5, -12.5; b 1/2
	t -62.5, -12.5; b 1/2
	t 62.5, 37.5; b 1/2
end
transform duplicate two_sides do
	rotate PI
end

pattern = group do
	then_i_can = tp_chain -100, 0, 0.5 do
		8.times do |i|
			angle = PI/2 - 2*PI*i/8
			r = 50 - 37.5*i/8
			x, y = 50+r*cos(angle), r*sin(angle)
			i == 0 ? h(x, y, 1/2, 'Then') : d(x, y)
			b 1/8
		end
		t 50, 12.5, 'I'; b 1/2
		t 50, -12.5, 'can'; b 1/2
	end
	transform duplicate then_i_can do
		rotate PI
	end.tap { _1.each { |note| note[:text] = '' if note[:text] } }
end
transform duplicate pattern do
	horizontal_flip
	beat_translate 2
end
b 2

tp_drop 0, 0, 1/2, relative: false, preserve_beat: false do
	f 37.5, 37.5, :dl; b 1
	f -37.5, -37.5, :ur; b 1
end
tp_chain 0, 100, 1 do
	t -37.5, 37.5, 'be'; b 1/2
	t -75, 0, 'your'; b 1/2
	t 37.5, -37.5, 'on-'; b 1/2
	t 0, 0, 'ly'; b 1/2
end
big_text 3/2, 'SATISFACTION'
tp_drop 0, -100, 0.5 do
	t -37.5, 50
	t 37.5, 50; b 1/4
	t -25, 37.5; b 1/4
	t 25, 25; b 1/2
end
tp_drop 0, 100, 0.5 do
	t -12.5, -25; b 1/4
	t 25, -31.25; b 1/4
	t -37.5, -37.5; b 1/4
	t 50, -43.75; b 1/4

	t -62.5, -50, 'If'
	t 62.5, -50; b 1
end
pattern = group do
	tp_chain 0, 100, 1 do
		t 25, 37.5, 'I'; b 1/2
		t 62.5, 37.5, 'can'; b 1/2
	end
	tp_chain 100, 100, 1 do
		t -25, 0, 'make'; b 1/2
		t -75, 12.5, 'you'; b 1/2
		t -50, -25, 'ha-'; b 1/2
		t -50/3, -40, 'ppy'; b 1/2
	end
end
transform duplicate pattern do
	horizontal_flip
end.tap { _1.each { |note| note[:text] = '' if note[:text] } }

pattern = group do
	4.times do |i|
		angle = PI/8 + PI*i/4
		tp_chain 100*cos(angle+PI/8), 100*sin(angle+PI/8), 1, relative: false do
			t -50*cos(angle), -50*sin(angle); b 1/2
		end
	end
end
pattern = transform duplicate pattern do
	rotate PI
end
%w[I will run the].each do |text|
	pattern.find { _1[:text] == '' }[:text] = text
end
big_text 3/2, 'EXECUTION'
two_slashes = group do
	slash = tp_chain 100, 100, beat_speed: 200*sqrt(2) do
		f 50, 50, :dl; b 1/8
		d 50/3, 50/3; b 1/8
		d -50/3, -50/3; b 1/8
		d -50, -50; b 1/8
	end
	transform duplicate slash do
		horizontal_flip
		beat_translate 1/2
	end
	b 1/2
end
transform duplicate two_slashes do
	beat_translate 1
end
b 1

tp_chain -100, 0, 1, preserve_beat: false do
	f 25, 37.5, :r; b 1/2
	t 50, 0; b 1/2
	t 12.5, -25; b 1/2
	t -12.5, -50; b 1/2
	f -50, -37.5, :l; b 1/2
	t -75, 0; b 1/2
	t -37.5, 25; b 1/2
	t -12.5, 50; b 1/2
end
tp_chain 100, 0, 1 do
	h -25, -37.5, 1/2, 'Though'; b 1
	t -25, 12.5, 'we'; b 1/2
	t 0, 50, 'are'; b 1/2
	h 37.5, 25, 1/2, 'trapped'; b 1
	t 25, -12.5, 'in'; b 1/2
	t 0, -50, 'this'; b 1/2
end

bg_note 0, 12.5, 'strange'
two_c_drags = group do
	c_drag = tp_chain 0, -100, beat_speed: 200 do
		f 50, -50, :u; b 1/8
		d 50, -25; b 1/8
		d 50, 0; b 1/8
		d 50, 25; b 1/8
		d 50, 50; b 1/2
	end
	transform duplicate c_drag do
		rotate PI
	end
end
bg_note 0, -12.5, 'strange'
transform duplicate two_c_drags do
	rotate PI/2
	horizontal_flip
	beat_translate 1
end
b 1
big_text 3/2, 'SIMULATION'
square = tp_chain -100, 0, beat_speed: 200 do
	t 50, -50; b 1/2
	t 50, 50; b 1/2
	t -50, 50; b 1/2
	t -50, -50; b 1/2
end
transform duplicate square do
	rotate PI
end

group preserve_beat: false do
	bg_note -50, -37.5, 'If'; b 1
	bg_note -25, -37.5, 'I\'m'; b 3/4
	bg_note -0, -37.5, 'an'; b 1/4
	bg_note 25, -37.5, 'egg-'; b 1/4
	b 1/2
	bg_note 50, -37.5, 'plant'; b 3/4
	bg_note -62.5, -50, 'Then'; b 1/2
end
b 5/2
tp_chain 0, 100, 1 do
	t 25, 12.5; b 1/4
	t -25, 12.5; b 1/4
	t 37.5, 0; b 1/4
	t 25, -12.5; b 1/2
	t -37.5, -25; b 1/4

	t -50, -37.5
end
group preserve_beat: false do
	bg_note -37.5, -50, 'I'; b 1/2
	bg_note -12.5, -50, 'will'; b 1/2
	bg_note 12.5, -50, 'give'; b 1/2
	bg_note 37.5, -50, 'you'; b 1/2
	bg_note 62.5, -50, 'my'; b 1/2
	big_text 3/2, 'NUTRIENTS'
end
t 50, -37.5; b 1/2
t -50, -37.5
t 50, -37.5; b 1/2
b 3/2
tp_chain -100, 0, 1 do
	t -37.5, 37.5; b 1/4
	t 37.5, 37.5; b 1/4
	t -12.5, 12.5; b 1/4
	t 0, 0; b 1/4
	t -12.5, -12.5; b 1/4
	t 0, -25; b 1/4

	group preserve_beat: false do
		bg_note -62.5, -37.5, 'If'; b 1
		bg_note -37.5, -37.5, 'I\'m'; b 3/4
		bg_note -12.5, -37.5, 'a'; b 1/4
		bg_note 12.5, -37.5, 'to-'; b 1/4
		bg_note 37.5, -37.5, 'ma-'; b 1/2
		bg_note 62.5, -37.5, 'to'; b 3/4
		bg_note -50, -50, 'Then'; b 1/2
	end
	tp_chain 0, -100, 1, preserve_beat: false do
		t 50, -25; b 1/2
		t 37.5, 0; b 1/4
		t 50, 12.5; b 3/4
		t 62.5, 50; b 1/2
		t 25, 37.5; b 1/2
		t 25, 0; b 1/4
		t 37.5, -12.5; b 1/2
		t 12.5, -25; b 1/4
		t 0, -37.5; b 1/2
	end
	t -12.5, -37.5; b 3/4
	t -25, 0; b 1/2
	t -12.5, 25; b 1/4
	t -25, 37.5; b 3/2
	f -25, -12.5, :dr; b 1

	group preserve_beat: false do
		bg_note -25, -50, 'I'; b 1/2
		bg_note 0, -50, 'will'; b 1/2
		bg_note 25, -50, 'give'; b 1/2
		bg_note 50, -50, 'you'; b 1/2
		big_text 2, 'ANTIOXIDANTS'
	end
	f -50, -37.5, :ur; b 1
	t -75, 0; b 1/2
	t -12.5, 25; b 1/4
	t 0, 37.5; b 1/4
	t 12.5, 25; b 1/2
	t -25, 12.5; b 1/2
	t 37.5, -12.5
	tp_chain 0, 100, 1, preserve_beat: false do
		t -37.5, -12.5; b 1

		t -37.5, -50
	end
	b 1

	t 37.5, -50
end
group preserve_beat: false do
	bg_note 100, 50, 'If'; b 1
	bg_note 100, 30, 'I\'m'; b 3/4
	bg_note 100, 10, 'a'; b 1/4
	bg_note 100, -10, 'ta-'; b 1/4
	bg_note 100, -30, 'bby'; b 1/2
	bg_note 100, -50, 'cat'; b 3/4
	bg_note 75, 50, 'Then'; b 1/2
end
b 1
cat = group do
	24.times do |i|
		angle = 2*PI*i/24
		x = 50*cos(angle)
		y = 30*sin(angle) - 20
		next if y > 0 && x.abs > 25 && x.abs < 40
		bg_note x, y, 6
	end
	broken_line [[25,30*sin(acos(25/50))-20], [34,40], [40,30*sin(acos(40/50))-20]], 6
	broken_line [[-25,30*sin(acos(25/50))-20], [-34,40], [-40,30*sin(acos(40/50))-20]], 6
end
transform(cat) { translate -60, 0 }
b 3

group preserve_beat: false do
	bg_note 75, 30, 'I'; b 1/2
	bg_note 75, 10, 'will'; b 1/2
	bg_note 75, -10, 2, 'purr'; b 1/2
	bg_note 75, -30, 'for'; b 1/2
	bg_note 75, -50, 'your'; b 1/2
	big_text 2, 'ENJOYMENT'
end
tp_drop 0, -100, 1 do
	t -25, -50; t 25, -50; b 1/2+1/64
	t -25, -50; t 25, -50; b 1/2-1/64
end
12.times do |i|
	angle = 2*PI*i/12
	bg_note 75+30*cos(angle), -10+30*sin(angle), 2
end
bg_note 40, -20, 2; bg_note 30, -30, 2; bg_note 20, -20, 2
b 3

group preserve_beat: false do
	bg_note -100, 50, 'If'; b 1
	bg_note -100, 30, 'I\'m'; b 3/4
	bg_note -100, 10, 'the'; b 1/4
	bg_note -100, -10, 'on-'; b 1/4
	bg_note -100, -30, 'ly'; b 1/2
	bg_note -100, -50, 'god'; b 3/4
	bg_note -75, 50, 'Then'; b 1/2
end
tp_drop 0, -100, 1 do
	b 1/64
	t -25, -50; t 25, -50; b 1/2-1/64+1/16
	t -25, -50; t 25, -50; b 1/2-1/16
end
def right_wing duration = 0
	group do
		broken_line [[35,25],[70,25],[100,30],[80,0],[60,-10],[40,-12]], duration, 3
	end
end
def left_wing duration = 0
	transform right_wing duration do
		horizontal_flip
	end
end
def god_body duration = 0
	group do
		broken_line [[-15,15], [25,15]], duration, 4
		broken_line [[0,30],[0,-30]], duration, 6
	end
end
def god duration = 0
	group do
		left_wing duration
		right_wing duration
		god_body duration
	end
end
god 6
b 3

group preserve_beat: false do
	bg_note -75, 30, 'you\'re'; b 1/2
	bg_note -75, 10, 'the'; b 1/2
	bg_note -75, -10, 'proof'; b 1/2
	bg_note -75, -30, 'of'; b 1/2
	bg_note -75, -50, 'my'; b 1/2
	big_text 2, 'EXISTENCE'
end
tp_drop 0, -100, 1 do
	b -1/32
	t -25, -50; t 25, -50; b 1/2+1/32-1/32
	t -25, -50; t 25, -50; b 1/2+1/32
end
broken_line [[25,-35],[40,-60],[60,-40],[80,-20]], 2, 3
b 3

group preserve_beat: false do
	bg_note 75, 37.5, 'Switch'; b 1
	bg_note 75, 12.5, 'my'; b 1
	bg_note 75, -12.5, 'gen-'; b 1/2
	bg_note 75, -37.5, 'der'; b 1
end
tp_drop 0, 100, 1 do
	h -100, 25, 7/2
end
b 1
12.times do |i|
	angle = 2*PI*i/12
	x, y = 25*cos(angle), 25*sin(angle)
	group preserve_beat: false do
		b 3 if y.abs < 10
		bg_note x, y, (y.abs < 10 ? 2 : 5)
	end
end
arrow_head = group do
	bg_note 26, 25, 3/2
end
transform duplicate arrow_head do
	rotate PI
end
b 5/2
group preserve_beat: false do
	bg_note -62.5, 0, 'To'
	4.times do |i|
		d -12.5+25*i/3, -37.5; b 1/8
	end
	bg_note -62.5, -25, 'F'
	4.times do |i|
		d 0, -25-25*i/3; b 1/8
	end
	b 1
	bg_note 62.5, 25, 'to'
	4.times do |i|
		x = (25+25*i/3)/sqrt(2)
		d x, x; b 1/8
	end
	bg_note 62.5, 0, 'M'
	d 50/sqrt(2)-25*1/2, 50/sqrt(2); b 1/8
	d 50/sqrt(2)-25*1/4, 50/sqrt(2); b 1/8
	d 50/sqrt(2), 50/sqrt(2); b 1/8
	d 50/sqrt(2), 50/sqrt(2)-25*1/4; b 1/8
	d 50/sqrt(2), 50/sqrt(2)-25*1/2
end
b 1/2

tp_drop 0, 100, 1 do
	h -100, -25, 7/2
end
b 3
bg_note -75, 50, 'And'; b 1/2
bg_note -75, 30, 'then'; b 1/2

group preserve_beat: false do
	bg_note -75, 10, 'do'; b 1
	bg_note -75, -10, 'what-'; b 1
	bg_note -75, -30, 'e-'; b 1/2
	bg_note -75, -50, 'ver'; b 1
end
tp_drop 0, 100, 1 do
	h 100, -25, 7/2
end
b 1
circle -30, 0, 10, 1, 4
broken_line [[0,-30], [0,0], [30,0], [30,-30], [60,-30]], 1
b 5/2
group preserve_beat: false do
	bg_note 75, 50, 'From'; b 1/2
	bg_note 75, 25, 'A-'; b 1/2
	bg_note 75, 0, 'M'; b 1
	bg_note -75, 0, 'to'; b 1/2
	bg_note -75, -25, 'P'; b 1/2
	bg_note -75, -50, 'M'; b 1
end
arc = group preserve_beat: false do
	9.times do |i|
		angle = PI*i/8
		x, y = 50*cos(angle), 50*sin(angle)
		d x, y; b 1/8
	end
end
transform duplicate arc do
	vertical_flip
	beat_translate 2
end
24.times do |i|
	angle = 2*PI*i/24
	x, y = 50*cos(angle), 50*sin(angle)
	group preserve_beat: false do
		bg_note x, y, (x.abs < 20 ? 7/2 : 7)
	end
end
broken_line [[12.5,-37.5],[12.5,50]], 7/2, 7
broken_line [[25,-25],[25,37.5]], 7/2, 5
broken_line [[37.5,-12.5],[37.5,25]], 7/2, 3
b 1/2

tp_drop 0, 100, 1 do
	h 100, 0, 2; b 5/2-1/16
	h 100, 25, 1; b 1/2+1/16
end
bg_note 75, 37.5, 'Oh'; b 1

group preserve_beat: false do
	bg_note 75, 12.5, 'switch'; b 1
	bg_note 75, -12.5, 'my'; b 1
	bg_note 75, -37.5, 'role'
end
tp_drop 0, 100, 1 do
	b -1/16; h -100, 25, 7/2; b 1/16
end
b 1
arrow_head = group do
	bg_note 40, 45, 3/2
	bg_note 26, 28, 3/2
end
transform duplicate arrow_head do
	rotate PI
end
b 5/2
group preserve_beat: false do
	bg_note -12.5, 50, 'To'; b 1/2
	bg_note 12.5, 50, 'S'; b 3/2
	bg_note -12.5, -50, 'to'; b 1/2
	bg_note 12.5, -50, 'M'; b 3/2
end
group preserve_beat: false do
	9.times do |i|
		d 0, 50-100*i/8; b 1/8
	end
	b 7/8
	9.times do |i|
		angle = -PI/2 + 2*PI*i/8
		x, y = 25*cos(angle), 37.5*sin(angle)
		d x, y; b 1/8
	end
end
b 1/2

tp_drop 0, 100, 1 do
	h -100, -25, 7/2
end
b 3
bg_note -75, 50, 'So'; b 1

tp_drop 0, 100, 1 do
	h 100, -25, 7/2
end
group preserve_beat: false do
	bg_note -75, 25, 'we'; b 1
	bg_note -75, 0, 'can'; b 1
	bg_note -75, -25, 'en-'; b 1/2
	bg_note -75, -50, 'ter'; b 1
end
b 1/2
group preserve_beat: false do
	2.times do |i|
		angle0 = 2*PI*i/2
		32.times do |j|
			angle = angle0 + 2*PI*j/32
			r = 200*(1-j/32)
			x, y = r*cos(angle), r*sin(angle)
			group(preserve_beat: false) { b j/12; bg_note x, y }
		end
	end
end
b 3
group preserve_beat: false do
	bg_note -50,0, 'The'; b 1/2
	bg_note 50,0, 'trance'; b 3/2
	bg_note -50,0, 'the'; b 1/2
	bg_note 50,0, 'trance'; b 3/2
end
b 1/2

def fun(x) = sqrt(hypot(1,2*x)-1)
two_trances = group do
	trance = group do
		3.times do |i|
			angle0 = 2*PI*i/3
			(1...32).each do |j|
				progress = fun(j) / fun(32)
				r = 200 * progress
				angle = angle0 + 2*PI*progress
				x, y = r*cos(angle), r*sin(angle)
				group(preserve_beat: false) { b j/16; bg_note x, y }
			end
		end
	end
	transform trance do
		translate -50, 0
	end
	transform duplicate trance do
		beat_translate 1/2
		translate 100, 0
	end
end
transform duplicate two_trances do
	vertical_flip
	beat_translate 2
end
tp_drop 0, 100, 1 do
	h 100, 25, 5/2; b 4
end

pattern = group do
	notes = tp_chain -50, 100, beat_speed: 25*sqrt(5), preserve_beat: false do
		t -100, 25; b 1
		t -75, -25; b 1/2
		t -62.5, -50; b 1/2
	end
	transform duplicate notes do
		translate 100, 25
	end.tap do |notes|
		%w[If I can].each { |text| notes.find { _1[:text] == '' }[:text] = text }
	end
	tp_chain -50, 100, beat_speed: 25*sqrt(5) do
		b 1/2
		t -37.5, 12.5; b 3/2
	end
end
transform duplicate pattern do
	horizontal_flip
	beat_translate 2
end
b 2

def then_i_can_1
	16.times do |i|
		t = 1.82932*i/16 # t0 = 1.82932 is soln of cos(t)+cos(4t)/2=0
		y = 50*(1-cos(t)-cos(4*t)/2)
		x = 100*(sin(t)+sin(4*t)/2)/1.39647 # 1.39647 = sin(t0)+sin(4t0)/2
		i == 0 ? h(x, y, 1/2, 'Then') : d(x, y); b 1/16
	end
	t 100, 50, 'I'; b 1/2
	t 75, 25, 'can'; b 1/2
end
def then_i_can_2
	8.times do |i|
		angle = PI/2*i/8
		y = 25-75*cos(angle)
		x = -100*sin(angle)
		i == 0 ? h(x, y, 1/2) : d(x, y); b 1/8
	end
	t -100, 25; b 1/2
	t -75, 50; b 1/2
end

tp_chain 100, 100, beat_speed: 100 do
	8.times do |i|
		angle = PI/2 * i/8
		r = 50*sin(angle*2)
		angle -= 3*PI/4
		x, y = r*cos(angle), r*sin(angle)
		i == 0 ? h(x, y, 1, 'feel') : d(x, y); b 1/8
	end
	tp_chain -100, -100, beat_speed: 100, preserve_beat: false do
		8.times do |i|
			i /= 8
			x = 100*i
			y = 100 * (sqrt(1-i**2)+i-1)
			d x, y; b 1/8
		end
		16.times do |i|
			x = 100*cos(PI/2*i/16)
			y = -37.5*i/16 + (-1)**i*12.5
			d x, y; b 1/8
		end
		then_i_can_2
	end
	8.times do |i|
		i /= 8
		x = -100*i
		y = 100 * (sqrt(1-i**2)+i-1)
		i == 0 ? h(x, y, 1, 'your') : d(x, y); b 1/8
	end
	big_text 3/2, 'VIBRATIONS'
	16.times do |i|
		x = -100*cos(PI/2*i/16)
		y = -37.5*i/16 + (-1)**i*12.5
		d x, y; b 1/8
	end

	then_i_can_1
end
second_then_i_can = group do
	tp_chain -100, 0, 0.5, preserve_beat: false do
		then_i_can_1
	end
	tp_chain 100, 0, 0.5 do
		then_i_can_2
	end
end
transform second_then_i_can do
	horizontal_flip
end

tp_chain 100, 0, beat_speed: 200, preserve_beat: false do
	8.times do |i|
		x = 100-200*i/8
		y = 0
		i == 0 ? h(x, y, 1/2, 'fi-') : d(x, y); b 1/8
	end
	t -100, 0; b 1/2
	t -100, -25; b 1/2
end
tp_chain -100, 0, beat_speed: 200 do
	8.times do |i|
		x = -100+200*i/8
		y = -25
		i == 0 ? f(x, y, :r) : d(x, y); b 1/8
	end
	t 100, 0, 'na-'; b 1/2
	t 100, -25, 'li-'; b 1/2
end
group preserve_beat: false do
	2.times { t -25, -25; b 1/2 }
end
tp_chain -100, 100, 0.5 do
	t -50, 0, 'be'; b 1/2
	big_text 1, 'COMPLETION'
	t 0, -50; b 1/2
	t 25, -25; b 1/4
	t 50, 0; b 1/4
	t 75, 25; b 1/4
	t 100, 50; b 1/4
end

def left x, y
	f x, y, :l, 'left'
	(1..3).each do |i|
		r = 12.5*sqrt(2)*i
		4.times do |j|
			angle = PI/4 + PI/2*j
			bg_note x + r*cos(angle), y + r*sin(angle)
		end
	end
end
tp_drop 0, 100, 1 do
	h 50, 50, 1/2, 'Though'; b 1
end
diamond_grid 12
tp_drop 100, 0, 1 do
	f 50, 0, :l, 'you'; b 1/2
	f 0, 0, :l, 'have'; b 1/2
	h 75, 25, 3/2
	left -50, 0; b 1
	f 50, 0, :l, 'You'; b 1/2
	f 0, 0, :l, 'have'; b 1/2

	h 100, 0, 3/2
	left -50, 0; b 1
	f 50, 0, :l, 'You'; b 1/2
	f 0, 0, :l, 'have'; b 1/2
	h 75, -25, 3/2
	left -50, -50; b 1
	f 50, 0, :l, 'You'; b 1/2
	f 0, 0, :l, 'have'; b 1/2

	h 100, -50, 3/2
	left -50, 50; b 1
	f 50, 50, :l, 'You'; b 1/2
	f 0, 0, :l, 'have'; b 1/2
	h 75, 25, 3/2
	left -50, 0; b 1
	f 50, 0, :l, 'You'; b 1/2
	f 0, 0, :l, 'have'; b 1/2

	h 100, 0, 3/2
	left -50, 0; b 1/4
	d -75, 0; b 1/4
	d -100, 0; b 1/2
	t -75, -25, 'me'; b 1/2
	t -50, -50, 'in'; b 1/2
end
big_text 3/2, 'ISOLATION'
broken_line [[50,0], [0,50], [-50,0], [0,-50], [50,0]], 3/2
tp_chain -50, 0, relative: false, beat_speed: 100*sqrt(2), preserve_beat: false do
	4.times do |i|
		angle = -PI/2 + PI/2*i
		f 50*cos(angle), 50*sin(angle), angle; b 1/2
	end
end
4.times { t 0, 0; b 1/2 }

def company
	tp_chain -50, 100, beat_speed: 25*sqrt(5), preserve_beat: false do
		t 75, 50; b 1/2
		t 87.5, 25; b 1/2
		f 100, 0, :r; b 1/2
		t 87.5, 25; b 1/2
		t 75, 50; b 1/2
		t 87.5, 25; b 1/2
		f 100, 0, :r; b 1/2
		t 87.5, -25; b 1/2
	end
end
company
2.times do
	tp_chain -100, 100, beat_speed: 50*sqrt(2) do
		f -100, 25, :ur, 'If'; b 1
		t -50, -25, 'I'; b 1/2
		t -75, 0, 'can'; b 1/2
	end
end

transform company do
	rotate PI
end
tp_chain 100, 0, 1 do
	t 50, -37.5, 'e-'; b 1/2
	t 37.5, -12.5, 'rase'; b 1/2
	t 37.5, 25, 'all'; b 1/2
	t 50, 50, 'the'; b 1/2
	t 75, 37.5, 'point-'; b 1/2
	t 87.5, 12.5, 'less'; b 1/2
	big_text 1/2, 'FRAGMENTS'
	t 87.5, -25; b 1/2
	t 75, -50; b 1/2
end

transform company do
	vertical_flip
end
then_maybe = tp_chain -100, 0, 1 do
	16.times do |i|
		y = 50-100*i/16
		x = -50+50*sin(PI*i/8)
		i == 0 ? h(x, y, 1/2, 'Then') : d(x, y); b 1/16
	end
	t -50, -50, 'may-'; b 1/2
	t -50, 0, 'be'; b 1/2
end
transform duplicate then_maybe do
	horizontal_flip
	translate -100, 0
	beat_translate 2
end
b 2

transform company do
	horizontal_flip
end
tp_chain 100, 0, 1 do
	t 50, -37.5, 'you'; b 1/2
	t 37.5, -12.5, 'won\'t'; b 1/2
	t 37.5, 25, 'leave'; b 1/2
	t 50, 50, 'me'; b 1/2
	t 75, 37.5, 'so'; b 1/2
	big_text 1, 'DISHEARTENED'
	t 87.5, 12.5; b 1/2
	t 87.5, -25; b 1/2
	t 75, -50; b 1/2
end

def cross x, y
	bg_note x, y
	(1..3).each do |i|
		r = 12.5*sqrt(2)*i
		4.times do |j|
			angle = PI/4 + PI/2*j
			bg_note x + r*cos(angle), y + r*sin(angle)
		end
	end
end
group preserve_beat: false do
	b 1
	11.times { god; b 1 }
	right_wing; god_body; b 1
	cross -75, 0; god_body; b 1
	cross -75, 0; cross 75, 0; b 1
	cross -75, 0; cross 75, 0; cross 0, 25; b 1
end
tp_chain 0, 100, 1, preserve_beat: false do
	h -25, 37.5, 3/2, 'Cha-'; b 2
	t -100, 25, 'llen-'; b 1/2
	t -75, 12.5, 'ging'; b 1/2
	t -50, 0, 'your'; b 1

	h -62.5, -25, 3/2, 'god'; b 3
	t 25, 12.5, 'You'; b 1/2
	t 50, 0, 'have'; b 1/2

	h 75, -12.5, 3/2, 'made'; b 2
	h 87.5, 25, 3/2, 'some'; b 2

	big_text 7/2, 'ILLEGAL ARGUMENTS'
	h -12.5, -12.5, 1/2; b 1
	h -50, 25, 1/2; b 1
	t -75, 50; b 1/2
	t -62.5, -12.5; b 1/2
	t -37.5, 0; b 1/2
	t -12.5, 12.5; b 1/2
end
tp_chain 0, 100, 1 do
	h 100, 0, 3/2; b 2
	h 25, 37.5, 3/2; b 2

	h 62.5, 25, 2; b 3
	t -12.5, -25; b 1/2
	t -37.5, -12.5; b 1/2

	h -62.5, 0, 3/2; b 2
	h -25, 25, 3/2; b 2

	h 0, 50, 2; b 4
end

grid 31
def c_drag x, y, direction, n = 3
	direction = Sunniesnow::Charter::DIRECTIONS[direction] if direction.is_a? Symbol
	group preserve_beat: false do
		f x, y, direction
		(1...n).each do |i|
			b 1/4; d x+12.5*i*cos(direction), y+12.5*i*sin(direction)
		end
	end
end
company = tp_drop -100, 0, 1, preserve_beat: false do
	8.times do |i|
		f -87.5, -37.5, :r; b 1/2
		3.times { t -50, -25*cos(PI*i/2); b 1/2 }
	end
end
transform duplicate company do
	horizontal_flip
	beat_translate 16
end
tp_chain 0, 100, 1 do
	c_drag 12.5, 25, :dr; b 7/2
	c_drag 50, -25, :ur; b 1/2

	b 4-1/4
	c_drag 50, 25, :dl, 2; b 1/4

	b 2
	c_drag 75, 0, :dr, 1; b 3/2
	c_drag 87.5, -37.5, :ul; b 1/2

	b 4-1/2
	c_drag 37.5, -25, :dr, 1; b 1/2

	c_drag -25, 0, :l, 1; b 3/2
	c_drag -75, 12.5, :ur; b 2
	c_drag -12.5, 0, :l, 1; b 1/2

	c_drag -50, 25, :u, 1; b 3/2
	c_drag -62.5, 50, :dl; b 2
	c_drag -100, 0, :dr, 1; b 1/2

	c_drag -75, 25, :r, 1; b 1
	c_drag -62.5, -50, :ur, 1; b 1
	c_drag -37.5, 0, :u, 1; b 3/2
	c_drag 0, 25, :dl; b 1/2

	b 3/2
	c_drag -50, 0, :ul; b 5/2
end

def slash four = false
	tp_chain -100, 100, beat_speed: 150*sqrt(2) do
		f -37.5, 37.5, :dr
		(1..4).each do |i|
			b 1/8
			next if i == 4 && four
			d -37.5+75*i/4, 37.5-75*i/4
		end
	end
end
def slash_cycle
	group do
		4.times do |i|
			big_text 1, 'EXECUTION'
			4.times do |j|
				transform slash do
					rotate PI/2*j*(i == 3 ? -1 : 1)
				end
			end
		end
	end
end
3.times do |i|
	transform slash_cycle do
		rotate -PI/2*i
	end
end

def three x, y, two = false
	group do
		b -1/2
		t x, y; b 1/4
		t x+12.5, y-12.5; b 1/4
		t x+25, y-25 unless two
	end
end
tp_chain -100, 0, 1 do
	big_text 1/4, 'Eins'
	t -62.5, -37.5; b 1
	big_text 1/4, 'Dos'
	three -50, 0; b 1
	big_text 1/4, 'Trois'
	three -37.5, 37.5; b 1
	big_text 1/4, '넷'
	transform(three -37.5, 37.5) { horizontal_flip }; b 1

	big_text 1/4, 'Fem'
	transform(three -50, 0) { horizontal_flip }; b 1
	big_text 1/4, '六'
	three -87.5, 25; b 1
	three -75, 50, true
end
big_text 1, 'EXECUTION'
4.times do |j|
	transform slash true do
		rotate PI/2*j - PI/2
	end
end

if_i_can = group do
	tp_drop 200, 200, 1, preserve_beat: false do
		f -100, 50, :l, 'If'; b 1
		t 0, -50, 'I'; b 1/2
		t -50, 0, 'can'; b 1/2
	end
	tp_chain 0, 100, 1 do
		2.times do
			t 0, 50; b 1/2
			t 100, -50; b 1/2
		end
	end
end
transform duplicate if_i_can do
	horizontal_flip
	beat_translate 2
end
b 2

def z_shape lyrics
	group do
		tp_chain -100, 0, beat_speed: 400, preserve_beat: false do
			t -100, 50; b 1/2
			t 100, 50; b 1/2
		end
		tp_chain -100, 0, beat_speed: 150 do
			t -37.5, 37.5, lyrics[0]; b 1/2
			t 37.5, 37.5, lyrics[1]; b 1/2
		end
		tp_chain -100, 0, beat_speed: 400, preserve_beat: false do
			t -100, -50; b 1/2
			t 100, -50; b 1/2
		end
		tp_chain -100, 0, beat_speed: 150 do
			t -37.5, -37.5, lyrics[2]; b 1/2
			t 37.5, -37.5, lyrics[3]; b 1/2
		end
	end
end
def execution
	group do
		big_text 3/2, 'EXECUTION'
		4.times do |j|
			transform slash true do
				rotate PI/2*j
				scale 50/37.5
			end
		end
	end
end
z_shape %w[give them all the]
execution

then_i_can = group do
	tp_chain 0, -100, 1, preserve_beat: false do
		t 100, -50; b 1/2
		t -25, 0; b 1/2
		t 100, 50; b 1/2
		t -25, 0; b 1/2
	end
	tp_chain 0, -100, 1 do
		16.times do |i|
			y = -50+100*i/16
			x = -100+125*(1-(i/8-1)**2)
			i == 0 ? h(x, y, 1/2, 'Then') : d(x, y); b 1/16
		end
		t -100, 50, 'I'; b 1/2
		t 25, 0, 'can'; b 1/2
	end
end
transform duplicate then_i_can do
	horizontal_flip
	beat_translate 2
end
b 2

transform z_shape %w[be your on- ly] do
	horizontal_flip
end
transform execution do
	vertical_flip
end

def if_i_can_2 lyrics
	group do
		tp_drop 200, 200, 1, preserve_beat: false do
			f 0, 50, :l, lyrics[0]; b 1
			t 100, -50, lyrics[1]; b 1/2
			t 50, 0, lyrics[2]; b 1/2
		end
		tp_chain 0, 100, 1 do
			2.times do
				t -100, 50; b 1/2
				t 0, -50; b 1/2
			end
		end
	end
end
if_i_can_2 %w[If I can]
transform if_i_can_2 %w[have you back] do
	horizontal_flip
end

def double lyrics
	group do
		tp_chain(200, 200, 1) { t -50, -50, lyrics }
		tp_chain(-200, 200, 1) { t 50, -50 }
	end
end
transform(double 'I') { vertical_flip }; b 1/2
double 'will'; b 1/2
transform(double 'run') { rotate PI/2 }; b 1/2
transform(double 'the') { rotate -PI/2 }; b 1/2
transform(execution) { rotate PI/2 }

tp_drop 0, 200, 1 do
	h -75, 0, 1/2, 'Though'
	h 75, 0, 1/2; b 1
end
broken_line [[50,50], [50,-50], [-50,-50], [-50,50], [50,50]], 5/2, 8
we_are_trapped = tp_drop 0, 0, relative: false, speed: 200 do
	t 50, 50; t 50*(2*sqrt(3)-3), -50, 'we'; b 1/2
	t 50, 50; t -50, 50*(2*sqrt(3)-3), 'are'; b 1/2
	bg_note 0, 0, 'trapped'
	notes = tp_chain 0, 0, relative: false, beat_speed: 200 do
		5.times do |i|
			x = 50*(2*sqrt(3)-3) + 100*(2-sqrt(3))*i/4
			y = -50 + 100*i/4
			i == 0 ? f(x, y, :u) : d(x, y); b 1/8
		end
	end
	transform duplicate notes do
		rotate PI/4
		horizontal_flip
		rotate -PI/4
	end
	b 3/8
end
transform duplicate we_are_trapped do
	horizontal_flip
	beat_translate 2
end
b 2
group do
	40.times do |i|
		progress = i/48
		param = 2*PI*progress
		x = (25+75*progress)*cos(3*param)
		y = (37.5+12.5*progress)*sin(2*param)
		#i == 0 ? h(x, y, 5/2, 'ah') : i % 8 == 0 ? t(x, y) : d(x, y); b 1/16
		i == 0 ? h(x, y, 5/2, 'ah') : d(x, y); b 1/16
		t(-x, y) if i % 8 == 0 && i > 0
	end
	b 1/2
end

def pattern lyrics
	group do
		i_ve_studied = group do
			tp_drop 200, 200, 1, preserve_beat: false do
				f -100, 50, :l, lyrics[0]; b 1/2
				t 0, 50/3; b 1
				t -100, -50, lyrics[2]; t 0, -50; b 1/2
			end
			tp_drop -200, 200, 1 do
				t 100, 50; b 1
				t 0, -50/3, lyrics[1]; t 100, -50/3; b 1
			end
		end
		transform duplicate i_ve_studied do
			horizontal_flip
			beat_translate 2
		end
		b 2

		five = tp_drop -200, -200, 1 do
			t -50, 50, lyrics[3]; b 1/2
			t 50, 50, lyrics[4]; b 1/2
			t -100, 50, lyrics[5]; b 1/2
			t 100, 50, lyrics[6]; b 1/2
			t 0, 50, lyrics[7]; b 1/2
		end
		transform duplicate five do
			vertical_flip
		end.tap { |notes| notes.each { _1[:text] = '' if _1[:text] } }
	end
end
def love
	group preserve_beat: false do
		big_text 1/2, 'LO-'; b 1/2
		big_text 1/2, 'LO-O-'; b 1/2
		big_text 1/2, 'LO-O-OVE'; b 1/2
	end
	half = group do
		12.times do |i|
			t = 2*i/11
			s = 1-t <=> 0
			t = sin(PI/2*sqrt([t,2-t].min))**2
			x = 62.5 * t**2
			y = -10+40 * (t+s*sqrt(1-t**4))
			d x, y; b 1/16
			b 1/4 if i % 4 == 3
		end
	end
	transform duplicate half[1...-1] do
		horizontal_flip
	end
end
pattern(%w[I've stu- died how to pro- per- ly])
love

transform pattern(%w[Ques- tion me I can an- swer all]) do
	horizontal_flip
end
love

tp_drop 0, 200, 1 do
	b -1/16; h -75, 0, 1/2, 'I'; b 1/16; h 75, 0, 1/2; b 1
end
%w[know the al- ge- bra- ic].each_with_index do |text, i|
	angle = PI/2 - PI/3*i
	tp_drop 200*cos(angle+PI/2), 200*sin(angle+PI/2), 1 do
		t 50*cos(angle), 50*sin(angle), text
		t 50*cos(angle+2*PI/3), 50*sin(angle+2*PI/3)
		b 1/2
	end
end

tp_drop 0, 200, 1 do
	t -75, 0; t 75, 0, 'ex-'; b 1/2
	t 0, 0; b 1/2
end
%w[pre- ssion of].each_with_index do |text, i|
	angle = PI/2 - 2*PI/3*i
	tp_drop 200*cos(angle+PI/2), 200*sin(angle+PI/2), 1 do
		t 50*cos(angle), 50*sin(angle), text
		t 50*cos(angle+2*PI/3), 50*sin(angle+2*PI/3)
		b 1/2
	end
end
love

tp_drop 0, 200, 1 do
	h -75, 0, 1/2, 'Though'; h 75, 0, 1/2; b 1
end
tp_chain -25, -50, relative: false, relative_beat: 1/2 do
	t -50, 50, 'you'
end
tp_chain 25, 50, relative: false, relative_beat: 1/2 do
	t 50, 50; b 1/2
end
tp_drop 0, 50, relative: false, relative_beat: 1/2 do
	t -25, -50, 'are'
	t 25, -50; b 1/2
end
h 0, 37.5, 1/2, 'free'; b 1/8
(1...8).each do |i|
	x = 100*i/8
	y = sin(3*PI*i/8)/(3*PI*i/8)*37.5
	d x, y; d -x, y; b 1/8
end
tp_drop 0, 200, 1 do
	t -100, 0; t 100, 0, 'I'; b 1/2
	t -50, 0; t 50, 0, 'am'; b 1/2
end

broken_line [[37.5, 37.5], [37.5, -37.5], [-37.5, -37.5], [-37.5, 37.5], [37.5, 37.5]], 2, 7
tp_drop 0, 0, relative: false, relative_beat: 1 do
	f -37.5, 37.5, :dr, 'trapped'; f 37.5, 37.5, :dl; b 1
	f -37.5, -37.5, :ur; f 37.5, -37.5, :ul, 'trapped'; b 1
end
t 0, 0, 'in'; b 1/2
love

15.times do |i|
	notes = group do
		t -50, -25; b 1/4
		t -12.5, -12.5; b 1/4
		t -62.5, 0; b 1/4
		t 0, 12.5; b 1/4
		f -75, 25, :l; b 1/2
		t 37.5, -50; b 1/4
		t 25, -37.5; b 1/4
	end
	transform(notes) { horizontal_flip } if i.odd?
end
group preserve_beat: false do
	b 3/4; t 0, 0
end
transform(execution) { rotate -PI/2; horizontal_flip }

end
