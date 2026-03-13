include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title 'イガク'
artist '原口沙輔'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '13'
difficulty_sup ''

offset 0.351
bpm 170

### Intro

turntable 3
tp_chain 0, -100, 1 do
	h 0, 50, 3; b 3
	f 0, -50, :u; b 1/2
end
t 0, 25; b 1/4
t -12.5, 12.5; b 1/4

### Interlude verse 1

def start_pattern first = true
	group do
		notes = tp_drop 100, 100, 1, preserve_beat: false do
			8.times { t 50, 0; b 1 }
		end
		transform(duplicate notes) { translate -50, 0 }
		(f -50, 0, :l; checkerboard 1/2) if first; b 1/2
		tp_chain -100, 0, 1 do
			t -100, 50; b 1/2
			t -87.5, 25; b 1/2
			t -75, 0; b 1/2
			t -62.5, -25; b 1/2
			t -50, -50 if first; b 1/2
		end
		b 1/2
		tp_chain -100, 0, 1 do
			t -100, 50; b 1/2

			t -87.5, 25; b 1/2
			t -75, 0; b 1/2
			t -62.5, -25; b 1/2
			t -50, -50; b 1/2
			if first
				t -37.5, -25; b 1/2
				t -37.5, 0; b 1/2
				h -37.5, 25, 1/2; b 1
			end
		end
		tp_chain -100, 0, 1 do
			8.times do |i|
				x = -50 + 18.75*(-1)**i + 6.25*(-1)**(i/2).floor
				y = -50 + i*12.5
				d x, y; b 1/4
			end
		end unless first
	end
end
start_pattern
transform(start_pattern false) { horizontal_flip }
start_pattern

notes = tp_chain 0, 100, relative_beat: 1 do
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1/8; h -50, 50, 1; b 3/2
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1/8; h -50, 50, 1/2; b 1/2

	b 1/2
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1; t -50, 50; b 1/2
	t -50, -50; b 1/2
	t -50, 50; b 1/2
end
transform(duplicate notes) { translate 50, 0 }
transform(duplicate notes) { translate 100, 0 }
f 0, 0, :ur, ?ユ; b 1

### Vocal 1 (melody 1)

checkerboard 1/2
tp_drop 0, -100, 0.5 do
	f -100, 50, :l
	f -62.5, 50, :l
end
tp_drop 0, 100, 1, preserve_beat: false do
	3.times do
		b 1
		t -75, 0; b 1
	end
	b -1/4
	t 25, 0; b 1/8
	d 12.5, 12.5; b 1/8
	d 0, 25
	5.times do
		b 1
		t -75, 0; b 1
	end
end
tp_chain 100, -100, 1 do
	h 25, 25, 1/2, 'ドク'; b 1
	h 75, 25, 1/2, 'ター'; b 1
end
tp_chain 100, 100, 1 do
	t 12.5, -25, ?キ; b 1/2
	t 37.5, -25, ?ド; b 1/2
	t 62.5, -25, ?リ; b 1/2
	h 87.5, -25, 1/2, 'です'; b 1/2
end

b 4

tp_chain 100, -100, 1 do
	h 50, 25, 1/2, ?愛; b 1
end
tp_chain 100, 100, 1 do
	h 12.5, -25, 1/2, ?爆; b 1
	h 37.5, -25, 1/2, ?破; b 1
	t 62.5, -25, 'ッテ'; b 1/2
	h 87.5, -25, 1/2, ?ロ; b 1/2
end

b 2
tp_chain -100, 0, 1 do
	8.times do |i|
		x = 50 + 18.75*(-1)**i + 6.25*(-1)**(i/2).floor
		y = -50 + i*12.5
		t x, y; b 1/4
	end
end

tp_drop 0, 100, 1, preserve_beat: false do
	8.times do |i|
		t -87.5+12.5*(-1)**i, 0
		t -37.5-12.5*(-1)**i, 0
		b 1
	end
end
tp_chain 100, 0, 1 do
	h 75, 50, 1/2, ?簡; b 1
	h 100, 25, 1/2, ?単; b 1
	t 100, -25, ?に; b 1/2
	t 75, -37.5, ?な; b 1/2
	t 62.5, -12.5, ?れ; b 1/2
	h 37.5, 12.5, 1/2, ?ば; b 1/2
end

b 3+1/4
tp_chain -100, 0, 1 do
	t 0, 12.5; b 1/4
end
tp_chain 100, 0, 1 do
	t -12.5, 25, ?埋; b 1/4
end
tp_chain -100, 0, 1 do
	t 12.5, 37.5; b 1/4
end

notes = tp_chain 0, -100, relative_beat: 1 do
	grid 1/8; h -50, 50, 1/2; b 1
	grid 1/8; h -50, -50, 1; b 3/2
	grid 1/8; h -50, 50, 1/2; b 1
	grid 1/8; h -50, -50, 1/2; b 1/2

	b 1/2
	grid 1/8; h -50, 50, 1/2; b 1
	grid 1; t -50, -50; b 1/2
end
transform(duplicate notes) { translate 50, 0 }.each_with_object %w[ま った マ ター マ ター] do |note, lyrics|
	note[:text] = lyrics.shift if note[:text]
end
transform(duplicate notes) { translate 100, 0 }
tp_drop 0, 100, 1 do
	t -12.5, 0; b 1/2
	t 12.5, 25; b 1/2
	t 37.5, 0; b 1/2
	t 62.5, -25; b 1/4
	t 75, -12.5; b 1/4
end

### Voice 2 (melody 1)

def triangular_wave t, amplitude:, period:, phase: 0
	t = t/period + phase
	amplitude * (1 - 4*(t-t.round).abs)
end
tp_drop 0, 100, 1, preserve_beat: false do
	3.times do |i|
		8.times do
			f 87.5, 0, -PI/2 + PI/2*i; b 1
		end
	end
end
group preserve_beat: false do
	[
		[[1, 'ドク'], [1, 'ター'], [1/2, ?キ], [1/2, ?ド], [1/2, ?リ], [1/2, 'です']],
		[[1, ?愛], [1, ?想], [1, '良い'], [1/2, ?か], [1/2, ?も]],
		[[1, ?朦], [1, ?朧], [1/2, ?オ], [1/2, ?オ], [1/2, ?ト], [1/2, ?も]]
	].each do |data|
		tp_chain 100, 100, 1 do
			data.reduce 0 do |cur, (delta, text)|
				x = triangular_wave(cur, amplitude: 50, period: 8, phase: -1/4)
				y = triangular_wave(cur, amplitude: 50, period: 8, phase: 1/2)
				t x, y, text; b delta
				delta + cur
			end
			b 4
		end
	end
	b -1/2
	tp_chain 100, 100, 1 do
		t -12.5, -37.5, ?埋; b 1/2
	end
end
tp_drop 100, 100, 1, preserve_beat: false do
	b 14
	r = 12.5*sqrt(2)
	[[-87.5, -12.5], [-62.5, -37.5]].each do |(x0, y0)|
		4.times do |i|
			angle = (3-i)*PI/4
			d x0 + r*cos(angle), y0 + r*sin(angle); b 1/4
		end
	end
end
tp_chain -100, 0, 1 do
	[
		1, 3/2, 1, 1, 1, 1/2, 1, 1/2, 1/2,
		1, 3/2, 1, 1, 1/2, 1/2, 1/2, 1, 1,
		1, 3/2, 1, 1, 1, 1/2, 1, 1
	].reduce 0 do |cur, delta|
		x = -50 + triangular_wave(cur, amplitude: 50, period: 8, phase: -1/4)
		y = triangular_wave(cur, amplitude: 50, period: 8, phase: 1/2)
		t x, y; b delta
		delta + cur
	end
end

notes = tp_chain 0, -100, relative_beat: 1 do
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1/8; h -50, 50, 1; b 3/2
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1/8; h -50, 50, 1/2; b 1/2

	b 1/2
	grid 1/8; h -50, -50, 1/2; b 1
	grid 1; t -50, 50; b 1/2
	t -50, -50; b 1/2
	t -50, 50; b 1/2
end
transform(duplicate notes) { translate 50, 0 }.each_with_object %w[め た メ タ メ タ] do |note, lyrics|
	note[:text] = lyrics.shift if note[:text]
	break if lyrics.empty?
end
transform(duplicate notes) { translate 100, 0 }
f 0, 0, :ul, ?ユ; b 1

### Voice 3 (melody 2)

tp_drop 0, 0, relative: false, relative_beat: 4, preserve_beat: false do
	4.times do |i|
		h 100*(-1)**i, -50, 4-1/2; b 4
	end
end
tp_drop 0, 100, 1, preserve_beat: false do
	[
		4-1/4, 1/4, 4, 4-1/4, 1/4, 2, 2-1/4, 1/4
	].flatten.each do |delta|
		t 0, -50; b delta
	end
end
group preserve_beat: false do
	[
		[
			[1/2, ?何], [1/2, ?処], [1/2, ?に], [1/2, ?も], [1, '無い'], [1/2, ?か], [1/2, ?ら],
			[1/2, ?寝], [1/2, ?て], [1/2, ?い], [1/2, ?た], [2, ?ら]
		],
		[
			[1/2, ?壊], [1/2, ''], [1/2, ?れ], [1/2, ?て], [1, '泣い'], [1/2, ?て], [1/2, ?る],
			[1/2, ?ユ], [1/2, ?メ], [1/2, ?を], [1/2, ?診], [1, 'たん']
		]
	].each do |data|
		data.each_with_index.reduce 0 do |cur, ((delta, text), i)|
			bg_note -100 + 200/6*cur, -25, text; b delta
			cur + delta
		end
	end
end
def simple_pattern ending = false
	group do
		tp_chain -100, 100, 1 do
			f -100, 25, :dl; b 1/2
		end
		tp_chain -100, -100, 1 do
			t -75, 0 unless ending; b 1
		end
		tp_chain -100, 100, 1 do
			f -50, 25, :dl, ending ? ?だ : ''; b 1/2
		end
		tp_chain -100, -100, 1 do
			t -25, 0, ending ? ?よ : ''; b 1/2
		end
	end
end
b 3/2
simple_pattern

b 1/2
tp_chain 0, -100, 1 do
	t 50, 50; b 1/4
	d 62.5, 25; b 1/4
	d 75, 37.5; b 1/4
	d 87.5, 12.5; b 1/4
end
transform(simple_pattern) { horizontal_flip }

b 3/2
simple_pattern

b 1/2
tp_chain 100, 100, 1 do
	f 50, 50, :ul; b 1
end
transform(simple_pattern true) { horizontal_flip }

def strike_pattern
	diamond_grid 2
	group do
		5.times do |i|
			tp_chain -100, 0, 1 do
				f -75 + 18.75*i, 50 - 12.5*i, :ul
			end
			tp_chain 0, 100, 1 do
				f -100 + 18.75*i, 12.5 - 6.25*i, :ul
			end
			b 1/2
		end
		b 1/2
	end
end
strike_pattern
b -1/8; t -50, 25, ?次; b 1/8+1/2
t -25, 0, ?期; b 1/2

transform(strike_pattern) { horizontal_flip }
def center_text text1, text2
	group do
		group preserve_beat: false do
			bg_note 0, 37.5, text1; b 1/2
			bg_note 0, 12.5, text2; b 1/2
		end
		notes = tp_chain 0, 100, beat_speed: 50 do
			t -25, 37.5; b 1/2
			t -25, 12.5; b 1/2
		end
		transform(duplicate notes) { horizontal_flip }
	end
end
center_text ?に, ?は

def strike_pattern2
	diamond_grid 1/2
	group do
		tp_chain 100, 0, 1 do
			f -75, 50, :dl
		end
		tp_chain 0, 100, 1 do
			f -37.5, 25, :dl
		end
		b 1/2
		tp_chain 100, 0, 1 do
			f -87.5, 12.5, :dl
		end
		tp_chain 0, 100, 1 do
			f -50, -12.5, :dl
		end
		b 1/2
	end
end
strike_pattern2
center_text ?嘘, ''
transform(strike_pattern2) { horizontal_flip }
transform(center_text ?に, ?診) { vertical_flip }

notes = tp_drop -100, 100, 1, preserve_beat: false do
	f -50, 37.5, :ul; b 1
	f -75, 0, :ul; b 1
	f -100, -37.5, :ul; b 2
end
tp_chain 0, 100, beat_speed: 50 do
	diamond_grid 1/8
	f 0, 50, :u; b 1/2
	bg_note 0, 25, ?え; b 1/2
	diamond_grid 1/8
	f 0, 0, :u, ?て; b 1/2
	bg_note 0, -25, ?ク; b 1/2
	diamond_grid 1/2
	f 0, -50, :u, 'ルゥ'; b 1
end
transform(duplicate notes) { horizontal_flip }
f 0, 0, :ur, ?ユ; b 1

### Voice 4 (melody 3)

def melody3_background strong_onset = false
	group preserve_beat: false do
		checkerboard 1 if strong_onset
		4.times do |i|
			tp_drop -100, 0, 1 do
				if strong_onset && i.zero?
					f -75, 0, :l; f -25, 0, :l; b 1
				else
					t -75, 0; t -25, 0; b 1
				end
			end
			notes = tp_drop -100, -100, 1 do
				f -100, 25, :u; t -50, 25; b 1
			end
			transform(notes) { vertical_flip } if i.odd?
		end
	end
end
def arrow text
	t 75, 25, text; b 1
	5.times do |i|
		bg_note 75, 25 - 12.5*i
	end
	bg_note 62.5, -12.5
	bg_note 50, 0
	bg_note 87.5, -12.5
	bg_note 100, 0
end
def arrow_sentence texts
	tp_drop 0, 100, 1 do
		t 50, 50, texts[0]; b 1/2
		t 100, 50, texts[1]; b 1/2
		arrow texts[2]
		t 50, -25, texts[3]; b 1/2
		t 62.5, -50, texts[4]; b 1/2
		t 75, -25, texts[5]; b 1/2
		t 87.5, -50, texts[6]; b 1/2
		t 100, -25, texts[7]; b 1
		t 75, -50, texts[8]; b 1
		t 50, -25, texts[9]; b 2
	end
end
def sixteenth_strike texts
	tp_drop -100, 0, 1 do
		diamond_grid (texts.size/4).floor - 1/2
		texts.each_with_index do |text, i|
			x = -6.25*i - 43.75*(i%2)
			y = 50 - 12.5*i
			t x, y, text
			tp_chain 100, 0, 1 do
				f x + 50, y, :ur
			end if i.even?
			b 1/4
		end
	end
end
def melody3 text1, text2, text3, text4, text5
	group do
		melody3_background true
		arrow_sentence text1
		b -3/2
		tp_chain 100, 0, 1 do
			t 0, 0; b 1/2
			8.times do |i|
				x = 25 + triangular_wave(i, amplitude: 12.5, period: 16, phase: 1/4)
				y = 50 - 6.25*i
				i % 4 == 0 ? t(x, y) : d(x, y); b 1/8
			end
		end
		
		transform(melody3_background) { horizontal_flip }
		transform(arrow_sentence text2) { horizontal_flip }
		b -7/2
		tp_chain -100, 0, 1 do
			3.times do |i|
				x = -75
				y = -50/3*i
				i.zero? ? t(x, y) : d(x, y); b 1/6
			end
			b 1/2
			8.times.each do |i|
				angle = -PI - atan2(25, -18.75)/8*i
				x = -18.75 + 31.25*cos(angle)
				y = -25 + 31.25*sin(angle)
				d x, y unless i.zero?; b 1/4
			end
		end
		b -1/2
		f 0, 0, :ul, ?ユ; b 1
		
		melody3_background true
		tp_drop 0, 100, 1 do
			t 25, 25, text3[0]; b 1/2
			t 50, 50, text3[1]; b 1/2
			t 75, 25, text3[2]; b 1
			t 12.5, 12.5, text3[3]; b 1/2
			t 37.5, 0, text3[4]; b 1/2
			t 62.5, -12.5, text3[5]; b 1/2
			t 87.5, -25, text3[6]; b 1/2
		
			h 25, -25, 1/2, text3[7]; b 1
			h 50, -37.5, 1/2, text3[8]; b 1
			h 75, -25, 1/2, text3[9]; b 1
		end
		tp_drop -100, 0, 1 do
			t 25, 0, text3[10]; b 1/2
			t 12.5, 25, text3[11]; b 1/2
		end
		
		sixteenth_strike text4
		b 3/4
		transform(sixteenth_strike text5) { translate 37.5, 0 }
		b 3/4
		tp_chain -100, 0, 1 do
			t -12.5, 25, ?だ
		end
	end
end
melody3 %W[顔 \s が 鈍 \s 器 に な っちゃう ヨ],
	%W[偽 \s が 権 \s 利 取 な ったん だ],
	%W[無 く な って ほ し い 煩 悩 が ドウ ヤラ],
	%W[生 き 延 び て し ま \s った],
	%W[生 き 延 び て し ま \s ったん]
tp_drop 0, 100, 1 do
	4.times do |i|
		t -62.5 + 12.5*i, 37.5 - 25*i; b 1/2
	end
	b -3/4; t 0, -12.5; b 3/4
end

### Voice 5 (melody 3)

transform(
	melody3 %W[足 \s が タ ガ メ に な っちゃう ヨ],
		%W[嘘 \s が 動 \s 機 に な ったん だ],
		%W[疑 \s \s って ほ し い 本 能 を],
		%W[本 \s 心 \s だ と 思 \s った],
		%W[本 \s 心 \s だ と 思 \s ったん]
) { horizontal_flip }
tp_drop 0, 100, 1 do
	t 75, 12.5; b 1/4
	t 50, 0; b 1/4
	t 62.5, -25; b 1/2
	t 25, -50
end
tp_chain 100, 0, 1 do
	t -37.5, -37.5, ?ク; b 1/2
	t -75, -50, 'チョォ'; b 1/2
end

### Interlude verse 2

transform(start_pattern) { horizontal_flip }
start_pattern false
transform(start_pattern) { horizontal_flip }

def three_chain x, y
	tp_chain 0, 100, beat_speed: 50 do
		h x, y, 3/2; b 1/2
		t x, y - 25; b 1/2
		t x, y - 50; b 1/2
	end
end
grid 6
tp_chain -100, 0, 1 do
	t -100, 50
end
three_chain 100, 50
three_chain -87.5, 37.5
three_chain 75, 25
three_chain -62.5, 12.5
tp_chain 0, 100, beat_speed: 50, preserve_beat: false do
	h 50, 0, 1; b 1/2
	t 50, -25; b 1/2
end
tp_drop -100, 0, 1 do
	t -50, 0; b 1/2
	t -50, -25; b 1/2
end
f 0, 0, :dl, ?ユ; b 1

### Voice 6 (melody 1 alter)

checkerboard 1/2
tp_drop 0, -100, 0.5 do
	f 100, 50, :r
	f 62.5, 50, :r
end
group preserve_beat: false do
	group_speed = 18.75
	phase_speed = 25
	height = 75
	[0, 25, 50, 75].each do |initial_y|
		group preserve_beat: false do
			time = 0
			96.times do
				y = (initial_y + phase_speed*time) % 100 - 50
				phase = (initial_y - group_speed*time) / height * 2*PI
				x = 75*cos(phase) + 12.5*cos(phase/1.5)
				bg_note x, y; bg_note -x, y; b 1/8
				time += 1/8
			end
		end
	end
end
tp_chain -100, 0, beat_speed: 50 do
	t -50, 37.5, 'ドク'; b 1
	t 0, 37.5, 'ター'; b 1
end
tp_chain -100, 0, beat_speed: 50 do
	t -25, 0, ?キ; b 1/2
	t 0, 0, ?ド; b 1/2
	t 25, 0, ?リ; b 1/2
	t 50, 0, 'です'; b 1/2
end

b 4

tp_chain 100, 0, beat_speed: 50 do
	t 50, 37.5, ?全; b 1
	t 0, 37.5, ?部; b 1
end
tp_chain 100, 0, beat_speed: 50 do
	t 25, 0, ?辞; b 1/2
	t 0, 0, ?め; b 1/2
	t -25, 0, ?ろ; b 1/2
	h -50, 0, 5/2, ?よ; b 1/2
end

tp_drop 0, 100, 1 do
	b 1/2
	d -50, 0; b 1/2
	d -50, 0; b 1/2
	d -50, 0; b 1/4
	d -50, 0; b 1/4
	d -50, 0
end
tp_chain 0, -100, 1, preserve_beat: false do
	8.times do |i|
		angle = PI - PI/8*i
		x = -25 + 25*cos(angle)
		y = 25*sin(angle)
		d x, y; b 1/4
	end
end
tp_chain 0, 100, 1 do
	b 1/2
	t 50, 50, 'アティ'; b 1/2
	t 62.5, 25, 'チュー'; b 1/2
	t 75, 0, 'ドが'; b 1/2
end

def tap_chain x, y, texts
	texts.each_with_index do |text, i|
		t x - 25*i, y - 12.5*i, text; b 1/4
	end
end
tp_drop -100, 0, 1, preserve_beat: false do
	[1, 3/2, 2, 3/2].each_with_index do |delta, i|
		x = -87.5
		y = -37.5 + triangular_wave(i, amplitude: 50, period: 8, phase: -1/4)
		i.zero? ? f(x, y, :l) : t(x, y); b delta
	end
	tp_chain -100, 0, 1 do
		[[1/4]*6, 1/12, 1/4, 1/6].flatten.reduce 0 do |cur, delta|
			x = -87.5 + 75*cur
			y = -37.5 + 25*cur
			cur.zero? ? t(x, y) : d(x, y); b delta
			cur + delta
		end
	end
end
tp_drop 0, 100, 1 do
	t 87.5, -25, ?感; b 1/2
	t 50, -37.5, ?動; b 1/2
	t 12.5, -50, ?物; b 1/2
	tap_chain 100, 0, %W[に 届 \s く 猛]; b 1/4
	tap_chain 87.5, 12.5, %W[毒 \s 損]; b 1/4

	tap_chain 75, 25, %W[得 \s の]; b 1/4
	tap_chain 62.5, 37.5, %W[得 \s の]; b 1/4
	t 50, 50, ?方; b 1/2
	t 12.5, 37.5, ?ダ; b 1/2
	t -25, 25, ?ケ; b 1/2
	t -62.5, 12.5, ?回; b 1/2
end

tp_drop 0, 100, 1, preserve_beat: false do
	t 62.5, 12.5; b 1/2
	t 62.5, 12.5; b 1
	tp_chain 0, 100, 1 do
		f -62.5, 12.5, :r; b 1/4
		d -50, 12.5; b 3/4
	end
	t 62.5, 12.5; b 1
	tp_chain 0, 100, 1 do
		f -62.5, 12.5, :r; b 1/4
		d -50, 12.5; b 1/4
	end
	b 1/2
	h 62.5, -12.5, 1; b 5/2
	t -62.5, -12.5; b 1
end
tp_chain 0, -50, relative: false, relative_beat: 1 do
	t 0, 50, ''; b 1
	h 0, -50, 1/2, 'った'; b 3/2
	t 0, 50, ?割; b 1
	t 0, -50, 'った'; b 1/2

	b 1/2
	t 0, 50, ?割; b 1
	h 0, -50, 5/3, 'った'; b 1/2+1/8
end
tp_drop 0, 100, relative_beat: 1 do
	7.times { d 0, -50; b 1/8 }
end
b 1

tp_chain 0, 100, beat_speed: 50 do
	t 0, 25; b 1/2
	turntable 2
	h 0, 0, 2; b 2
end
tp_drop 0, -100, 1 do
	t 25, -25; b 1/2
	f 0, -25, :u; b 1/2
	t -25, -25; b 1/2
end

### Voice 7 (melody 3)

grid 1/2
notes = group do
	tp_chain 25, -37.5, 0.5, relative: false do
		t -12.5, 37.5
	end
	tp_chain 12.5, 37.5, 0.5, relative: false do
		t -25, -37.5
	end
	tp_chain -12.5, 37.5, 0.5, relative: false do
		t 25, -37.5
	end
	tp_chain -25, -37.5, 0.5, relative: false do
		t 12.5, 37.5
	end
end
transform(duplicate notes) { vertical_flip; beat_translate 1/2 }
transform(duplicate notes) { translate 62.5, 0; beat_translate 1 }
transform(notes) { translate -62.5, 0 }
bg_note -62.5, 0, ?顔; b 1/2
bg_note 0, 0, ''; b 1/2
bg_note 62.5, 0, ?が; b 1/2
0.upto 12 do |i|
	bg_note -75 + 12.5*i, -25
end
4.times do |i|
	bg_note 50+6.25*i, -6.25*i
	bg_note 50+6.25*i, -50 + 6.25*i
end
tp_drop 0, 0, 0.5, relative: false do
	h -100, 0, 1/4
	h 100, 0, 1/4
	b 1/2
end
diamond_grid 2
group preserve_beat: false do
	[*%W[鈍 \s 器 に].zip([1/2]*4), *%W[な っちゃう ヨ].zip([1,1,2])].each_with_index do |(text, delta), i|
		bg_note -75 + 25*i, 25, text; b delta
	end
end
notes = group do
	x = -75
	tp_drop 0, 100, 0.5 do
		t x, -50; b 1/2
	end
	tp_drop 0, -100, 0.5 do
		8.times do |i|
			y = 50 - 100*(i/8)**2
			i.zero? ? t(x, y) : d(x, y); b 1/8
		end
	end
	tp_drop 0, 100, 0.5 do
		4.times do |i|
			y = -50 + i*25
			d x, y; b 1/8
		end
	end

	tp_drop 0, -100, 0.5 do
		f x, -50, :u; b 1/2
	end
	tp_drop 0, 100, 0.5 do
		f x, 50, :d; b 1/2
	end
end
(1...4).each do |i|
	transform(duplicate notes) { translate 50*i, 0 }
end
hexagon 1/2
4.times do |i|
	tp_chain 100*(-1)**i, 0, 0.5 do
		t 0, 0; b 1/4
	end
end
notes = tp_chain -100, -50, relative: false, relative_beat: 2 do
	t 100, 50
end
transform(duplicate notes) { horizontal_flip }
transform(duplicate notes) { vertical_flip; beat_translate 1/2 }
transform(duplicate notes) { rotate PI; beat_translate 1/2 }
b 1
big_text 1/8, 'Drop it'
notes = group do
	note = tp_chain -25, 25*sqrt(3), 0.5, relative: false do
		t 25, -25*sqrt(3)
	end
	transform(duplicate note) { rotate PI }
	note = tp_chain -75, -25*sqrt(3), 0.5, relative: false do
		t 75, 25*sqrt(3)
	end
	transform(duplicate note) { rotate PI }
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1

def melody3_alter_background
	group preserve_beat: false do
		4.times do |i|
			4.times do |j|
				angle = PI/4 + PI/2*j
				x = 81.25 + 18.75*sqrt(2)*cos(angle)
				y = 18.75*sqrt(2)*sin(angle)
				tp_chain -100*cos(angle), -100*sin(angle), 1 do
					i.even? && j.zero? ? f(x, y, :ur) : t(x, y)
				end
				b 1/2
			end
		end
	end
end
melody3_alter_background
group preserve_beat: false do
		bg_note -25, 50, ?偽; b 1/2
		bg_note 0, 50, ''; b 1/2
		bg_note 25, 50, ?が; b 1
		5.times do |i|
			bg_note 0, 37.5 - 12.5*i
		end
		bg_note -12.5, 0
		bg_note -25, 12.5
		bg_note 12.5, 0
		bg_note 25, 12.5
		bg_note -25, -25, ?権; b 1/2
		bg_note 0, -25, ''; b 1/2
		bg_note 25, -25, ?利; b 1/2
		bg_note 50, -25, ?を; b 1/2
		bg_note -12.5, -50, ?取; b 1
		bg_note 12.5, -50, 'ったん'; b 1
		bg_note 37.5, -50, ?だ; b 2
end
checkerboard 1/2
f -50, 0, :l; b 1/2
tp_chain -100, 0, 1 do
	t -100, 50; b 1/2
	t -87.5, 25; b 1/2
	t -75, 0; b 1/2
	t -62.5, -25; b 3/2
end
tp_chain -100, 0, 1 do
	t -100, 50; b 1/2

	t -87.5, 25; b 1/2
end
tp_drop -100, 0, 1 do
	t -75, 0; b 1/6
	d -62.5, -25/3; b 1/6
	d -75, -50/3; b 1/6
	t -62.5, -25; b 1
end
tp_chain -100, 0, 1 do
	6.times do |i|
		x = -25 + 18.75*(-1)**i + 6.25*(-1)**(i/2).floor
		y = -50 + i*12.5
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
b -1/2
f 0, 0, :ul, ?ユ; b 1

checkerboard 1/2
transform(melody3_alter_background) { horizontal_flip }
tp_drop 0, 100, 1 do
	h 25, 37.5, 1/2, ?無; b 1/2
	h 50, 50, 1/2, ?く; b 1/2
	h 75, 37.5, 1/2, ?な; b 1
	t 37.5, 25, 'って'; t 62.5, 25; b 1/2
	t 37.5, 25/3, ?ほ; t 62.5, 25/3; b 1/2
	t 37.5, -25/3, ?し; t 62.5, -25/3; b 1/2
	t 37.5, -25, ?い; t 62.5, -25; b 1/2
	h 25, -37.5, 1, ?煩; b 1
	h 50, -50, 1, ?悩; b 1
	h 75, -37.5, 1/2, ?が; b 1
end
tp_drop -100, 0, 1 do
	t 25, 0, 'ドウ'; b 1/2
	t 12.5, 25, 'ヤラ'; b 1/2
end

=begin
def sixteenth_strike texts
	tp_drop -100, 0, 1 do
		diamond_grid (texts.size/4).floor - 1/2
		texts.each_with_index do |text, i|
			x = -6.25*i - 43.75*(i%2)
			y = 50 - 12.5*i
			t x, y, text
			tp_drop 100, 0, 1 do
				f x + 50, y, :ur
				f x + 87.5, y, :ur
			end if i.even?
			b 1/4
		end
	end
end
=end
sixteenth_strike %W[生 き 延 び て し ま \s った]; b 3/4
transform(sixteenth_strike %W[生 き 延 び て し ま \s ったん]) { horizontal_flip }; b 3/4
tp_drop -100, 0, 1, preserve_beat: false do
	t -50, -25; b 1/4
	t -25, -12.5; b 1/4
	t -50, 0; b 1/2
	t -37.5, 37.5; b 1/4
	t -62.5, 50; b 3/4
end
tp_chain 100, 0, 1 do
	t 50, 0, ?だ; b 5/4
end
tp_drop -100, 100, 1 do
	12.times do |i|
		x = 100 - 125*(i/12)**3
		y = 50 - 100*(i/12)**2
		i.zero? ? t(x, y) : d(x, y); b 1/16
	end
end

### Vocal 8 (melody 3 alter)

checkerboard 1/2
group preserve_beat: false do
	32.times do |i|
		angle = PI/8*i
		bg_note 50*cos(angle), 50*sin(angle)
		bg_note -50*cos(angle), -50*sin(angle)
		b 1/8
	end
end
tp_chain -100, 100, 1 do
	f -25, -50, :u; b 1/2
end
def simple_arrow
	9.times do |i|
		bg_note -50 + 100*i/8, 0
	end
	2.times do |i|
		x = 25 + 25*i/2
		y = 25 - 25*i/2
		bg_note x, y
		bg_note x, -y
	end
end
%W[音 \s が 機 能 \s に な].each_with_index do |text, i|
	angle = 3*PI/8 + 7*PI/8*i
	tp_chain -100*cos(angle), -100*sin(angle), 1 do
		t 50*cos(angle), 50*sin(angle), text
	end
	tp_chain 0, 100, 1 do
		t 0, 0; b 1/2 unless i == 7
	end
	simple_arrow if i == 3
end

b 1
group preserve_beat: false do
	bg_note 0, 25, 'って'; b 1/2
	bg_note 0, 0, ?し; b 1/2
	bg_note 0, -25, ?ま; b 1
	bg_note 0, -50, ?う; b 1
end
notes = group preserve_beat: false do
	b 1
	8.times do |i|
		angle = -PI/2 + PI/8*i
		bg_note 50*cos(angle) + i*12.5, 50*sin(angle)
		bg_note -50*cos(angle) - i*12.5, -50*sin(angle)
		b 1/8
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1 }
notes = tp_chain -100, 0, 1 do
	t 75, 37.5; b 1/2
	t 75, -37.5; b 1/2
	8.times do |i|
		angle = -PI/2 + PI*(i/8)**2
		x = 50*cos(angle)
		y = 50*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
transform(duplicate notes) { rotate PI }
tp_chain 100, 0, 1 do
	8.times do |i|
		x = 50 - 100*i/8
		y = triangular_wave i, amplitude: 25, period: 16, phase: -1/4
		i % 4 == 0 ? t(x, y) : d(x, y); b 1/8
	end
end

tp_drop 0, 100, 1 do
	t -75, -25; t 75, -25; b 1/2
end
tp_drop 100, 0, 1, preserve_beat: false do
	t 50, 50; b 1/4
	t -75, 37.5; b 1/2
	t -75, 12.5; b 1/4
	t 50, 0
end
tp_drop 0, -100, 1 do
	t -25, 50, ?人; b 1/2
	t -62.5, 25, ''; b 1/2
	t -25, 0, ?が; b 1/2
end
simple_arrow
tp_drop 0, 100, 1 do
	t -100, 0, ?偽; t 100, 0; b 1/2
	t -75, -25, ''; t 75, -25; b 1/2
	t -50, -50, ''; t 50, -50; b 1/2
	bg_note -100, 50, ?り; b 1/2
end

group preserve_beat: false do
	24.times do |i|
		angle = PI/8*i
		x = cos angle
		y = sin angle
		scale = [100 / x.abs, 50 / y.abs].min
		x *= scale
		y *= scale
		bg_note x, y
		bg_note -x, -y
		b 1/8
	end
end
tp_drop 0, -100, 1 do
	h -75, 50, 1/2, ?に
end
tp_chain 0, -100, 1 do
	h 75, 50, 1/2; b 1/2
	t -12.5, 25; b 1/6
	t 12.5, 12.5; b 1/6
	t -12.5, 0; b 1/6
end
notes = tp_drop 100, 100, 1, preserve_beat: false do
	t 12.5, -12.5, ?集; b 1/2
	t 50, -12.5, ''; b 1/2
	tp_chain 100, 100, 1 do
		6.times do |i|
			angle = -PI/4*i
			x = 62.5 + 25*cos(angle)
			y = -12.5 + 25*sin(angle)
			i.zero? ? t(x, y, ?ま) : d(x, y); b 1/4
		end
	end
end
b 1
t 0, -50; b 1
bg_note 37.5, -12.5, ?る
f 0, 0, :ur, ?ユ; b 1
transform(duplicate notes[1..]) { horizontal_flip }

def bullet x, y, direction
	dx, dy, angle = case direction
	when :ul
		[-25, 12.5, PI/4]
	when :ur
		[25, 12.5, 3*PI/4]
	when :dl
		[-25, -12.5, 3*PI/4]
	when :dr
		[25, -12.5, PI/4]
	end
	angle += PI if y > 0
	tp_drop 100*cos(angle), 100*sin(angle), 1 do
		t x, y; b 1/4
		t x + dx, y + dy; b 1/4
	end
end
group preserve_beat: false do
	ear_points = [
		[40.8,20.1], [45.2,30.1], [52.3,40.1], [59.7,46.4], [70.0,48.7], [80.4,47.5], [93.8,39.7],
		[99.0,24.9], [92.7,7.1], [85.6,-5.5], [80.1,-17.7], [75.2,-31.5], [71.2,-41.1], [63.4,-50.8], [54.9,-45.2]
	]
	bud = [55.6, -1.4]
	b 3
	ear_points.each do |(x, y)|
		bg_note x, y, 4
		bg_note -x, y, 4
	end
	b 1

	b 1
	8.times do |i|
		angle = PI/4*i
		x = bud[0] + 5*cos(angle)
		y = bud[1] + 5*sin(angle)
		group preserve_beat: false do
			bg_note x, y, 2
			b 1
			bg_note -x, y, 1
		end
	end
end
group preserve_beat: false do
	bg_note -25, 25, ?塞; b 1/2
	bg_note 0, 25, ''; b 1/2
	bg_note 25, 25, ?が; b 1
	bg_note -37.5, 0, 'って'; b 1/2
	bg_note -12.5, 0, ?し; b 1/2
	bg_note 12.5, 0, ?ま; b 1/2
	bg_note 37.5, 0, ?え; b 1/2
	
	bg_note -25, -25, ?よ; b 1
	bg_note 0, -25, ?耳; b 1
	bg_note 25, -25, ''; b 2
end
bullet -87.5, 37.5, :dr
bullet 50, 25, :dl
bullet -75, 0, :ul
bullet 75, 0, :ur
bullet -37.5, -12.5, :dr
bullet 25, -37.5, :dr
bullet -62.5, 25, :ul
bullet 50, -25, :ul

bullet -37.5, 37.5, :ur
bullet 75, 12.5, :ul
bullet -50, 0, :dr
bullet 25, 25, :dl
bullet -62.5, -50, :ur
bullet 50, -25, :dl
tp_chain 0, 100, 1 do
	t 0, -50, 'ドウ'; b 1/2
	t 0, -12.5, 'ヤラ'; b 1/4
	bg_note 0, 0, ?ユ; b 1/4
end

def sixteenth_strike3 texts
	group do
		notes = tp_drop -100, 0, 1, preserve_beat: false do
			5.times do |i|
				f -50, 50 - 25*i, :u; b 1/2
			end
		end
		texts.each_with_index do |text, i|
			x = 12.5*(-1)**i
			y = 50 - i*12.5
			tp_chain -100*(-1)**i, 100, 1 do
				i.even? ? bg_note(x, y, text) : t(x, y, text); b 1/4
			end
		end
		transform(duplicate notes) { horizontal_flip }
	end
end
sixteenth_strike3 %W[届 \s い て な い 診 \s たい]; b 3/4
transform(sixteenth_strike3 %W[届 \s い て な い 診 \s たい]) { rotate PI }; b 3/4
h 0, 0, 1/2, ?ネ; b 1
tp_drop 0, 0, relative: false, relative_beat: 1 do
	t -75, 25, ?ク; b 1/4
	t 75, 25; b 1/4
	t -75, -25, 'チョォ'; b 1/4
	t 75, -25; b 1/4

	f -100, 50, :r
	f 100, 50, :l
	f -100, -50, :r
	f 100, -50, :l
end

end
