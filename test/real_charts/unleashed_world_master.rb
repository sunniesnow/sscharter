Integer.alias_method :/, :quo
include Math
include Sunniesnow::Tools

Sunniesnow::Charter.open 'master' do

title 'Unleashed World'
artist 'sak feat.みゅい'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'
difficulty_sup '+'

offset 0.346
bpm 232

def tpc direction, **opts, &block
	angle = Sunniesnow::Charter::DIRECTIONS[direction] || direction
	tp_chain 8*cos(angle), 8*sin(angle), 1, **opts, &block
end
def tpd direction, **opts, &block
	angle = Sunniesnow::Charter::DIRECTIONS[direction] || direction
	tp_drop 8*cos(angle), 8*sin(angle), 1, **opts, &block
end

b 11

tpc :l do
	h -2, 2, 5/2, 'DES'; b 3
	h 2, 2, 9/2, 'PERATE'; b 1

	b 4

	b 1 
	t -3, -2, 'ne'; b 1
	t -1, -2, 'ver'; b 1
	t 1, -2; b 1

	h 3, -2, 5/2, 'ends'; b 4

	h -4, 0, 5/2, 'The'; b 3
	t 4, 2, 'en'; b 1/2
	t 4, 0, 'd'; b 1/2

	t 4, -2, "won't"; b 2
	t 0, -2, 'lead'; b 2

	h 0, 2, 2, 'me'; b 4

	t -2, -3, 'to'; b 2
	t -3, 0, 'the'; b 2
	mark :m
end

path 'm -4 -3 c 1 5 2 8 5 6 3 -2 4 -7 -2 -5 -6 2 -7 5 -7 5', 32 do |x, y, i|
	i.zero? ? at(:m) { h x, -y, 7, 'un' } : d(x, -y); b 1/4
end
b -1
at :m, goto_beat: false, update_mark: true, preserve_beat: true do
	t 2, 1, 'lea'; b 1/2
	t 3, -1, 'shed'; b 1/2
end

path 'M 4 3 C -4 2 -3 -2 0 -3 3 -4 10 -5 7 0 4 5 -12 2 -7 -1 -2 -4 3 6 6 3 9 0 -1 -6 -5 -2 -9 2 2 4 2 4', 54 do |x, y, i|
	i.zero? ? at(:m) { h x, -y, 12, 'world' } : d(x, -y); b 1/4
end
diamond_grid 7/2
tpd :u do
	14.times do
		d 0, 0; b 1/4
	end
end

tpc :u do
	b 2
	t 4, 0, 'Wheats'; b 2

	%w[shi ning in the].each_with_index do |text, i|
		angle = PI/2 + PI/4*i
		t 4*cos(angle), 4*sin(angle), text; b 1
	end

	h 0, -4, 8-1/2, 'breath'; b 4
end

b 1
12.times do |i|
	angle = -PI/2 + 2*PI*i/12
	d 4*cos(angle), 4*sin(angle); b 1/4
end

tpc :u do
	b 2
	t 4, 0, 'Birds'; b 2

	%w[sing ing in a].each_with_index do |text, i|
		angle = -PI/2 - i*PI/4
		t 4*cos(angle), 4*sin(angle), text; b 1
	end

	h 0, 4, 3, 'har'; b 3
	t 2, -2, 'mo'; b 1

	h 3, 1, 7/2, 'ny'; b 4
end

tpc :u do
	b 2
	t -4, 0, "they're"; b 2

	%w[li ving with no].each_with_index do |text, i|
		angle = PI/2 - PI/4*i
		t 4*cos(angle), 4*sin(angle), text; b 1
	end

	h 0, -4, 8-1/2, 'fear'; b 4
end

b 1
12.times do |i|
	angle = -PI/2 - 2*PI*i/12
	d 4*cos(angle), 4*sin(angle); b 1/4
end

tpc :u do
	b 2
	t -4, 0, 'E'; b 2

	%w[ven though in the].each_with_index do |text, i|
		angle = -PI/2 + i*PI/4
		t 4*cos(angle), 4*sin(angle), text; b 1
	end

	h 0, 4, 5/2, 'far'; b 5/2
	t -2, 0, 'ci'; b 1/2
	t -3, 1, 'cal'; b 1

	h -6, 0, 7/2, 'tale'; b 1
end
diamond_grid 3
tpd :u do
	12.times do
		d 0, 0; b 1/4
	end
end

b 4

notes = group do
	notes = group preserve_beat: false do
		tpc :u do
			t -4, -4; b 1
		end
		tpc :r do
			t -6, 1
		end
		tpc :l do
			t 6, -1; b 1
		end
	end
	transform duplicate notes do
		rotate PI
		beat_translate 2
	end
end
transform duplicate notes do
	beat_translate 4
end
transform duplicate notes do
	beat_translate 8
end

bg_note -1, 2, 12, 'Pho'; b 3/2
bg_note 1, 2, 12-3/2, 'nies'; b 3/2
bg_note -1, 0, 12-3, 'dis'; b 1

bg_note 1, 0, 8, 'turb'; b 3/2
bg_note -1, -2, 8-3/2, 'my'; b 3/2
bg_note 1, -2, 8-3, 'mind'; b 1

b 7/2
tpc :l do
	t 4, -2; b 1/2
end

notes = group do
	notes = group preserve_beat: false do
		tpc :u do
			t 4, -4; b 1
		end
		tpc :r do
			t -6, -1
		end
		tpc :l do
			t 6, 1; b 1
		end
	end
	transform duplicate notes do
		rotate PI
		beat_translate 2
	end
end
transform duplicate notes do
	beat_translate 4
end
transform duplicate notes do
	beat_translate 8
end

b 4

bg_note -1, 2, 12, 'Change'; b 3/2
bg_note 1, 2, 12-3/2, 'less'; b 3/2
bg_note 0, 0, 12-3, 'world'; b 1

bg_note -2, -2, 8, 'an'; b 3/2
bg_note 0, -2, 8-3/2, 'guishes'; b 3/2
bg_note 2, -2, 8-3, 'me'; b 1

tpc :u do
	t 4, -4; b 1
end
tpc :r do
	t -6, -1
end
tpc :l do
	t 6, 1; b 1
end
tpc :d do
	t -4, 4; b 1/2
	4.times do |i|
		x, y = -3, 2-i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tpd :l do
	t 6, 0; b 1/2
	t 5, 2; b 1/2
end

notes = group preserve_beat: false do
	tpc(:d) { t 4, 4; t 0, 4; b 1 }
	tpc(:r) { t -6, 1 }
	tpc(:l) { t 6, -1; b 1 }
	tpc(:u) { t -4, -4; b 1 }
	tpc(:r) { t -6, 1 }
	tpc(:l) { t 6, -1; b 1 }

	tpc(:d) { t 4, 4; b 1 }
	tpc(:r) { t -6, 1 }
	tpc(:l) { t 6, -1; b 1 }
	tpc(:u) { t -4, -4; b 3/4 }
	tpd(:d) do
		t -1, -1; b 1/4
		t -2, 0; b 1/2
		t -3, 2; b 1/2
	end
end

transform duplicate notes do
	horizontal_flip
	beat_translate 8
end

b 4

bg_note -1, 3, 18, 'Now'; b 3/2
bg_note 1, 3, 18-3/2, 'then'; b 3/2
bg_note -1, 1, 18-3, 'how'; b 1

bg_note 1, 1, 14, 'can'; b 3/2
bg_note -2, -1, 14-3/2, 'I'; b 3/2
bg_note 0, -1, 14-3, 'say'; b 1

b 2
bg_note 2, -1, 10-2, 'who'; b 1
bg_note -1, -3, 10-3, 'I'; b 1

bg_note 1, -3, 6, 'am'
tpd(:d) { t 4, 4 }
notes = tpd :l do
	t -5, 4; b 1/2
	t -6, 2; b 1/2
end
transform duplicate notes do
	rotate PI
	beat_translate 1
end
transform duplicate notes do
	vertical_flip
	beat_translate 2
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3
end
b 3

notes = tpd :l do
	t -4, -3; b 1/2
	t -5, -1; b 1/2
	t -5, 1; b 1/2
	t -4, 3; b 1/2
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1/4
end
16.times do |i|
	angle = PI/2 + 2*PI*i/16
	x, y = 4*cos(angle), 4*sin(angle)
	i.zero? ? t(x, y) : d(x, y); b 1/8
end

notes = tpd :u, preserve_beat: false do
	t 2, -3; b 1/2
	t 4, -2; b 1
end
transform duplicate notes do
	rotate PI
	beat_translate 3/2
end
transform duplicate notes do
	vertical_flip
	beat_translate 3
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3
end
bg_note -1, 0, 7, 'Fruit'; b 4

bg_note 1, 0, 3, 'less'; b 1/2
notes = tpd :u do
	4.times do |i|
		t 2+i*2, -3+i; b 1/2
	end
end
transform(duplicate notes) { rotate PI }
b 3/2

def chain x0, y0, direction, text = nil
	angle = Sunniesnow::Charter::DIRECTIONS[direction]
	4.times do |i|
		x, y = x0 + sqrt(2)*cos(angle)*i, y0 + sqrt(2)*sin(angle)*i
		i.zero? && text ? at(:m, goto_beat: false) { t x, y, text } : d(x, y); b 1/4
	end
end
def pattern lyrics
	notes = group do
		notes = group preserve_beat: false do
			notes = tpd :l do
				t -4, -4; b 1/2
				t -3, -2; b 1/2
				t -2, 0; b 1
			end
			transform duplicate notes do
				vertical_flip
				beat_translate 2
			end
		end
		transform duplicate notes do
			beat_translate 4
		end
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 8
	end

	tpc :u do
		h 3, -1, 2, lyrics[0]; b 3
		h 5, 2, 4, lyrics[1]; b 5

		b 1
		t -1, -2, lyrics[2]; b 1
		t -3, -1, lyrics[3]; b 1
		t -5, 0, lyrics[4]; b 1

		h -7, 1, 5/2, lyrics[5]; b 4
	end

	grid 14
	tpc(:d) { mark :m }
	chain 0, 4, :dr, lyrics[6]
	chain 0, -4, :ul, lyrics[7]
	chain 4, 0, :dl, lyrics[8]
	chain -4, 0, :ur, lyrics[9]

	chain 0, 4, :dr, lyrics[10]
	chain 0, -4, :ul, lyrics[11]
	chain 4, 0, :dl, lyrics[12]
	chain -4, 0, :ur, lyrics[13]

	chain 0, -4, :ur, lyrics[14]
	chain 0, 4, :dl, lyrics[15]
	chain 4, 0, :ul, lyrics[16]
	chain -4, 0, :dr, lyrics[17]

	chain 0, -4, :ur, lyrics[18]
	chain 4, 0, :ul
end

pattern %W[
	DES PERATE ne ver \s ends
	There is no one left be hind but on ly I still be
]
at(:m, goto_beat: false) { t 0, 0, 'left' }; b 2

transform(group { pattern %w[
	God dess can you hear me
	I will leave the or na ment and say good bye to pho
] }) do
	horizontal_flip
end
b -1/2
at(:m, goto_beat: false) { t 0, 0, 'nies' }; b 3/2
def rewrite second = false
	tpc :r do
		t 4, -1, 'It'; b 1/2
		t 5, 1, 'is'; b 1/2

		h 6, 3, 7/2, 'time'; b 4

		b 1
		t -1, -4, 'to'; b 1
		t -3, -2, 're'; b 1
		t -5, 0, 'write'; b 1

		t -3, 2, 'my'; b 3/2
		t 3, 2, 'own'; b 3/2
		t 2, -2, 'sto'; b 1

		t 0, -4, 'ry'; b 1
	end
	tpd :l do
		t -4, 0; b 1/4
		t -2, -1; b 1/4
		t -4, -2; b 1/4
		t -2, -3; b 1/4
		t -4, -4; b 1
	end
	tpd :r do
		t 4, 0; b 1/4
		t 2, 1; b 1/4
		t 4, 2; b 1/4
		t 2, 3; b 1/4
	end

	notes = group preserve_beat: false do
		b -2
		bg_note -3, 4, 19-2, 'Make'; b 1
		bg_note -1, 4, 19-3, 'a'; b 1

		bg_note 1, 4, 15, 'break'; b 3
		bg_note 3, 4, 15-3, 'with'; b 1/2
		bg_note -3, -4, 15-7/2, 'the'; b 1/2

		bg_note -1, -4, 11, 'fai'; b 2
		bg_note 1, -4, 11-2, 'ry'; b 2

		bg_note 3, -4, (second ? 11/2 : 7), 'tale'; b 8
	end
	transform(notes) { scale 3/4, 1 }

	notes = group preserve_beat: false do
		notes = tpd :r do
			t 4, 4; b 1/2
			t 5, 2; b 1/2
			t 6, 0; b 1/2
			t 5, -2; b 1/2
			t 4, -4 if second
		end
		transform duplicate notes do
			rotate PI
			beat_translate 2
		end
	end
	transform(notes = duplicate(notes)) do
		beat_translate 4
	end
	transform(notes[-2..]) { horizontal_flip } if second

	group preserve_beat: false do
		b 2
		tpd :u do
			(1..6).each do |i|
				b 1
				t (-1)**i, 0; b 1
			end
		end
	end
	b 8

	notes = tpd :l, preserve_beat: false do
		t -4, 4; b 1/2
		t -3, 2; b 1/2
		t -2, 0; b 1/2
		t -3, -2; b 1/2
		t -4, -4 if second
	end
	transform duplicate notes do
		rotate PI
		beat_translate 2
	end
	transform duplicate notes do
		beat_translate 4
	end

	b 4
end
rewrite

b 2
notes = tpd :r do
	t 4, -4; b 1/4
	t 2, -3; b 1/4
	t 4, -2; b 1/2
end
transform duplicate notes do
	rotate PI
	beat_translate 1
end
b 1

notes = group do
	notes = tpd :d do
		t 4, 3; b 1/2
		t 6, 2; b 1
	end
	transform duplicate notes do
		rotate PI
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/2
end
b 3/2
notes = tpd :r do
	t 3, 1; b 1/2
	t 3, -1; b 1/2
end
transform duplicate notes do
	horizontal_flip
end

tpd :ur, preserve_beat: false do
	2.times do |i|
		b 1
		t 4+i*2, 3-i*2; b 1/2
	end
end
notes = tpc :dr do
	t 0, 0; b 1/4
	d -1, 1; b 1/4
	d -2, 2; b 1/2
end
transform duplicate notes do
	translate -2, -2
	beat_translate 3/2
end
transform duplicate notes do
	translate -4, -4
	beat_translate 3
end
b 3

notes = group do
	notes = tpd :u do
		t 6, -2; b 1/2
		t 4, -3; b 1
	end
	transform duplicate notes do
		rotate PI
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/2
end
b 3/2
notes = tpd :r do
	t 3, -1; b 1/2
	t 3, 1; b 1/2
end
transform duplicate notes do
	horizontal_flip
end

tpc :ul do
	t 0, 0; b 1/4
	d 1, -1; b 1/4
	d 2, -2; b 1/2
end
tpc :dr do
	t 1, 3; b 1/4
	d 0, 4; b 1/4
	d -1, 3; b 1/4
	d -2, 2; b 1/4
end
tpd :u do
	3.times do |i|
		t -3-2*i, 1-2*i
		t 6-2*i, 2-2*i; b 3/4
	end
end
b -1/4

b 1
tpd :u do
	t -8, 2; t 1, 1; b 1
	t -4, 4; t 5, 3; b 3/4
	t -4, 1; t 5, 0; b 3/4
	t -2, -1; t 7, -2; b 1/2
end

tpd :ur, preserve_beat: false do
	2.times do |i|
		b 1
		t -4-i*2, 3-i*2; b 1/2
	end
end
notes = tpc :dr do
	t 0, 0; b 1/4
	d 1, 1; b 1/4
	d 2, 2; b 1/2
end
transform duplicate notes do
	translate 2, -2
	beat_translate 3/2
end
transform duplicate notes do
	translate 4, -4
	beat_translate 3
end
b 3

notes = tpd :r do
	t 3, 1; b 1/2
	t 3, -1; b 1
end
transform duplicate notes do
	rotate PI
end
notes = group do
	notes = tpd :u do
		t 4, -3; b 1/2
		t 6, -2; b 1
	end
	transform duplicate notes do
		horizontal_flip
	end
end
transform duplicate notes do
	vertical_flip
	beat_translate 3/2
end
b 1

tpc :l do
	4.times do |i|
		x, y = 7-i, -i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
	4.times do |i|
		d 3-i, -4+i; b 1/4
	end
	4.times do |i|
		d -1+i, i; b 1/4
	end
	d 3, 4; b 1/4
	d 4, 3; b 1/4
	d 5, 2; b 1/4
	d 6, 3; b 1/4
end

tpd :d, preserve_beat: false do
	8.times { t 7, 4; b 1 }
end
tpc :u do
	notes = group do
		t -8, 3; b 1/2
		t -6, 3; b 1
		t -2, 1; b 1/2
		t -4, 1; b 1
	end
	transform duplicate notes, new_tip_points: false do
		translate 0, -4
		beat_translate 3
	end
	mark :m
end
b 1

b 2
at :m, goto_beat: false, preserve_beat: true do
	t -1, 0; b 1
	t -4, 2; b 1
end

tpd :d, preserve_beat: false do
	8.times { t -7, 4; b 1 }
end
at :m, goto_beat: false, preserve_beat: true do
	notes = group do
		t 8, -3; b 1/2
		t 6, -3; b 1
		t 2, -1; b 1/2
		t 4, -1; b 1
	end
	transform duplicate notes, new_tip_points: false do
		translate 0, 4
		beat_translate 3
	end
end
b 1

b 2
at :m, goto_beat: false, preserve_beat: true do
	t -1, 1; b 1
	4.times do |i|
		x, y = 4-i, -i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tpd :u, preserve_beat: false do
	8.times do
		t 0, -4; b 1
	end
end
at :m, goto_beat: false, preserve_beat: true do
	t -8, 1; b 1/2
	t -6, 1; b 1
	t -4, 4; b 1/2
	t -2, 4; b 1
	t 2, 4; b 1/2
	t 4, 4; b 1/2

	b 1/2
	t 6, 1; b 1/2
	t 8, 1; b 1
	t 4, -2; b 1
	t -4, -2; b 1
end

4.times do |i|
	notes = tpd :l do
		t -2-2*i, 1+i; b 1/2
		t -2-2*i, -1-i; b 1
	end
	transform duplicate notes do
		horizontal_flip
	end
end
notes = tpd :r do
	t 4, 4
	t 4, -4
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1
end
b -2; diamond_grid 4; b 4

group preserve_beat: false do
	b -1
	bg_note -2, 2, 16+5/2-3, 'Here'; b 1

	bg_note 0, 2, 12+5/2, 'I'; b 3
	bg_note 2, 2, 12+5/2-3, 'am'; b 1

	b 4

	b 1
	bg_note -3, -2, 4+5/2-1, 'to'; b 1
	bg_note -1, -2, 4+5/2-2, 'change'; b 1
	bg_note 1, -2, 4+5/2-3, 'the'; b 1

	bg_note 3, -2, 5/2, 'world'
end

tpc(:l) { h 4, 0, 4; b 4 }
tpc(:r) { h -4, 0, 4; b 4 }

tpc(:d) { h 0, 4, 4; b 4 }
tpc(:u) { h 0, -4, 2; b 5/2 }
t 1, 1; b 1/4
t -1, 0; b 1/4
t 1, -1; b 1

def pattern lyrics
	tpc(:u) { mark :m }
	group preserve_beat: false do
		6.times do
			b 1/2; tpc(:l) { t -2, 0 }; b 1/2
			b 1/2; tpc(:r) { t 2, 0 }; b 1/2
		end
	end
	grid 14
	chain 2, 2, :dr, lyrics[0]
	chain -2, 2, :dl, lyrics[1]
	chain 2, -2, :ur, lyrics[2]
	chain -2, -2, :ul, lyrics[3]

	chain 2, 2, :dr, lyrics[4]
	chain -2, 2, :dl, lyrics[5]
	chain 2, -2, :ur, lyrics[6]
	chain -2, -2, :ul, lyrics[7]

	chain 6, 2, :dl, lyrics[8]
	chain -6, 2, :dr, lyrics[9]
	chain 6, -2, :ul, lyrics[10]
	chain -6, -2, :ur, lyrics[11]

	chain 6, 2, :dl, lyrics[12]
	chain 2, -2, :ul
end

transform(group { pattern %w[There is no thing I can do but fight a gainst the des] }) { horizontal_flip }
b -3/2
tpc :r do
	t 2, 0; b 1/2
	t 0, 2; b 1/2
	t 2, 4; b 1/2
	at(:m, goto_beat: false) { t 4, 2, 'tiny' }; b 1/2
end
tpc :l do
	4.times do |i|
		x, y = -3-i, 4-i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tpd(:u) do
	t 4, -2; b 1/2
	t 6, -2; b 1/2
end

notes = group preserve_beat: false do
	notes = tpd :d do
		t 8, -1; b 1/2
		3.times { |i| t 6-2*i, 0; b 1/2 }
	end
	transform duplicate notes do
		rotate PI
		translate 8, -2
		beat_translate 2
	end
	b 2
end
transform duplicate notes do
	beat_translate 4
end
transform duplicate notes do
	beat_translate 8
	horizontal_flip
end
transform duplicate notes do
	beat_translate 12
	horizontal_flip
end

tpc :u do
	h -4, -1, 2, 'God'; b 3
	h -6, 3, 4, 'dess'; b 1

	b 4

	b 1
	t 2, 3, 'can'; b 1
	t 4, 4, 'you'; b 1
	t 6, 3, 'hear'; b 1

	h 8, 2, 5/2, 'me'; b 4
end

pattern %w[I will tri gger Doo ms day and fill it with deep dark]
b -3/2
tpc :l do
	t -2, 0; b 1/2
	t 0, 2; b 1/2
	at(:m, goto_beat: false) { t -2, 4, 'ness' }; b 1/2
	t -4, 2; b 1/2
end
tpc :r do
	4.times do |i|
		x, y = 3+i, 4-i
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
notes = group { rewrite true }.filter { _1.type != :bg_note }
transform(notes) { horizontal_flip }

b 2
tpd :l do
	t -4, -4; b 1/2
	t 0, -2; b 1/4
	t -2, -1; b 1/4
end
tpd(:u) { t 1, 0; b 1/2 }
tpd(:r) { t 2, 2; b 1/2 }

group preserve_beat: false do
	b -1
	bg_note -2, 2, 20-3, 'To'; b 1

	bg_note 0, 2, 16, 'get'; b 3
	bg_note 2, 2, 16-3, 'to'; b 1/2
	bg_note -3, -2, 16-7/2, 'the'; b 1/2

	bg_note -1, -2, 12, 'un'; b 2
	bg_note 1, -2, 12-2, 'leashed'; b 2

	bg_note 3, -2, 8, 'world'
end

notes = group do
	notes = tpd :r do
		4.times do |i|
			t 4+i, 3-2*i; b 1/2
		end
		4.times do |i|
			t 4-i, -3+2*i; b 1/2
		end
	end
	transform duplicate notes do
		translate -8, 0
	end
end

transform duplicate notes do
	horizontal_flip
	beat_translate 4
end
b 4

notes = group do
	tpc(:l) { t -4, 3; b 1/3 }
	tpc(:u) { t 3, 0; b 1/3 }
	tpc(:l) { t -3, -3; b 1/3 }
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1
end
b 1
notes = group do
	tpc(:l) { t -6, 4; b 1/3 }
	tpc(:u) { t 5, 0; b 1/3 }
	tpc(:l) { t -4, -4; b 1/3 }
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1
end
b 1

notes = tpd :l do
	t -2, 3; b 1/2
	t -6, 1; b 1/2
	t -2, -1; b 1/2
	t -6, -3; b 1/2
end
transform duplicate notes do
	beat_translate 1/4
	horizontal_flip
end
notes = group do
	notes = tpc :dr do
		t -4, 2; b 1/6
		d -5, 3; b 1/6
		d -6, 4; b 1/6
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 1/2
	end
end
transform duplicate notes do
	vertical_flip
	beat_translate 1
end

transform @events do
	scale 12.5
end

check

end
