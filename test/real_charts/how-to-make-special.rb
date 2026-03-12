include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title 'How to make 音ゲ～曲!'
artist 'F Rabbeat & mustard'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '13'

offset 0.048
bpm 185

=begin
b 2
t 0, 0; b 1
t 0, 0; b 1/2
t 0, 0; b 1/4
t 0, 0; b 1/4
=end
b 4

group preserve_beat: false do
	b 2-1/4
	bg_note 0, 4, 'Hi'; b 3/4
	bg_note 2, 4, 'guys'; b 3/2

	b 2/3
	bg_note 0, 2, ?と; bg_note 2, 2, ?ぅ; b 1/3+1/2
	bg_note 4, 2, ?で; bg_note 6, 2, ?ぃ; b 3/2
	bg_note 0, 0, ?あ; bg_note 2, 0, ?い; b 1

	bg_note 4, 0, ?う; bg_note 6, 0, ?ぃ; bg_note 8, 0, ?る; b 2
	bg_note 0, -2, ?し; bg_note 2, -2, ?ょ; b 4/3
	bg_note 4, -2, ?ゆ; bg_note 6, -2, ?ー; b 2/3

	b 1
	bg_note 0, -4, ?ほ; bg_note 2, -4, ?う; b 3

	b 1/4
	bg_note 4, -4, ?と; bg_note 6, -4, ?ぅ; b 5/4
	bg_note 0, 4, ?ま; bg_note 2, 4, ?っ; b 9/4
	bg_note 0, 2, ?ま; bg_note 2, 2, ?い; b 1/4
	
	b 3/2
	bg_note 0, 0, ?ま; b 1/2
	bg_note 2, 0, ?け; b 3/2
	bg_note 0, -2, ?え; bg_note 2, -2, ?ぇ; b 1/2

	5.times do |i|
		bg_note -2+i*2, -4, ?～; b 1/4
	end
	b 5/4
	bg_note -7, 2, 4+3/2, ?英; b 1
	bg_note -5, 2, 4+1/2, ?語; b 1/4
	bg_note -3, 2, 4+1/4, ?わ; b 1/4

	bg_note -1, 2, 4, ?か; b 1/4
	bg_note 1, 2, 4-1/4, ?ら; b 1/4
	bg_note 3, 2, 4-2/4, ?ん; b 1/4
	bg_note 5, 2, 4-3/4, ?か; b 1/4
	bg_note 7, 2, 4-1, ?ら; b 1/4
	bg_note -3, -2, 4-5/4, ?日; b 3/4
	bg_note -1, -2, 2, ?本; b 1/2
	bg_note 1, -2, 3/2, ?語; b 1/4
	bg_note 3, -2, 5/4, ?で; b 1/4
	b 1
end

def tl y, durations, hold_duration = durations.sum
	tp_none do
		h -8, y, hold_duration if hold_duration > 0
	end
	durations.each do |delta|
		d -8, y; b delta
	end
end
tp_drop 8, 0, 1 do
	tl 0, [
		5/2, 3/2,

		1, 3,
	]

	tl -2, [
		5/2, 1, 1/2,

		1, 1,
	]
	tl 2, [
		1/2, 3/2,
	]

	tl 3, [
		5/2, 3/2,

		1, 3,
	], 14
end

tp_drop 8, 0, 2 do
	b 1/3
	tl 1, [7/2-1/3], 0
	tl 0, [1/2], 0

	b 4
end

group preserve_beat: false do
	b 2
	bg_note -1, 2, ?ん; bg_note 1, 2, ?っ; b 1
	bg_note -2, -2, ?ん; bg_note 0, -2, ?ん; bg_note 2, -2, ?っ; b 1

	b 3/2
	bg_note 8, 4, ?今; bg_note 8, 2, ?日; b 3/4
	bg_note 8, 0, ?は; bg_note 6, 4, ?オ; b 3/4
	bg_note 6, 8/3, ?タ; b 1/2
	bg_note 6, 4/3, ?ク; b 1/2

	bg_note 6, 0, ?く; bg_note 6, -4/3, ?ん; b 1/2
	bg_note 6, -8/3, ?達; b 3/4
	bg_note 6, -4, ?に; b 2
	bg_note -6, 4, ?音; b 3/4

	b 1/6
	bg_note -6, 2, ?ゲ; bg_note -6, 0, ?｜; b 1/2
	bg_note -6, -2, ?曲; b 5/6
	bg_note -6, -4, ?の; b 1/3
	bg_note -8, 4, ?作; b 2/3
	bg_note -8, 2, ?り; b 1/3
	bg_note -8, 0, ?方; b 5/6
	bg_note -8, -2, ?を; b 1/3

	bg_note -7, 1, ?教; b 1/2
	bg_note -5, 1, ?え; b 1/2
	bg_note -3, 1, ?ち; bg_note -1, 1, ?ゃ; b 1/2
	bg_note  1, 1, ?い; b 1/2
	bg_note  3, 1, ?ま; bg_note 5, 1, ?ー; b 3/2
	bg_note  7, 1, ?す; b 1/2

	b 3/2
	big_text 1, 'いえ～～～い'; b 2
	big_text 1, 'いえ～～～い'; b 1/2

	b 4

	bg_note -8, -4, ?え; bg_note -6, -4, ?っ; b 1/2
	bg_note -4, -4, ?誰; b 5/6
	bg_note -2, -4, ?も; b 1/3
	bg_note  0, -4, ?喜; b 1/3
	bg_note  2, -4, ?ん; b 1/2
	bg_note  4, -4, ?で; b 1/4
	bg_note  6, -4, ?な; bg_note 8, -4, ?い; b 5/4
end

def diag_flick bg_pattern = true
	group do
		checkerboard 1/2 if bg_pattern
		tp_chain 8, 8, 1 do
			f -3, -3, :dl
		end
		tp_chain -8, -8, 1 do
			f 3, 3, :ur
		end
	end
end
diag_flick; b 1
t -1, 0; b 1/4
t 1, 0; b 1/4
transform(diag_flick) { vertical_flip }; b 5/2

b 7/2
t 0, 0; b 1/2

diag_flick; b 1
t 1, 0; b 1/4
t -1, 0; b 1/4
transform(diag_flick) { vertical_flip }; b 5/2

b 3
notes = group do
	t -1, 1; b 1/2
	t -1, -1; b 1/2
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/4 }

transform(diag_flick) { vertical_flip }; b 1
t 0, 0; b 1/2
diag_flick; b 1
t 0, 2; b 1/2
t -2, 0; t 2, 0; b 1/2
t 0, -2; b 1/2

tp_chain 8, 0, 1, preserve_beat: false do
	t 2, -4; b 1
	f 4, 0, :r; b 3/2
	t 3, 2; b 1
	t 2, -1; b 1/2
end
tp_chain -8, 0, 1 do
	t -2, -3; b 1
	t -3, -1; b 1/2
	t -4, 1; b 3/2
	f -6, 2, :l; b 1
end

transform(diag_flick false) { vertical_flip }; b 1
t 0, 0; b 1/2
diag_flick; b 1
notes = tp_chain 0, 8, 1 do
	t -2, 2; b 1/2
	t -3, 0; b 1/2
	t -2, -2; b 1/2
end
transform(duplicate notes) { horizontal_flip }

tp_chain 0, 8, 1 do
	24.times do |i|
		angle = - (PI/2+2*PI)*i/24
		r = 2 + 8*(i/24-1/2)**2
		x, y = r*cos(angle)*2-2, r*sin(angle)
		i.zero? ? h(x, y, 3) : d(x, y); b 1/8
	end
end
b 1

def tategaki x, y, height, data
	dy = [2, height/(data.sum { |text, delta| text&.size || 0 } - 1)].min
	data.reduce 0 do |i, (text, delta)|
		text&.each_char do |c|
			bg_note x, y-dy*i, c
			i += 1
		end
		b delta
		i
	end
end
def yokogaki x, y, width, data, sep = true
	if sep
		free_char = data.sum { |text, delta| text&.size || 0 }
	else
		free_char = data.sum { |text, delta| text ? 1 : 0 }
	end
	dx = [2, width/(free_char - 1)].min
	data.reduce 0 do |i, (text, delta, duration)|
		duration ||= 0
		if sep
			text&.each_char do |c|
				bg_note x+dx*i, y, duration, c
				i += 1
			end
		elsif text
			bg_note x+dx*i, y, duration, text
			i += 1
		end
		b delta
		i
	end
end
group preserve_beat: false do
	yokogaki -3, 4, 11, [
		['レー', 3/4], [?ト, 1/4], [?５, 1/3], ['０００', 1/3], [?兆, 1/3], [?の, 1/3],
	]
	yokogaki 0, 2, 8, [
		[?音, 2/3], [?暴, 1/4], [?流, 1/4], [?舞, 1/2],

		[?皆, 1/2], [?伝, 1/2], [?の, 1/2],
	]
	yokogaki 4, 0, 4, [
		[?超, 1/2], [?音, 2/3], ['ゲー', 1/3],
	]
	yokogaki -8, 0, 6, [
		[?う, 1/3], [?ま, 1/3], ['ちゅ', 1/3],

		[?で, 1/3]
	]
	yokogaki -8, -2, 8, [
		[?あ, 1/3], [?る, 1/3], [?こ, 5/4], [?の, 1/4], [?私, 3/4], [?が, 3/4],
	]

	b 1/2
	yokogaki -8, 4, 16, [
		[?直, 1], [?々, 3/4], [?に, 1/4], [?教, 5/6], [?え, 1/3], [?て, 1/3],

		[?あ, 1/4], [?げ, 1/4], [?る, 1/4], ['るん', 1/4], [?だ, 1/4], ['から', 1/4], ['から', 3/2],
	]
	yokogaki -8, 2, 16, [
		[?覚, 1],

		[?悟, 1/2], [?し, 1/4], [?て, 1/4], [?聞, 1/3], [?き, 1/3], [?き, 1/3], ['さい', 2]
	]

	tategaki 8, 4, 8, [
		[?そ, 1/2], [?れ, 1/2], ['じゃ', 1],
	]
	tategaki 6, 4, 8, [
		[?ま, 1/4], [?ず, 1/4], [?は, 1/2],
	]
	tategaki 4, 4, 8, [
		[?ノ, 1/4], [?リ, 1/4], [?ノ, 1/4], [?リ, 1/4],
	]

	tategaki 2, 4, 8, [
		['ベー', 1], [?ス, 1/2],
	]
	tategaki 0, 4, 8, [
		[?ド, 1/2], [?ロ, 1], ['ップ', 1],
	]
end

group preserve_beat: false do
	16.times do |i|
		angle = PI/2 + PI/16 + 2*PI* i/16
		x, y = 3*cos(angle), 3*sin(angle)
		t_angle = (angle/(PI/4)).round * PI/4 + PI
		t_x, t_y = 8*cos(t_angle), 8*sin(t_angle)
		tp_chain t_x, t_y, 1 do
			t x, y; b 1
		end
	end
end

tp_drop -8, 0, 1 do
	5.times do |i|
		angle = -PI/2 - PI/4*i
		x, y = 4*cos(angle) - 4, 4*sin(angle)
		h x, y, 1/2; b 3/2
	end
	b 1/2
end

tp_drop 8, 0, 1 do
	([3/2]*4 + [1]*2 + [0]).reduce PI/2 do |angle, delta|
		x, y = 4*cos(angle) + 4, 4*sin(angle)
		delta.zero? ? t(x, y) : h(x, y, 1/2); b delta
		angle - PI/4 / (3/2) * delta
	end
end

def three x, y, angle
	dx, dy = 2*cos(angle), 2*sin(angle)
	tp_chain -dx*4, -dy*4, 1 do
		t x, y; b 1/2
		t x+dx, y+dy; b 1/2
		t x+2*dx, y+2*dy
	end
end

three 3*cos(PI/2+PI/16), 3*sin(PI/2+PI/16), -3*PI/4
three 4, 3, -3*PI/4
three -7, 0, -PI/4
three 5, -1, -PI/4

three -2, -4, PI/4
three 4, -3, PI/4
three 0, 1, 3*PI/4
three 8, 3, -3*PI/4

group preserve_beat: false do
	tp_drop 0, -8, 1 do
		8.times.reverse_each do |i|
			b 1/2
			x = (8-4/sqrt(2) - -8)*i/8 + -8
			y = 3-4/sqrt(2) - 12*(i/8 - 1/2)**2 + 3
			i.zero? ? f(x, y, :r) : t(x, y)
		end
	end
end
tp_drop 0, 8, 1 do
	8.times do |i|
		b 1/4
		x = -8 + 14*i/8
		y = 9*(i/8 - 2/3)**2 - 4
		t x, y
		b 1/4
	end
end

group preserve_beat: false do
	(1..4).each { big_text 1/2, _1.to_s; b 1 }
end

tp_chain -8, 0, 1 do
	b 2
	t -4, -3; b 1/2
	t 3, -2; b 1/4
	t 1, -3; b 1/4
	f 3, -4, :ur; b 1
end

diamond_grid 1/2
tp_chain 0, 8, 1 do
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? f(x, y, :d) : d(x, y); b 1/8
	end
end
b 1/2
7.times do |i|
	x = i<4 ? 7-4*i : -5+4*(i-3)
	y = 3-i/2
	tp_chain -8, 8, 1 do
		t x, y; b 1/4
	end
	x -= 2/sqrt(2)
	y -= 2/sqrt(2)
	angle = -PI/4 - PI/2 * i/6
	tp_chain -8, 8, 1 do
		t x, y; b 1/4
		x += 2*cos(angle)
		y += 2*sin(angle)
		t x, y; b 1/2
	end
end

tp_chain 0, 8, 1 do
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
b 1/2
5.times do |i|
	x = i<4 ? -7+4*i : 5-4*(i-3)
	y = 3-i/2
	tp_chain 8, 8, 1 do
		t x, y; b 1/4
	end
	x += 2/sqrt(2)
	y -= 2/sqrt(2)
	angle = -3*PI/4 + PI/2 * i/6
	tp_chain 8, 8, 1 do
		t x, y; b 1/4
		x += 2*cos(angle)
		y += 2*sin(angle)
		t x, y; b 1/2
	end
end
tp_drop 8, 8, 1 do
	t -3, 0; t 7, -3; b 3/4
end
tp_drop -8, 8, 1 do
	t 5, 1; t -5, -2; b 3/4
end
tp_drop 0, -8, 1 do
	t -6, 2; t 1, 2; b 1/2
end

b -4
yokogaki -4, -4, 8, [
	[?掴, 1], [?み, 1/2], [?が, 1/2], [?肝, 1], [?心, 1]
]

def tri_f x, y
	tp_chain 8, -8, 1 do
		bg_note x-1, y+1, ?イ
		f x, y, :ul, ?ハ; b 1/4
	end
	tp_chain 8, -8, 1 do
		t x+1, y+2; b 1/4
		t x-1, y+3; b 1/2
	end
end
def tri x, y
	tp_chain -8, 8, 1 do
		t x, y; b 1/4
	end
	tp_chain -8, 8, 1 do
		t x-1, y-2; b 1/4
		t x+1, y-3; b 1/2
	end
end

tp_chain 0, 8, 1 do
	diamond_grid 1/2
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? f(x, y, :d) : d(x, y); b 1/8
	end
end
b 1/2
tri_f -5, 0
tri 3, 2
tri_f -3, -1

tri 5, 1
tri_f -6, -1
tri 7, 2
tri_f -7, -3

tp_chain 0, 8, 1 do
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
b 1/2
notes = group do
	tri_f -5, 0
	tri 3, 2
	tri_f -6, -2
end
transform(notes) { horizontal_flip}

def yokogaki_c x, y, data, sep = true
	if sep
		width = (data.sum { |text, delta| text&.size || 0 }-1)*2
	else
		width = data.sum { |text, delta| text ? 2 : 0 } - 2
	end
	yokogaki x-width/2, y, width, data, sep
end
group preserve_beat: false do
	yokogaki_c 0, 4, [
		['ボー', 1/2], [?カ, 1/4], [?ル, 1/4]
	]
	yokogaki_c 0, 5/2, [
		['チョ', 1/2], ['ップ', 1/4]
	]
	yokogaki_c 0, 1, [
		[?を, 1/4], [?入, 1/4], [?れ, 1/4], [?る, 1/4], [?と, 1/4]
	]
	yokogaki_c 0, -1/2, [
		['いい', 1/2], [?ら, 1/2], ['しい', 0]
	]
end

notes = tp_drop -8, 0, 1 do
	t -7, 4; b 1
	t -8, -2; b 1
	t -6, 1; b 1
	t -4, -3; b 1/2
end
transform(duplicate notes) { horizontal_flip; translate 0, -1 }
tp_chain 0, 8, 1 do
	f -1, -3, :ul; b 1/4
	f 1, -3, :ur; b 1/4

	grid 15
	4.times do |i|
		x, y = 0, -4+2*i
		i.zero? ? f(x, y, :u) : d(x, y); b 1/8
	end
	b 1/2
end
def side_drop data
	tp_drop -24, 0, 2 do
		data.each do |y, delta|
			t 8, y if y; b delta
		end
	end
end
side_drop [
	[3, 1],
	[0, 1/2], [0, 1/4], [0, 1/4],
	[nil, 1/2], [0, 1/2],

	[nil, 1/2], [3, 1/2],
	[0, 1/2], [0, 1/4], [0, 1/4],
	[3, 1/2], [0, 1/4], [0, 1/4],
	[-3, 1],

	[nil, 1/2], [3, 1/2],
	[3, 1/2], [0, 1/4], [0, 1/4],
	[3, 1/2], [0, 1/4], [0, 1/4],
	[3, 1/2], [3, 1/2],

	[3, 1/2], [3, 1/2],
	[nil, 1/2], [0, 1/2],
	[-3, 1/2], [-3, 1/2],
	[0, 1/4], [0, 1/4], [0, 1/2],
]

grid 12
tp_chain 0, -8, 1 do
	4.times do |i|
		x, y = 0, -4+2*i
		i.zero? ? f(x, y, :u) : d(x, y); b 1/8
	end
end
b 1/2
notes = side_drop [
	[3, 1],
	[0, 1/2], [0, 1/4], [0, 1/4],
	[nil, 1/2], [0, 1/2],

	[nil, 1/2], [3, 1/2],
	[0, 1/2], [0, 1/4], [0, 1/4],
	[3, 1/2], [0, 1/4], [0, 1/4],
	[-3, 1/2], [-3, 1/2],

	[0, 1/2], [0, 1/2],
	[0, 1/2], [0, 1/2],
	[0, 1/2], [0, 1/2],
	[0, 1/4], [0, 1/4], [0, 1/4], [0, 1/4],
]
transform(notes) { horizontal_flip }

b -28

notes = group do
	b 1
	7.times do |i|
		x = i<4 ? 7-4*i : -5+4*(i-3)
		y = 3-i/2
		bg_note x, y; b 1/4
		x -= 2/sqrt(2)
		y -= 2/sqrt(2)
		angle = -PI/4 - PI/2 * i/6
		bg_note x, y; b 1/4
		x += 2*cos(angle)
		y += 2*sin(angle)
		bg_note x, y; b 1/2
	end
end

transform(duplicate notes) do
	horizontal_flip
	beat_translate 8
end
transform(duplicate notes) do
	beat_translate 16
end
b 16

16.times do |i|
	x = 8-16*i/16
	y = (-9*(1-i/16)**2 + 12*(1-i/16))*-(-1)**i
	bg_note x, y, (1-i/16)*8; b 1/4
end

group preserve_beat: false do
	yokogaki -4, 0, 10, [
		[?次, 1],
		[?の, 1/3], [?ス, 1/3], [?テ, 1/3],
		['ップ', 1/3], [?い, 2/3],
		[?く, 1/3], [?よ, 2/3],
	]

	yokogaki -8, 4, 16, [
		[nil, 3/4], ['さぁ', 5/4], [?こ, 1/2], [?こ, 1/2],
		[?か, 1/2], [?ら, 1/2],
		
		[?本, 1/2], [?番, 1],
	]
	yokogaki -8, 2, 16, [
		[?ス, 1/2], [?コ, 1/3], [?ア, 1/3], [?を, 1/3],
	]
	yokogaki -8, 0, 16, [
		[?取, 3/8], [?ら, 3/8], [?せ, 1/4],

		[?な, 1/3], [?い, 1/3], [?た, 1/3],
		[?め, 1/3], [?の, 1/3],
	]
	yokogaki -8, -2, 16, [
		[?リ, 1/3], [?ズ, 1/3], [?ム, 1/3], [?難, 5/6],
	]
	yokogaki -8, -4, 16, [
		[?ダ, 1/2],

		[?ブ, 1/3], [?ス, 1/3], [?テ, 1/3],
		[?地, 1/3], [?帯, 2/3],
		[?だ, 2/3], [?～, 2/3], [?～, 2/3],
	]
end

tp_chain 24, 0, 2 do
	0.upto 16 do |i|
		x = -8+16*i/16
		y = (-9*(i/16)**2 + 12*(i/16))*-(-1)**i
		if i == 16
			f x, y, :u
		else
			t x, y; b 1/4
		end
	end
end

tp_drop 8, 0, 1 do
	20.times do
		d 8, 0; b 1/2
	end
	8.times do
		d 8, 0; b 1/4
	end
	d 8, 0
end

diamond_grid 3
b 4

def bezier n, x1, y1, x2, y2, x3, y3, x4, y4
	n.times do |i|
		t = i/n
		x = (1-t)**3*x1 + 3*(1-t)**2*t*x2 + 3*(1-t)*t**2*x3 + t**3*x4
		y = (1-t)**3*y1 + 3*(1-t)**2*t*y2 + 3*(1-t)*t**2*y3 + t**3*y4
		yield x-8, 4-y, i
	end
end

bezier 8, 5.53, 0.62, 8.67, 9.09, -0.18, 8.89, 2.26, 4.94 do |x, y, i|
	if i.zero?
		h x, y, 1, ?ぎ
		bg_note x+2, y, ?ゅ
		bg_note x+4, y, ?ん
	else
		d x, y
	end
	b 1/8
end
bezier 8, 5.13, 3.84, 10.21, -0.27, 17.89, 0.67, 14.72, 4.77 do |x, y, i|
	if i.zero?
		h x, y, 1, ?わ
		bg_note x+2, y, ?ん
	else
		d x, y
	end
	b 1/8
end
[[65.7, 19.7], [36.8, 8.0], [-5.7, 9.5], [-55.9, 22.9]].each do |x, y|
	x /= 12.5; y /= 12.5
	f x, y, :dr, ?わ; b 1/4
	d x+2, y-2; b 1/4
end

[
	[1.13, 6.93, 3.59, 5.64, 4.68, 3.28, 2.61, 0.63],
	[5.43, 6.55, 7.80, 6.10, 7.97, 1.84, 4.56, 1.51],
	[10.77, 5.97, 11.66, 3.94, 9.94, 1.77, 7.90, 2.78],
	[14.71, 5.77, 16.29, 3.78, 12.55, 2.94, 9.22, 4.67],
].each_with_index do |points, j|
	bezier 8, *points do |x, y, i|
		if i.zero?
			if j.zero?
				t x, y, ?ぎ
				bg_note x+1, y-1, ?ょ
				bg_note x+2, y, ?う
			else
				t x, y, ?お
				bg_note x+1, y-1, ?う
			end
		else
			d x, y
		end
		b 1/8
	end
end

[
	[-85.4, 32.3, :dl],
	[-32.4, 7.6, :ur],
	[-72.7, -17.5, :d],
	[-3.2, 33.6, :r],
	[-9.2, -38.5, :l],
	[53.7, -36.3, :r],
	[27.0, -6.1, :ul],
	[78.8, 16.8, :dr],
].each do |x, y, direction|
	x /= 12.5; y /= 12.5
	angle = Sunniesnow::Charter::DIRECTIONS[direction]
	bg_note x-sqrt(2)*cos(angle), y-sqrt(2)*sin(angle), ?ょ
	f x, y, direction, ?じ; b 1/4
	d x+sqrt(2)*cos(angle), y+sqrt(2)*sin(angle); b 1/4
end

group preserve_beat: false do
	32.times do |i|
		x = -8+16*((1-i/32)**2 + 1-i/32)/2
		y = (2+2*i/32)*-cos(i/32 * 4*PI)
		if i.zero?
			h x, y, 4, ?ぎ
			bg_note x, y+2, ?ゃ
			bg_note x, y+4, ?｜
		else
			d x, y
		end
		b 1/8
	end
end
b 1
[
	[11.24, 7.27, 12.60, 6.99, 13.52, 6.22, 13.02, 4.27],
	[7.72, 0.67, 9.74, 0.25, 10.97, 0.79, 10.44, 2.57],
	[3.30, 6.78, 4.65, 5.17, 6.80, 4.70, 8.67, 4.89]
].each do |points|
	bezier 4, *points do |x, y, i|
		if i.zero?
			t x, y, ?ぎ
			bg_note x+2, y, ?ゃ
			bg_note x+4, y, ?ー
		else
			d x, y
		end
		b 1/8
	end
	b 1/2
end

second_dubstep = group do
	bezier 8, 5.53, 0.62, 8.67, 9.09, -0.18, 8.89, 2.26, 4.94 do |x, y, i|
		if i.zero?
			h x, y, 1, ?ぎ
			bg_note x-2, y, ?ゅ
			bg_note x-4, y, ?ん
		else
			d x, y
		end
		b 1/8
	end
	bezier 8, 5.13, 3.84, 10.21, -0.27, 17.89, 0.67, 14.72, 4.77 do |x, y, i|
		if i.zero?
			h x, y, 1, ?わ
			bg_note x-2, y, ?ん
		else
			d x, y
		end
		b 1/8
	end
	[[65.7, 19.7], [36.8, 8.0], [-5.7, 9.5], [-55.9, 22.9]].each do |x, y|
		x /= 12.5; y /= 12.5
		f x, y, :dr, ?わ; b 1/4
		d x+2, y-2; b 1/4
	end
	
	[
		[1.13, 6.93, 3.59, 5.64, 4.68, 3.28, 2.61, 0.63],
		[5.43, 6.55, 7.80, 6.10, 7.97, 1.84, 4.56, 1.51],
		[10.77, 5.97, 11.66, 3.94, 9.94, 1.77, 7.90, 2.78],
		[14.71, 5.77, 16.29, 3.78, 12.55, 2.94, 9.22, 4.67],
	].each_with_index do |points, j|
		bezier 8, *points do |x, y, i|
			if i.zero?
				if j.zero?
					t x, y, ?ぎ
					bg_note x-1, y+1, ?ょ
					bg_note x, y+2, ?う
				else
					t x, y, ?お
					bg_note x-1, y+1, ?う
				end
			else
				d x, y
			end
			b 1/8
		end
	end
	
	[
		[-85.4, 32.3, :dl],
		[-32.4, 7.6, :ur],
		[-72.7, -17.5, :d],
		[-3.2, 33.6, :r],
		[-9.2, -38.5, :l],
		[53.7, -36.3, :r],
		[27.0, -6.1, :ul],
		[78.8, 16.8, :dr],
	].each do |x, y, direction|
		x /= 12.5; y /= 12.5
		angle = Sunniesnow::Charter::DIRECTIONS[direction]
		bg_note x-sqrt(2)*cos(angle), y-sqrt(2)*sin(angle), ?ょ
		f x, y, direction, ?じ; b 1/4
		d x+sqrt(2)*cos(angle), y+sqrt(2)*sin(angle); b 1/4
	end
end
transform(second_dubstep) { horizontal_flip }

tp_drop -8, 8, 1, preserve_beat: false do
	t -2, 4; b 3/4
	t 2, 3; t -4, -2; b 3/4
	t 5, 1; t 1, -4; b 1/2
end
tp_chain -8, 8, 1 do
	bg_note -4, 0, ?も; b 2/3
	bg_note -2, 0, ?う; b 1/3
	bg_note 0, 0, ?一; b 1
	t 2, 0, ?回; b 1/2
	t -1, 1, 'Le'; b 1/4
	t -3, 2, "t's"; b 1/4
	f -5, 3, :u, 'go'
end
tp_chain 8, -8, 1 do
	f 3, 4, :d; b 1
end

slides = group preserve_beat: false do
	8.times do |i|
		x = 2*sqrt(3) * i/8
		y = 4-6*i/8
		i.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
	end
end
transform(duplicate slides) { horizontal_flip; beat_translate 1 }
f -2*sqrt(3), -2, :l, ?ぎ; bg_note -2*sqrt(3)+1, -3, ?ゅ; bg_note -2*sqrt(3)+2, -2, ?ん; b 1
f 2*sqrt(3), -2, :r, ?わ; bg_note 2*sqrt(3)+2, -2, ?ん; b 1
hexagram 1/2; t -2*sqrt(3), -2; t 0, 4; bg_note 1, -1/sqrt(3), ?わ; b 3/4
hexagram 1/2; t 2*sqrt(3), -2; t 0, 4; bg_note -1, -1/sqrt(3), ?わ; b 3/4
hexagram 1/2; t -2*sqrt(3), -2; t 2*sqrt(3), -2; bg_note 0, 2/sqrt(3), ?わ; b 1/2

slides = group preserve_beat: false do
	8.times do |i|
		x = -2*sqrt(3) * i/8
		y = -4+6*i/8
		i.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
	end
end
transform(duplicate slides) { horizontal_flip; beat_translate 1 }
f 2*sqrt(3), 2, :r, ?ぎ; bg_note 2*sqrt(3)+1, 1, ?ょ; bg_note 2*sqrt(3)+2, 2, ?う; b 1
f -2*sqrt(3), 2, :l, ?お; bg_note -2*sqrt(3)+2, 2, ?う; b 1
hexagram 1/2; t 2*sqrt(3), 2; t 0, -4; bg_note -1, 1/sqrt(3), ?お; bg_note -2, 2/sqrt(3), ?う; b 3/4
hexagram 1/2; t -2*sqrt(3), 2; t 0, -4; bg_note 1, 1/sqrt(3), ?お; bg_note 2, 2/sqrt(3), ?う; b 3/4
hexagram 1/2; t 2*sqrt(3), 2; t -2*sqrt(3), 2; bg_note 0, -2/sqrt(3), ?お; bg_note 0, -4/sqrt(3), ?う; b 1/2

f -4/sqrt(3), 4, :dl, ?じ; bg_note -4/sqrt(3)-1, 4-sqrt(3), ?ょ; b 1/4
d -4/sqrt(3)-1/2, 4-sqrt(3)/2; b 1/4
f 4/sqrt(3), -4, :ur, ?じ; bg_note 4/sqrt(3)+1, -4+sqrt(3), ?ょ; b 1/4
d 4/sqrt(3)+1/2, -4+sqrt(3)/2; b 1/4
f -4/sqrt(3), -4, :ul, ?じ; bg_note -4/sqrt(3)-1, -4+sqrt(3), ?ょ; b 1/4
d -4/sqrt(3)-1/2, -4+sqrt(3)/2; b 1/4
f 4/sqrt(3), 4, :dr, ?じ; bg_note 4/sqrt(3)+1, 4-sqrt(3), ?ょ; b 1/4
d 4/sqrt(3)+1/2, 4-sqrt(3)/2; b 1/4
hexagon 1/2; t 0, 0, ?じ; bg_note 0, -sqrt(3), ?ょ; b 1/2
t 4/sqrt(3)+1, 4-sqrt(3); b 1/4
hexagon 1/2; t 4/sqrt(3), 4, ?じ; bg_note 4/sqrt(3)+2, 4, ?ょ; t -4/sqrt(3), -4; b 1/2
t -4/sqrt(3)-1, 4-sqrt(3); b 1/4
hexagon 1/2; t -4/sqrt(3), 4, ?じ; bg_note -4/sqrt(3)-2, 4, ?ょ; t 4/sqrt(3), -4; b 1/2

notes = group preserve_beat: false do
	8.times do |i|
		x = 8/sqrt(3) - (i/8-1/2).abs*8/sqrt(3)
		y = 4-8*i/8
		i.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1 }
f -4/sqrt(3), -4, :l, ?ぎ; bg_note -4/sqrt(3)-1, -3, ?ゃ; bg_note -4/sqrt(3)-2, -4, ?ー; b 1
f 4/sqrt(3), -4, :r, ?ぎ; bg_note 4/sqrt(3)+1, -3, ?ゃ; bg_note 4/sqrt(3)+2, -4, ?ー; b 1
hexagon 1/2; f 4/sqrt(3), 4, :d; bg_note 4/sqrt(3)+1, 3, ?ゃ; bg_note 4/sqrt(3)+2, 4, ?ー; f -4/sqrt(3), -4, :u; b 3/4
hexagon 1/2; f -4/sqrt(3), 4, :d; bg_note -4/sqrt(3)-1, 3, ?ゃ; bg_note -4/sqrt(3)-2, 4, ?ー; f 4/sqrt(3), -4, :u; b 3/4
yokogaki -sqrt(3), 0, 2*sqrt(3), [['ぎゃー', 0]]
hexagon 1/2; t -8/sqrt(3), 0; t 8/sqrt(3), 0; b 1/2

slides = group preserve_beat: false do
	8.times do |i|
		x = -2*sqrt(3) * i/8
		y = 4-6*i/8
		i.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
	end
end
transform(duplicate slides) { horizontal_flip; beat_translate 1 }
f 2*sqrt(3), -2, :r, ?ぎ; bg_note 2*sqrt(3)+1, -3, ?ゅ; bg_note 2*sqrt(3)+2, -2, ?ん; b 1
f -2*sqrt(3), -2, :l, ?わ; bg_note -2*sqrt(3)+2, -2, ?ん; b 1
hexagram 1/2; t 2*sqrt(3), -2; t 0, 4; bg_note -1, -1/sqrt(3), ?わ; b 3/4
hexagram 1/2; t -2*sqrt(3), -2; t 0, 4; bg_note 1, -1/sqrt(3), ?わ; b 3/4
hexagram 1/2; t 2*sqrt(3), -2; t -2*sqrt(3), -2; bg_note 0, 2/sqrt(3), ?わ; b 1/2

slides = group preserve_beat: false do
	8.times do |i|
		x = 2*sqrt(3) * i/8
		y = -4+6*i/8
		i.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
	end
end
transform(duplicate slides) { horizontal_flip; beat_translate 1 }
f -2*sqrt(3), 2, :l, ?ぎ; bg_note -2*sqrt(3)+1, 1, ?ょ; bg_note -2*sqrt(3)+2, 2, ?う; b 1
f 2*sqrt(3), 2, :r, ?お; bg_note 2*sqrt(3)+2, 2, ?う; b 1
hexagram 1/2; t -2*sqrt(3), 2; t 0, -4; bg_note 1, 1/sqrt(3), ?お; bg_note 2, 2/sqrt(3), ?う; b 3/4
hexagram 1/2; t 2*sqrt(3), 2; t 0, -4; bg_note -1, 1/sqrt(3), ?お; bg_note -2, 2/sqrt(3), ?う; b 3/4
hexagram 1/2; t -2*sqrt(3), 2; t 2*sqrt(3), 2; bg_note 0, -2/sqrt(3), ?お; bg_note 0, -4/sqrt(3), ?う; b 1/2

f 4/sqrt(3), 4, :dr, ?じ; bg_note 4/sqrt(3)+1, 4-sqrt(3), ?ょ; b 1/4
d 4/sqrt(3)+1/2, 4-sqrt(3)/2; b 1/4
f -4/sqrt(3), -4, :ul, ?じ; bg_note -4/sqrt(3)-1, -4+sqrt(3), ?ょ; b 1/4
d -4/sqrt(3)-1/2, -4+sqrt(3)/2; b 1/4
f 4/sqrt(3), -4, :ur, ?じ; bg_note 4/sqrt(3)+1, -4+sqrt(3), ?ょ; b 1/4
d 4/sqrt(3)+1/2, -4+sqrt(3)/2; b 1/4
f -4/sqrt(3), 4, :dl, ?じ; bg_note -4/sqrt(3)-1, 4-sqrt(3), ?ょ; b 1/4
d -4/sqrt(3)-1/2, 4-sqrt(3)/2; b 1/4
hexagon 1/2; t 0, 0, ?じ; bg_note 0, -sqrt(3), ?ょ; b 1/2
t -4/sqrt(3)-1, 4-sqrt(3); b 1/4
hexagon 1/2; t -4/sqrt(3), 4, ?じ; bg_note -4/sqrt(3)-2, 4, ?ょ; t 4/sqrt(3), -4; b 1/2
t 4/sqrt(3)+1, 4-sqrt(3); b 1/4
hexagon 1/2; t 4/sqrt(3), 4, ?じ; bg_note 4/sqrt(3)+2, 4, ?ょ; t -4/sqrt(3), -4; b 1/2

group preserve_beat: false do
	4.times do |i|
		yokogaki_c 0, -2+2*i, [['ぎゃー', 1]]
	end
end
slides = group do
	4.times do |i|
		8.times do |j|
			x = (8-8/sqrt(3))*i/3 + 8/sqrt(3) - (j/8-1/2).abs*8/sqrt(3)
			y = (4-8*j/8)*(-1)**i
			j.zero? ? h(x, y, 1/2) : d(x, y); b 1/8
		end
	end
end
transform(duplicate slides) { rotate PI }

group preserve_beat: false do
	yokogaki_c 0, 2, [
		[nil, 3], [?休, 1],
		
		[?憩, 3/2], [?地, 1], [?带, 1], [?に, 1/2],
	]

	yokogaki_c 0, 2/3, [
		[nil, 3], [?エ, 1/2], [?モ, 1/2],

		[?イ, 1], [?ピ, 1/2], [?ア, 1/2], [?ノ, 1/2], [?入, 1/2], [?れ, 1/2], [?て, 1/2],
	]

	yokogaki_c 0, -2/3, [
		[nil, 3], [?指, 1],

		[?休, 1], [?ま, 1/2], [?せ, 1/2], [?る, 1/2], [?た, 1/2], [?め, 1/2], [?の, 1/2],
	]

	yokogaki_c 0, -2, [
		[nil, 3], [?嵐, 1],

		[nil, 1/2], [?の, 1/2], [?前, 1], [?の, 1/2], [?静, 1], [?け, 1/2], [?さ, 0, 2],
	]
end

[
	[7, 4],

	[-6, 3], [4, 1],

	[8, 4],

	[-4, 3], [2, 1],

	[7, 4],

	[-6, 3], [4, 1],

	[8, 3/2], [5, 3/2], [-1, 1],
].each do |x, delta|
	note = tp_drop 0, -8, 1 do
		t x, 4; b delta
	end
	transform(duplicate note) { rotate PI }
end

tp_chain -8, 0, 1, preserve_beat: false do
	t 5, 2; b 3/4
	t 1, 0; b 3/4
	t 5, -3; b 1/2
	t 7, -2; b 1/2
	t 6, 0; b 1/2
	t 5, 2; b 1/2
	t 6, 4; b 1/2
	mark :l
end
tp_chain 8, 0, 1 do
	b 1/2
	t -0, 1; b 1/2
	t -0, -1; b 1
	t -3, -1; b 1/2
	t -2, 1; b 1/2
	t -4, 2; b 1/2
	t -6, 3; b 1/2
	mark :r
end

group preserve_beat: false do
	yokogaki_c 0, 0, [
		[nil, 7], [?パ, 1, 3],

		['ワー', 4, 2],
	]

	yokogaki_c 0, 0, [
		[?解, 1, 6], [?き, 1, 5], [?放, 2, 4],

		[?ち, 4, 2],
	]

	yokogaki_c 0, 0, [
		[nil, 3], [?す, 1, 9],

		[?べ, 1, 8], [?て, 1, 7], [?の, 1, 6], [?終, 1, 5],

		[?わ, 2, 4], [?り, 1, 2], [?へ, 1, 1],
	]
end

def strong_h x, y, direction, duration
	group preserve_beat: false do
		h x, y, duration
		(duration*4).to_i.times do |i|
			angle = Sunniesnow::Charter::DIRECTIONS[direction] + PI/12*(rand-0.5)
			tp_chain 16*cos(angle), 16*sin(angle), 1 do
				d x, y; b 1/4
			end
		end
	end
end
def slide x0, y0, direction, type = :d
	group preserve_beat: false do
		4.times do |i|
			x, y = x0 + 2*i*cos(direction), y0 + 2*i*sin(direction)
			if i.zero?
				case type
				when :f then f x, y, (direction/(PI/4)).round*PI/4
				when :t then t x, y
				when :d then d x, y
				end
			else
				d x, y
			end
			b 1/8
		end
	end
end
at :l, update_mark: true do
	slide 8, 3, -7*PI/8, :t; b 2
	f 4, 0, :ur; b 1
	slide 0, -4, 3*PI/8, :t; b 1
end
at :r, update_mark: true do
	strong_h -8, 2, :r, 2; b 3
	strong_h -5, -3, :r, 2; b 1
end

at :l, update_mark: true do
	b 1
	slide -5, -3, 5*PI/8; b 1
	f -2, 1, :ur; b 1
	slide 1, 4, -3*PI/8; b 1
end
at :r, update_mark: true do
	b 1
	strong_h 1, 4, :d, 2; b 2
	strong_h -2, -4, :u, 1; b 1
end

at :l, update_mark: true do
	slide -2, -4, 3*PI/8; b 2
	f -6, 0, :dl; b 1
	slide -5, 4, -3*PI/8, :t; b 1
end
at :r, update_mark: true do
	strong_h 6, 1, :l, 2; b 3
	strong_h 8, -3, :l, 2; b 1
end

at :l, update_mark: true do
	b 1
	slide 8, -3, 5*PI/8; b 1
	f -1, -2, :ur; b 1
	slide -3, 4, -PI/8; b 1
end
at :r, update_mark: true do
	b 1
	strong_h -3, 4, :d, 2; b 2
	strong_h 6, -3, :l, 1; b 1
end

at :l, update_mark: true do
	slide 6, -3, 7*PI/8; b 2
	f 3, -4, :ul; b 1
	slide 5, 2, -3*PI/8, :t; b 1
end
at :r, update_mark: true do
	strong_h -7, -4, :u, 2; b 3
	strong_h -4, 3, :r, 2; b 1
end

at :l, update_mark: true do
	b 1
	slide -4, 3, -5*PI/8; b 1
	f 0, 0, :dr; b 1
	slide 7, -1, 7*PI/8; b 1
end
at :r, update_mark: true do
	b 1
	strong_h 7, -1, :l, 2; b 2
	strong_h -7, 4, :d, 1; b 1
end

at :l, update_mark: true do
	slide -7, 4, -PI/8; b 3/2
	slide 2, -4, 5*PI/8; b 1/2
	f 2+8*cos(5*PI/8), -4+8*sin(5*PI/8), :ur; b 1
	slide -6, -1, -PI/8; b 1
end
at :r, update_mark: true do
	strong_h 2, -4, :u, 3/2; b 3/2
	strong_h -6, -1, :r, 3/2; b 3/2
	strong_h 7, 2, :l, 3; b 1
end

at :l, update_mark: true, preserve_beat: true do
	b 2
	f -2, 3, :ul
	slide 7, 2, -7*PI/8; b 2
end

group preserve_beat: false do
	yokogaki_c 0, 4, [
		[nil, 8/3], [?あ, 1/3], [?な, 1/3], [?た, 1/3], [?な, 1/3],

		[?ら, 3/2],
	]
	yokogaki_c 0, 2, [
		[?こ, 1/2], [?の, 1/4], [?先, 1/2], [?の, 1/4],
		[?展, 2/3], [?開, 1/3],

		[nil, 1/3], [?は, 2/3+1/2],
	]
	yokogaki_c 0, 0, [
		[?も, 1/2], [?う, 1/2],
		[?わ, 1/3], [?か, 1/3], [?る, 1/3],
		[?は, 1/2],

		[?ず, 1],
	]
	yokogaki_c 0, 4, [
		[nil, 1],
		[?い, 1/3], [?く, 1/3], [?よ, 4/3],
	]

	big_text 1/2, ?8; b 4

	big_text 1/2, ?7; b 4

	big_text 1/2, ?6; b 2
	big_text 1/2, ?5; b 2

	big_text 1/2, ?4; b 1
	big_text 1/2, ?3; b 1
	big_text 1/2, ?2; b 1
	big_text 1/2, ?1; b 1

	big_text 3, '三倍アイスクリーム'; b 4
end

tp_drop 0, 8, 1 do
	2.times { t 4, -4; b 2 }

	2.times { t -5, -4; b 2 }

	2.times { t 7, -4; b 2 }
	
	2.times { t -6, -4; b 2 }

	4.times { t 4, -4; b 1 }

	3.times { t -5, -4; b 1 }
	t -3, -4; b 1

	4.times { t 7, -4; b 1/2 }
	4.times { t 5, -4; b 1/2 }
	
	4.times do
		t 3, -4
		2.times { t -6, -4; b 1/2 }
	end

	b 4
end

group preserve_beat: false do
	points = [
		*(-8..8).step(2).map { [_1, 4] },
		[8,2], [8,0], [8,-2],
		*(-8..8).step(2).map { [_1, -4] }.reverse,
		[-8,-2], [-8,0], [-8,2],
	]
	4.downto 1 do |i|
		8.times do |j|
			points.each_with_index do |(x, y), k|
				group preserve_beat: false do
					b 1 if ((k+2) % (i*2) < i) ^ j.even?
					bg_note x, y
				end
			end
			b 2
		end
	end
end

lead = tp_chain -8, 0, 1 do
	t -6, 3; b 1/2
	t -1, 2; b 1/4
	t -3, 1; b 1/2
	t 0, -1; b 1/4
	t 2, -2; b 1/2
	t 1, 3; b 1/2
	t -5, 1; b 3/4
	t 1, 0; b 1/4
	t 3, -1; b 1/4
	t 1, -2; b 1/4

	t -1, -3; b 1/2
	t -4, -1; b 1/4
	t -5, 1; b 1/2
	t -1, 2; b 1/4
	t 0, 4; b 1/2
	t 3, 0; b 1/2
	t -2, -1; b 1/4
	t -4, -2; b 1/2
	t -1, -4; b 1/4
	t 1, -3; b 1/2
end

transform(duplicate lead) do
	horizontal_flip
	beat_translate 8
end
b 8

lead = tp_chain -8, 0, 1 do
	t -4, 3; b 1/2
	t 1, 2; b 1/4
	t -1, 1; b 1/4
	tp_chain 8, 0, 1 do
		f 2, 0, :r; b 1/4
	end
	t -1, -1; b 1/4
	t 1, -2; b 1/2
	t 5, -1; b 1/2
	t 1, 4; b 1/2
	tp_chain -8, 0, 1 do
		f -3, 2, :l; b 1/4
	end
	t -1, 1; b 1/4
	t -4, 0; b 1/4
	t -1, -1; b 1/4
end

tp_chain -8, 0, 1 do
	t -3, -2; b 1/2
	t 4, -4; b 1/4
	t 2, -3; b 1/4
	tp_chain 8, 0, 1 do
		f 5, -2, :r; b 1/4
	end
	t 2, -1; b 1/4
	t 4, 0; b 1/2
	t 1, 3; b 1/2
	t -4, 2; b 1/4
	t -2, 1; b 1/4
	tp_chain -8, 0, 1 do
		f -5, 0, :l; b 1/4
	end
	t -2, -1; b 1/4
	t -4, -2; b 1/2
end

transform(duplicate lead) do
	horizontal_flip
	beat_translate 8
end
b 4

tp_chain 8, 0, 1 do
	t 3, -2; b 1/2
	f -4, -4, :l; b 1/4
	t -2, -3; b 1/4
	tp_chain -8, 0, 1 do
		f -5, -2, :l; b 1/4
	end
	t -2, -1; b 1/4
	t -4, 0; b 1/2
	tp_chain -8, 0, 1 do
		t -5, 3
	end
	t 0, 2; b 1/2
	t -1, -1; b 1/4
	tp_chain -8, 0, 1 do
		t -2, 0
	end
	t 5, 1; b 1/2
	t 3, -2; b 1/4
	tp_chain 8, 0, 1 do
		t 4, -3
	end
	t -3, -4; b 1/2
end

group preserve_beat: false do
	yokogaki_c 0, 1, [
		["I'm", 1, 8],
		['so', 1/2, 7], ['ha', 1/2, 7-1/2],
		[nil, 1/2], ['ppy', 3/2, 6-1/2],
	], false

	yokogaki_c 0, -1, [
		[nil, 3], [?と, 1/2, 8+1], [?か, 1/2, 8+1/2],

		[?英, 1, 8],
		[?語, 1/2, 7], [?言, 1/2, 7-1/2],
		[nil, 1/2], ['って', 3/2, 6-1/2],
	]

	b 4

	yokogaki_c 0, 1, [
		[?実, 3/2, 8], [?は, 1/2, 8-3/2],
		[?ア, 1, 6], [?レ, 1, 5],
	]

	b 4

	yokogaki_c 0, -1, [
		['fr', 1/2, 8], ['ee', 1/2, 8-1/2],
		[nil, 1/2], ['vo', 1/2, 7-1/2],
		[nil, 1/2], ['cal', 3/2, 6-1/2],
	], false
end

lead = tp_chain -8, 0, 1 do
	tp_chain 8, 0, 1 do
		t 6, -1
	end
	t -6, 0; b 1/2
	t -1, -1; b 1/4
	t 1, 0; b 1/4
	tp_chain -8, 0, 1 do
		t -4, 2; b 1/4
	end
	t 0, 3; b 1/4
	t -2, 4; b 1/2
	tp_chain 8, 0, 1 do
		t 6, 4
	end
	t -6, -2; b 1/2
	t 2, 4; b 1/2
	tp_chain -8, 0, 1 do
		t -4, 1; b 1/4
	end
	t 0, 0; b 1/4
	t -2, -1; b 1/4
	t 0, -2; b 1/4

	tp_chain 8, 0, 1 do
		t 2, -3
	end
	t -4, -4; b 1/2
	t 3, -1; b 1/4
	t 5, 0; b 1/4
	tp_chain -8, 0, 1 do
		t 0, 1; b 1/4
	end
	t 4, 2; b 1/4
	t 2, 3; b 1/2
	tp_chain 8, 0, 1 do
		t 6, 4
	end
	t -5, 3; b 1/2
	t -1, 3; b 1/4
	t 1, 2; b 1/4
	tp_chain -8, 0, 1 do
		t -4, 0; b 1/4
	end
	t 0, -1; b 1/4
	t -2, -2; b 1/2
end

transform(duplicate lead) do
	horizontal_flip
	beat_translate 8
end
b 8

lead = tp_chain -8, 0, 1 do
	tp_chain 8, 0, 1 do
		t 6, -1
	end
	t -6, 0; b 1/2
	t -1, -1; b 1/4
	t 1, 0; b 1/4
	tp_chain -8, 0, 1 do
		f -4, 2, :l; b 1/4
	end
	t 0, 3; b 1/4
	t -2, 4; b 1/2
	tp_chain 8, 0, 1 do
		t 6, 4
	end
	t -6, -2; b 1/2
	t 2, 4; b 1/2
	tp_chain -8, 0, 1 do
		f -4, 1, :l; b 1/4
	end
	t 0, 0; b 1/4
	t -2, -1; b 1/4
	t 0, -2; b 1/4
end

tp_chain -8, 0, 1 do
	tp_chain 8, 0, 1 do
		t 2, -3
	end
	t -4, -4; b 1/2
	t 3, -1; b 1/4
	t 5, 0; b 1/4
	tp_chain -8, 0, 1 do
		f 0, 1, :l; b 1/4
	end
	t 4, 2; b 1/4
	t 2, 3; b 1/2
	tp_chain 8, 0, 1 do
		t 6, 4
	end
	t -5, 3; b 1/2
	t -1, 3; b 1/4
	t 1, 2; b 1/4
	tp_chain -8, 0, 1 do
		f -4, 0, :l; b 1/4
	end
	t 0, -1; b 1/4
	t -2, -2; b 1/2
end

transform(duplicate lead) do
	horizontal_flip
	beat_translate 8
end
b 4

tp_drop 0, 8, 1, preserve_beat: false do
	t 2, -3; b 1
	t -1, -1; b 1
	t 7, 0; b 1
	t -6, 1; b 1/2
	t 1, 3; b 1/4
	t -1, 3; b 1/4
end

side = tp_drop 8, 0, 1 do
	b 1/2
	t 6, -2; b 1
	t 4, 0; b 1
	t 3, 2; b 3/2
end
transform(duplicate side) { horizontal_flip }

group preserve_beat: false do
	yokogaki -8, 4, 16, [
		[nil, 2], [?て, 1/2], [?な, 1/2], [?感, 3/4], [?じ, 1/4],

		[?で, 1/2], [?作, 3/4], [?る, 1/4], [?と, 1/2],

		['いいん', 1/3], [?だ, 1/3], [?け, 1/3], [?ど, 1],
	]

	yokogaki_c 0, 4, [
		[nil, 3/2], ['うーん', 3/2],
	]
	yokogaki -8, 4, 16, [
		[?何, 2/3], [?か, 1/3],
		
		[?足, 1/3], [?り, 1/3], [?な, 1/3],
		[?い, 1/3], [?気, 1/3], [?が, 1/3],
		[?す, 1/3], [?る, 1/3], [?ん, 1/3],
		[?だ, 1/3], [?よ, 1/3], [?な, 1/3],
	]

	yokogaki_c 0, 4, [
		[nil, 2], ['なん', 3/4], [?だ, 3/4], ['っけ', 1/2],
	]

	b 3
	bg_note -4, 4, ?あ; b 1
	
	yokogaki_c 2, 4, [
		[?あ, 3/4], [?れ, 3/4], [?だ, 5/2]
	]

	yokogaki_c 0, 4, [
		[?ラ, 2/3], [?ス, 2/3], [?殺, 2/3], [?し, 2],
	]
end

tp_chain 0, 8, 1 do
	diamond_grid 1/2
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? f(x, y, :d) : d(x, y); b 1/8
	end
end
b 1/2
tp_drop 0, 8, 1, preserve_beat: false do
	7.times { t -8, -3; b 1 }
end
7.times do |i|
	x = [-6, -3, 0, 4, 1, -2, -5][i]
	y = 2-2*i/3
	dy = i >= 3 ? -1 : 1
	tp_drop 8, 8, 1 do
		t x, y; b 1/4
		d x+2, y+dy; b 1/4
		d x+4, y+2*dy; b 1/2
	end
end

tp_drop 0, 8, 1, preserve_beat: false do
	6.times { t -8, -3; b 1 }
	[3/4, 1/4, 1/2, 1/2].each { |delta| t -8, -3; b delta }
end
tp_chain 0, -8, 1 do
	4.times do |i|
		x, y = 0, -4+2*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
b 1/2
6.times do |i|
	x = [-6, -3, 0, 4, 1, -2, -5][i]
	y = -2+2*i/3
	dy = i >= 3 ? 1 : -1
	tp_drop 8, 8, 1 do
		t x, y; b 1/4
		d x+2, y+dy; b 1/4
		d x+4, y+2*dy; b 1/2
	end
	if i == 5
		b -1/4
		t x+6, y+dy; b 1/4
		t x+8, y; b 1/2
		t 4, -1; b 1/2
	end
end

tp_chain 0, 8, 1 do
	diamond_grid 1/2
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? f(x, y, :d) : d(x, y); b 1/8
	end
end
b 1/2
tp_drop 0, 8, 1, preserve_beat: false do
	7.times { t 8, -3; b 1 }
end
7.times do |i|
	x = [6, 3, 0, -4, -1, 2, 5][i]
	y = 2-2*i/3
	dy = i >= 3 ? -1 : 1
	tp_drop -8, 8, 1 do
		t x, y; b 1/4
		d x-2, y+dy; b 1/4
		d x-4, y+2*dy; b 1/2
	end
end

tp_drop 0, 8, 1, preserve_beat: false do
	7.times { t 8, -3; b 1 }
end
tp_chain 0, -8, 1 do
	4.times do |i|
		x, y = 0, -4+2*i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
b 1/2
6.times do |i|
	x = [6, 3, 0, -4, -1, 2, 5][i]
	y = -2+2*i/3
	dy = i >= 3 ? 1 : -1
	tp_drop -8, 8, 1 do
		t x, y; b 1/4
		d x-2, y+dy; b 1/4
		d x-4, y+2*dy; b 1/2
	end
end
b 1

def f_drag x0, y0, direction, has_text = true
	angle = Sunniesnow::Charter::DIRECTIONS[direction]
	dr = %i[ur ul dl dr].include?(direction) ? sqrt(2)*2 : 2
	tp_chain -x0, -y0, 1, relative: false, preserve_beat: false do
		4.times do |i|
			x, y = x0 + dr*i*cos(angle), y0 + dr*i*sin(angle)
			i.zero? ? f(x, y, direction, has_text ? ?ダ : '') : d(x, y); b 1/8
		end
	end
end
def t_tap x, y
	tp_chain -x, -y, 1, relative: false do
		t x, y, ?ダ
	end
end
checkerboard 14
b 1

notes = group do
	notes = group do
		f_drag -4, 4, :d; b 1
		f_drag -4, 4, :r; b 1
		f_drag -4, -4, :u; b 1
		f_drag -4, -4, :r; b 1
	end
	transform(duplicate notes) { rotate PI; beat_translate 1/2 }

	notes = group do
		f_drag -4, -4, :ur; b 1
		f_drag -4, 4, :dr; b 1
	end
	transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
end

t_tap -4, 4; b 1/4
t_tap 4, -4; b 1/4
t_tap -4, -4; b 1/4
t_tap 4, 4; b 1/4

transform(duplicate notes) { beat_translate 7 }
b 6

group preserve_beat: false do
	bg_note 1, 1, ?ダ; b 1/2
	bg_note -1, -1, ?ダ; b 1/2
end
notes = group do
	f_drag 4, 4, :l, false; b 1/2
	f_drag -4, 4, :d, false; b 1/2

	t 4, 4; b 1/2
end
transform(duplicate notes) { rotate PI }
tp_drop 0, 8, 1 do
	f 1, 3, :dr; b 1/4
	f -1, 3, :dl; b 1/4
end
tp_chain 0, 8, 1 do
	diamond_grid 1/2
	4.times do |i|
		x, y = 0, 4-2*i
		i.zero? ? f(x, y, :d) : d(x, y); b 1/8
	end
end
b 1/2
yokogaki_c 0, 0, [
	[?終, 1/2], [?わ, 1/4], [?り, 1/4],
]

transform @events do
	scale 12.5
end

check

end
