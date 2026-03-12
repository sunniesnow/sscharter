Integer.alias_method :/, :quo
include Math

Sunniesnow::Charter.open 'master' do

title 'Lucky Clover'
artist '水瀬いのり'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '13'

offset 0.493
bpm 177

@connected = Set[]
def duplicate_connected events
	result = duplicate events
	result.zip events do |new_event, old_event|
		if @connected.include? old_event
			@connected.add new_event
		end
	end
	result
end

notes = group preserve_beat: false do
	bg_note -8, 4; b 1/2
	bg_note -6, 0; b 1/2
	bg_note -6, 3; b 1/2
	bg_note -5, 0; b 1/2
	bg_note -4, 4; b 1/2
	bg_note -4, 0; b 1/2
	bg_note -2, 3; b 1/2
	bg_note -3, 0; b 1/2
end
transform duplicate notes do
	horizontal_flip
	beat_translate 4
end
transform duplicate notes do
	rotate PI
	beat_translate 8
end
transform duplicate notes do
	vertical_flip
	beat_translate 12
end

notes = tp_chain 8, 0, 1 do
	t 4, 2; b 3/2
	t 4, -2; b 5/2

	b 4
end
transform duplicate notes do
	horizontal_flip
	beat_translate 8
end

b 4

b 1
tp_chain 8, 0, 1 do
	6.times do |i|
		prog = i/6
		x, y = 8-6*prog, 2*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/6
	end
	t 2, 2
end
b -1/3
tp_chain -8, 0, 1 do
	t -4, -1; b 1/3
	t -2, -2; b 1/2
end
notes = tp_chain 0, 8, 1 do
	t -2, 2; b 1
end
transform duplicate notes do
	rotate PI
end
tp_chain 0, -8, 1 do
	t -1, 0; b 1/4
	t 1, 1; b 1/4
end

def interlude_pattern glissando = false; group do
	tp_drop -8, 0, 1, preserve_beat: false do
		tp_chain -8, 0, 1 do
			12.times do |i|
				prog = i/12
				x, y = -7+4*prog**2, 4-8*prog
				i.zero? ? t(x, y) : d(x, y); b 1/16
			end
			b 1/4
		end if glissando
		grid glissando ? 6 : 7
		(glissando ? 7 : 8).times do |i|
			t -4, 1
			4.times do |j|
				bg_note -3-2*(-1)**i-j, 3-j*2; b 1/4
			end
		end
	end
	tp_chain 0, 8, 1 do
		notes = group do
			t 3, 2; b 1/2
			t 5, 0; b 1/2
			t 8, 1; b 1/2
			t 6, -1; b 1/2
		end
		transform duplicate notes, new_tip_points: false do
			vertical_flip
			beat_translate 2
		end
		b 2

		b 1/2
		t 1, 1; b 1
		t 3, -2; b 1
		t 4, 2; b 1/2
		t 2, 3; b 1
	end
	b -2
	bg_note 7, 2; b 1/2
	2.times do |i|
		3.times { |j| bg_note 7+(-1)**i, -2*j; b 1/4 }
	end
end; end
def attach_bg_notes notes, dx, dy
	group preserve_beat: false do
		notes.each do |note|
			next unless %i[tap flick drag hold].include? note.type
			b! note.beat
			bg_note note[:x]+dx, note[:y]+dy
		end
	end
end
def center_lyrics texts, delta_beats, y, distance = sqrt(3)
	n = texts.length
	group do
		texts.chars.zip(delta_beats).each_with_index do |(char, delta_beat), i|
			char = '' if char == ?\s
			x = (-(n-1)/2 + i) * distance
			bg_note @flipping ? -x : x, y, char
			b delta_beat
		end
	end
end
def align_lyrics duration, &block
	cur = beat
	notes = group &block
	notes.each do |note|
		next unless note.type == :bg_note
		note.duration_beats = cur + duration - note.beat
	end
end
def big_bg_note x, y, texts
	notes = group do
		6.times do |i|
			angle = i/6*2*PI
			bg_note x+cos(angle)/2, y+sin(angle)/2
		end
		texts.chars.each_with_index do |text, i|
			bg_note x+(1-texts.length)/2+i, y, text
		end
	end
	transform(notes) { horizontal_flip } if @flipping
end

def interlude second = false; group do
interlude_pattern

checkerboard 1/2
notes = tp_chain 0, -8, 1 do
	t 2, -3; b 1/2
	t 4, -1; b 1/2
	t 2, 1; b 1/2
	f 4, 3, :r
end
checkerboard 1/2; b 1
notes.concat(tp_chain 0, -8, 1 do
	t 4, -4; b 1/2
	t 2, -1; b 1/2
	f 5, 1, :r
end)
checkerboard 1/2; b 1/2
notes.concat attach_bg_notes notes, 1, 1
transform duplicate notes do
	horizontal_flip
end

tp_chain 8, 0, 1, preserve_beat: false do
	b 1/2
	t 4, 3; b 1/2
	t 3, 0; b 1/2
	t 2, -3; b 1
	t -5, -1; b 1/2
	t -6, 2; b 1
end
tp_chain 0, 8, 1 do
	b 1
	f -4, 3, :ul; b 2
	t 6, 3; b 1/2
end
tp_chain 0, -8, 1 do
	t 1, 0; b 1/4
	t -1, 1; b 1/4
end

transform interlude_pattern second do
	horizontal_flip
end

checkerboard 1/2
notes = tp_chain 0, -8, 1 do
	t 4, 3; b 1/2
	t 2, 1; b 1/2
	t 4, -1; b 1/2
	f 6, -3, :r
end
checkerboard 1/2; b 1
notes.concat(tp_chain 0, -8, 1 do
	t 2, -3; b 1/2
	t 5, -1; b 1/2
	f 6, 2, :r
end)
checkerboard 1/2; b 1/2
notes.concat attach_bg_notes notes, 1, 1
transform duplicate notes do
	rotate PI
end

tp_chain 0, 8, 1 do
	b 1/2
	t 0, 0; b 1/2
	notes = group do
		3.times do |i|
			2.times do |j|
				t 2+2*i, 3-i-2*j; b 1/2
			end
		end
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
end; end
interlude

group preserve_beat: false do
	b 4

	bg_note 4, -1; b 2
	bg_note 4, 1; b 2
end

def pattern second = false; group do
	diamond_grid 5
	group preserve_beat: false do
		(second ? 3 : 4).times do |i|
			tp_chain -8, 0, 1 do
				t -7+2*i, -3; b 1/2
				t -7+2*i, -1; b 1/2
				f -7+2*i, 1, :u
				bg_note -8+2*i, 2
				bg_note -6+2*i, 2
				b 1
			end
		end
	end
	tp_chain 8, 0, 1 do
		notes = group do
			t 7, -3; b 1/2
			t 7, -1; b 1/2
			bg_note 7, 1; b 1/2
		end
		(1...4).each do |i|
			transform duplicate notes, new_tip_points: false do
				translate -4, 0
				rotate PI/2*i
				translate 4, 0
				beat_translate 3/2*i
			end
			b 3/2
		end
		if second
			mark :m
			b -2
		else
			t 7, -3; b 1/2
			bg_note 7, -1; b 1/2
			t 7, 1; b 1/2
			bg_note 7, 3; b 1/2
		end
	end
end; end
pattern

group preserve_beat: false do
	bg_note -4, 1; b 5/2
	bg_note -4, -1; b 1
	bg_note 5, 0; b 1/2

	notes = group do
		4.times do |i|
			angle = PI/8 - PI/12*i
			r = 3/sin(PI/8)
			x, y = 8-r+r*cos(angle), r*sin(angle)
			bg_note x, y; b 1/4
		end
	end
	transform duplicate notes do
		translate -2, 0; beat_translate 1
	end
	transform duplicate notes do
		vertical_flip; beat_translate 2
	end
	transform duplicate notes do
		vertical_flip; translate -2, 0; beat_translate 3
	end
end

transform pattern true do
	rotate PI
end

tp_chain 0, -8, 1 do
	b 3/2
	t 2, -3; b 1/3
	d 1, -2; b 1/6
	4.times do |i|
		prog = i/4
		angle = PI/4 - PI/2*prog
		x, y = -9+2*sqrt(2)*cos(angle), 1+2*sqrt(2)*sin(angle)
		i.zero? ? at(:m) { f x, y, :dr } : d(x, y); b 1/4
	end
	at :m do
		grid 2; b 1/2
		bg_note -7, 1; b 1/2
		t -7, -1; b 1/2
		bg_note -7, -3; b 1/2
		t -5, 3
	end
	t 2, 4; b 1/4
	t 3, 3; b 1/4
	t -3, 0; b 1/4
	t 2, -2; b 1/4
	t 1, -3
end

group preserve_beat: false do
	align_lyrics 11 do
		center_lyrics 'なにげなく', [1, 1/2, 1, 1, 5/2], 1
		center_lyrics '通り過ぎて', [1, 1/2, 1, 1/2, 4], -1
	end
	align_lyrics 15 do
		center_lyrics '足 元 ', [1, 1/2, 1, 2], 2
		center_lyrics '気づかず', [1/2, 1/2, 1, 3/2], 0
		center_lyrics '見過ごしてた', [1/2, 1, 1, 1, 1/2, 1], -2
	end
end

b 1
tp_drop -8, 0, 1 do
	t -6, -1; b 1
end
def pattern2
	tp_drop 8, 0, 1 do
		b 1/2
		t 5, 1; b 1/2
		t 6, -1; b 1
	end
end
pattern2

def pattern1
	tp_drop -8, 0, 1 do
		t -5, 3; b 1
		t -6, -1; b 1
	end
end
transform pattern1 do
	vertical_flip
	translate -1, 0
end
transform pattern2 do
	vertical_flip
	translate 1, 0
end

transform pattern1 do
	horizontal_flip
end
transform pattern2 do
	horizontal_flip
end

transform pattern1 do
	rotate PI
	translate -1, 0
end
tp_drop -8, 0, 1 do
	t -6, 3; b 1/2
	f -6, 1, :l; b 1/2
	t -7, -1; b 1/2
end
tp_drop 8, 0, 1 do
	t 5, 1; b 1/4
	t 4, 2; b 1/4

	f 5, 3, :r; b 1
	t 5, -1; b 1
end
transform pattern2 do
	horizontal_flip
end

transform pattern1 do
	rotate PI
	translate 1, 0
end
transform pattern2 do
	rotate PI
	translate -1, 0
end

tp_drop -8, 0, 1 do
	t -5, 3; b 1
	t -6, -1; b 1/2
	t -5, -3; b 1/2
end
tp_drop 8, 0, 1 do
	t 5, 3; b 1/2
end
tp_chain 0, 8, 1 do
	6.times do |i|
		t -(-1)**i, 2-i; b 1/4
	end
end

diamond_grid 5/2
notes = tp_drop 8, -8, 1, preserve_beat: false do
	t 2, -4; b 1/2
	f 4, -2, :r; b 1
	t 2, 2; b 1
	f 6, 4, :r; b 1
end
attach_bg_notes notes, 1, 0
notes = tp_drop -8, -8, 1 do
	t -2, -4; b 1/2
	t -4, -2; b 1
	f -2, 2, :l; b 1
	t -6, 4; b 1
end
attach_bg_notes notes, -1, 0
tp_chain 0, 8, 1 do
	t -1, -1; b 1/4
	t -3, -2; b 1/4
	t 5, -3
end

group preserve_beat: false do
	align_lyrics 13 do
		center_lyrics '幸  せの', [1, 1/2, 1, 1, 5/2], 1
		center_lyrics '4つ葉があって', [1, 1/2, 3/2, 1, 3/2, 0, 5/2], -1
	end
	align_lyrics 13 do
		center_lyrics '負けないようにって', [1, 1, 1/2, 1/2, 1/2, 1, 1, 0, 5/2], 1
		center_lyrics '咲いてたの', [1, 1/2, 1, 1/2, 2], -1
	end
end

turntable 1/2
transform pattern1 do
	vertical_flip
end
transform pattern2 do
	vertical_flip
end

transform pattern1 do
	translate -1, 0
end
tp_drop 8, 0, 1 do
	b 1/2
	t 6, 1; b 1/2
	f 7, -1, :r; b 1
end

tp_drop 0, 8, 1 do
	t -5, -2
end
transform pattern1 do
	rotate PI
end
tp_drop 0, 8, 1 do
	t -5, -3; t 5, -2
end
transform pattern2 do
	rotate PI
end
tp_drop 0, -8, 1, preserve_beat: false do
	b -1/2
	f -4, 3, :l
	f 4, 2, :r
end

tp_chain 0, -8, 1 do
	b 1/2
	t 1, 2; b 1/2
	tp_drop(-8, 8, 1) { f -2, 0, :l }; b 1/2
	t 2, -2; b 1/2
	t -3, -4
	tp_drop(8, 8, 1) { f 4, -4, :r }; b 3/4
	t -6, -3; b 1/4
	t -7, -2
	tp_drop(-8, 8, 1) { t 8, -1 }; b 3/4
	t 5, 1; b 1/4
	t 6, 2

	tp_drop(8, 8, 1) { f -4, 3, :l }; b 3/2
	t -6, 0; b 1/2
	t -4, -2
	tp_drop(0, 8, 1) { t 4, -1 }; b 1
	t 3, -4; b 1/2
	t -1, -3; b 1/4
	t 1, -2; b 1/4

	t -1, -1; b 1/2
	f 2, 0, :ur; b 1
	t -5, 1; b 1/2
	f -7, 2, :ul; b 1/2
end
tp_chain 0, 8, 1 do
	6.times do |i|
		t (-1)**i, 2-i; b 1/4
	end
end

tp_drop 8, 0, 1, preserve_beat: false do
	t 2, -4; b 1
	f 2, 4, :r; b 1
	t 4, 0; b 1/2
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1
	t -2, 4; b 1/2
	t -3, 2; b 1/2
	f -4, 0, :l; b 1/2
end
tp_chain 0, -8, 1 do
	t 1, -2; b 1/4
	t -1, -3; b 1/4
	t 1, -4; b 1/2
end
diamond_grid 9/2
notes = tp_drop 8, -8, 1 do
	f 4, -2, :dr; b 1/2

	b 1/2
	f 4, 2, :ur; b 1
end
notes.concat attach_bg_notes notes, 1, 0
transform duplicate notes do
	rotate PI
end
tp_chain 0, 8, 1 do
	t 0, 1; b 1/4
	t -2, 0; b 1/4
	tp_drop(8, -8, 1) { h 3, -2, 1 }
	t -4, -1; b 1/2
	t -7, 0; b 1/2
	t -8, 3; b 1

	f 5, 4, :r
end
tp_chain -8, 0, 1 do
	t -4, 2, ?曖; b 1
	bg_note -2, 2; b 1
	t 0, 2, ?昧; b 3/2
	t 3, 2; b 1/2

	t 5, 2, ?な; b 5/2
end
tp_chain -8, 0, 1 do
	t -2, 0, ?気; b 1/2
	t 0, 0, ?持; b 1/2
	t 2, 0, ?ち; b 1/2
end

tp_chain -8, 0, 1 do
	b 1
	t -3, -2, ?が; b 1/2
	t -1, -2, ?き; b 1
	bg_note 1, -2, ?っ; b 1
	h 3, -2, 3, ?と; b 1/2
end

b 4

tp_chain -8, 0, 1 do
	t -6, 1, ?僕; b 7/4
	bg_note -4, 1; b 1/4
	t -2, 1, ?ら; b 3/2
	t 1, 1, ?の; b 1/2

	t 3, 1, ?こ; b 1/2
	t 5, 1, ?と; b 2
end
tp_chain -8, 0, 1 do
	t -7, -1, ?立; b 1/2
	t -5, -1, ?ち; b 1/2
	t -3, -1, ?止; b 1/2

	b 1
	t 0, -1, ?ま; b 1/2
	t 2, -1, ?ら; b 1
	bg_note 5, -1, ?せ; b 1
	bg_note 8, -1, ?る; b 1/2
end
b -2
tp_chain 0, 8, 1, preserve_beat: false do
	t -2, -4; b 1/2
	t 0, -2; b 1
	f -3, 3, :l; b 1/2
end
tp_chain 0, 8, 1 do
	t 2, -4; b 1
	t 0, 1; b 1/2
	grid 9/2
	f 3, 3, :r; b 1/2
end

b 1/2
t 0, 0; b 1/2
(1..5).each do |i|
	prog = i/6
	x, y = i+1, (i/2+1).floor*(-1)**i
	t x, y; t -x, -y; b 1/2
end
tp_chain 0, -8, 1 do
	t -1, 2; b 1/4
	t -3, 3; b 1/4
end

group preserve_beat: false do
	notes = align_lyrics 15 do
		center_lyrics 'うつむいて', [2, 3/2, 1/2, 1/2, 2], 1
		center_lyrics 'いたくないから', [1/2, 1/2, 3/2, 1/2, 1, 1, 9/2], -1
	end
	tsu = notes.find { _1[:text] == 'つ' }
	h(tsu[:x], tsu[:y], 1, tsu[:text]).beat = tsu.beat
	align_lyrics 29 do
		center_lyrics '誰 も', [1/2, 1/2, 11/2], 2
		center_lyrics '触  れない', [1/2]*5 + [5], 0
		center_lyrics 'ものを見つけたい', [1, 1, 3, 1/2, 3, 1/2, 1/2, 8], -2
	end
end

tp_chain 0, -8, 1, preserve_beat: false do
	f 4, 3, :r; b 4
	mark :piano
end
tp_drop -8, 0, 1 do
	t -5, 4; b 1
	f -6, 0, :l; b 1
	t -6, -4; b 1/2
	t -7, -2; b 1/2
	f -8, 0, :l; b 1/2
	t -7, 2; b 1/2
end

tp_drop 8, 0, 1 do
	t 3, -4; b 1
	f 3, -1, :r; b 1/2
	t 4, 1; b 1
	t 7, 3; b 1/2
	f 8, 1, :r; b 1
end
at :piano, update_mark: true do
	t -5, 3; b 1
	t -4, -2; b 1
	t -3, 2; b 1
	t -2, -3; b 1
end

tp_drop 8, 0, 1 do
	t 4, 4; b 1
	f 6, 0, :r; b 1
	t 6, -4; b 1/2
	t 7, -2; b 1/2
	f 8, 0, :r; b 1/2
	t 7, 2; b 1/2
end
at :piano, update_mark: true do
	t -7, -1; b 3/2
	t -5, 3; b 3/2
	t -3, -2; b 1/2
	h -5, -1, 3/2; b 1/2
end

at :piano do
	b 3/2
	t -4, 2; b 1
	6.times do |i|
		t (-1)**i, 2-i; b 1/4
	end
end
tp_drop 8, 0, 1 do
	b 1/2
	t 5, 0; b 1/2
	f 6, -2, :r; b 1
end
tp_drop 8, 0, 1 do
	t 4, 3
end
tp_drop -8, 0, 1 do
	f -6, 3, :l; b 1/2
end
5.times do |i|
	bg_note 6+(-1)**i, 1-i; b 1/4
end
b 1/4

tp_drop 8, 0, 1, preserve_beat: false do
	t 2, -4; b 1
	f 2, 0, :r; b 1
	t 2, 4; b 1/2
	t 3, 2; b 1/2
	f 4, 0, :r; b 1/2
	t 3, -2; b 1/2
end
tp_chain -8, 0, 1 do
	f -2, -4, :l; b 3/2
	t -3, 2; b 1/2
	t -3, 0; b 1/2
	t -3, -2; b 1
	t -6, 2; b 1/2
	mark :guitar
end

tp_drop 8, 0, 1 do
	b 1/2
	t 6, -1; b 1/2
	f 7, 1, :r; b 1/2
	t 6, 3; b 1
	t 4, 1; b 1/2
	f 5, -1, :r; b 1
end
at :guitar do
	t -6, 0; b 1/2
	t -6, -2; b 1
	t -5, 3; b 1
	t -4, -2; b 1/2
	f -4, 0, :l; b 1
end

tp_drop -8, 0, 1, preserve_beat: false do
	t -2, -4; b 1
	f -3, 0, :l; b 1
	t -3, 4; b 1/2
	t -4, 2; b 1/2
	f -5, 0, :l; b 1/2
	t -4, -2; b 1/2
end
tp_chain 8, 0, 1 do
	f 2, -4, :r; b 3/2
	t 1, -1; b 1/2
	t 3, 0; b 1/2
	t 5, -1; b 1/2
	t 7, 0; b 1/2
	t 6, 2; b 1/2
	mark :violin
end

at :violin do
	b 1/2
	t 2, 2; b 1/2
	f 4, 3, :r; b 1/2
	bg_note 6, 4; b 1/2
end
tp_drop -8, 0, 1 do
	b 1/2
	t -7, -1; b 1/2
	f -8, 1, :l; b 1/2
end
tp_chain 0, 8, 1 do
	notes = group do
		t -1, 0; b 1/2
		t -3, 1; b 1/2
		t -3, -1; b 1/2
		t -5, 0; b 1/2
		t -5, -2; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end

tp_chain -8, 0, 1, preserve_beat: false do
	h -7, -1, 5/2; b 7/2
	h -4, 2, 7/2; b 1/2
end
tp_drop 8, 0, 1 do
	t 6, -4; b 3/2
	t 7, -1; b 1/2
	f 8, 1, :r; b 1
	t 5, 2; b 1/2
	f 6, 0, :r; b 1/2

	t 5, -2; b 1/2
	t 4, -4; b 1
	t 7, -2; b 1/2
	f 8, 0, :r; b 1/2
	t 7, 2; b 1/2
	t 6, 4; b 1
end

tp_chain 8, 0, 1, preserve_beat: false do
	5.times do |i|
		(i < 4 ? 3 : 1).times do |j|
			t 3-i+2*j, 4-2*i-j; b 1/2
		end
	end
	bg_note 1, -3; b 1/2
	bg_note 3, -2; b 1/2
end
tp_drop -8, 0, 1 do
	t -6, -4; b 3/2
	t -7, -1; b 1/2
	f -8, 1, :l; b 1
	t -5, 4; b 1/2
	t -4, 2; b 1/2

	t -3, 0; b 1/2
	t -4, -2; b 1/2
	t -5, -4; b 1/2
	t -6, -2; b 1/2
	f -7, 0, :l; b 1/2
end
tp_chain 0, 8, 1 do
	6.times do |i|
		t (-1)**i, 2-i; b 1/4
	end
end

group preserve_beat: false do
	b -1
	align_lyrics 5 do
		center_lyrics '靴 紐 結 んで', [1/2, 1/2, 1] + [1/2]*6, -4
	end
end

diamond_grid 7/2
tp_drop 0, 8, 1 do
	f -2, -4, :l
	f 2, -4, :r; b 1
end
tp_chain 0, -8, 1 do
	0.upto 10 do |i|
		prog = i/10
		x0, y = -6+(prog-1/3)**2*9*3, 4-8*prog**1.5
		bg_note x0, y
		x = x0 + (1+prog)*(-1)**i
		if i.even?
			tp_drop(8, 0, 1) { f x, y, :r }
			d x, y
		else
			t x, y
		end
		b 1/4 unless i == 10
	end
end
tp_drop 0, 8, 1 do
	f 0, -4, :l; b 1/2
end

b 1/2
diamond_grid 1/2
notes = tp_drop 8, 8, 1 do
	@connected.add f 7, 1, :r; b 1/2
	@connected.add f 3, 3, :r; b 1
end
notes.concat attach_bg_notes notes, 1, 1
notes.concat attach_bg_notes notes, 1, -1
transform duplicate notes do
	rotate PI
end
group preserve_beat: false do
	align_lyrics 7 do
		big_bg_note -7, 1, 'チャ'; b 1
		big_bg_note -3, 3, 'ン'; b 1
		big_bg_note 3, 3, 'ス'; b 1
		big_bg_note 7, 1, 'は'; b 1
		big_bg_note -5, -2, 'く'; b 1
		big_bg_note 0, -3, 'る'; b 1
		big_bg_note 5, -2, 'よ'; b 1
	end
end
32.times do |i|
	prog = i/32
	x, y = 8-16*((2*prog-1)**3-prog+1), -4+8*4*(1-prog)*prog
	i.zero? ? t(x, y) : d(x, y); b 1/16
end

=begin
tp_chain 8, 0, 1 do
	4.times do |i|
		x, y = -4+i*2, 2-i
		i.zero? ? t(x, y) : d(x, y); b 1/6
	end
	t 4, -2; b 1/6
	t -2, -3; b 1/6
end
tp_chain 0, 8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		angle = 2*PI*prog
		x = 5-12*4*(1-prog)*prog+(2+prog**2)*cos(2*angle)
		y = -4+4*4*(1-prog)*prog + 2*prog**2 + (3-prog)*sin(3*angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -3, -4, :ul; b 1
end
tp_drop 8, 0, 1 do
	t 0, 4; b 1/2
	t 4, 2; b 1/2
	f 8, 4, :l; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		x = -4+12*4*prog*(1-prog)-4*prog
		y = 4*((1-prog*(1-prog))*cos(3*PI*prog)-sqrt(prog)*(1-prog)**3)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 8, -2; b 1
end
tp_drop -8, 0, 1 do
	f -6, 2, :r; b 1
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 4+4*4*(1-prog)*prog - 2*prog
		y = 4-8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
big_text 6, "ラッキー\nクローバー"
tp_drop -8, 0, 1 do
	b 1/2
	t -4, 0; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -2-4*4*(1-prog)*prog - 2*prog
		y = -4+8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 2, -4, :r; b 1/2
	t 5, 0; b 1/2
end

notes = tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		quo, rem = (2*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		r *= sin(2*theta) <=> 0
		x, y = 5*r*cos(theta), 5*r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 2
end
tp_drop -8, 0, 1 do
	t -4, 4; b 1
	f -5, -1, :l; b 1
end
64.times do |i|
	prog = i/64
	quo, rem = (4*prog).divmod 1
	theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
	r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
	bg_note 5*r*cos(theta), 5*r*sin(theta), 2
end
tp_drop 8, 0, 1 do
	t 6, 4; b 1/2
	t 8, 0; b 1/2
	f 6, -4, :r; b 1
end

group preserve_beat: false do
	4.times do |i|
		tp_chain 0, -8, 1 do
			(i < 3 ? 8 : 1).times do |j|
				prog = j/8
				x, y = 8-5*i-4*prog**2, 4-8*prog
				j.zero? ? t(x, y) : d(x, y); b 1/8
			end
		end
	end
end
tp_drop 8, 0, 1 do
	t 0, 0; b 1/2
	t 5, 0; b 1/2
	f 4, -4, :r; b 1
end
tp_drop -8, 0, 1 do
	t -1, -4; b 1/2
	t -6, 0; b 1/2
	f -6, -4, :r; b 1/2
end
tp_chain 0, 8, 1 do
	t 0, 2; b 1/4
	t 2, 1; b 1/4
end

tp_chain 0, 8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		angle = 3*PI*prog
		x = (4+2*4*prog*(1-prog))*cos(angle)
		y = 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	t -7, -2; b 1
end
tp_drop 8, 0, 1 do
	f 8, 0, :l; b 1
end
tp_drop -8, 0, 1 do
	t -8, 2; b 1/2
	t -7, -4; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -8*prog
		y = -2-2*4*prog*(1-prog)+2*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -4, 0, :r; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6-4*prog**2
		y = 4-8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	t -8, 0; b 1/2
	t -5, 4; b 1/2
	f 0, 4, :l; b 1/2
end
tp_chain 0, 8, 1 do
	t 0, 1; b 1/4
	t -2, 0; b 1/4
	tp_drop(-8, 0, 1) { t -4, -1 }
	t 3, -2; b 1/2
	t 7, 0; b 1/2
	tp_drop(8, 0, 1) { f 6, 4, :r }
	t -7, 3; b 1
end
=end

tp_chain 8, 0, 1 do
	4.times do |i|
		x, y = -2+i, 2-i
		i.zero? ? t(x, y) : d(x, y); b 1/6
	end
	t 2, -2; b 1/6
	t 0, -3; b 1/6
end
grid 4
tp_chain 0, 8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		quo, rem = (6*prog).divmod 1
		theta = case quo % 4
		when 0 then 3*PI/2 + rem*PI/4
		when 1 then 3*PI/4 - rem*PI/4
		when 2 then PI/2 - rem*PI/4
		when 3 then 5*PI/4 + rem*PI/4
		end
		r = 4*cos(2*theta)
		x, y = 6+r*cos(theta), -r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -2, -4, :ul; b 1
	t -2, 2; b 1/2
	t -4, 0; b 1/2
	f -6, -2, :l; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		angle = PI/2 - 2*PI*prog
		x = -6+2*prog + 2*cos(angle)
		y = 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 6, 4; b 1
	f 2, 0, :r; b 1
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6+2*4*(1-prog)*prog - 2*prog
		y = 4-8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
big_text 6, "ラッキー\nクローバー"
tp_drop -8, 0, 1 do
	b 1/2
	t -4, -2; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -6-2*4*(1-prog)*prog + 2*prog
		y = -4+8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 4, -4, :r; b 1/2
	t 2, -2; b 1/2
end

def clover_pattern duration = 2
	64.times do |i|
		prog = i/64
		quo, rem = (4*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		bg_note 5*r*cos(theta), 5*r*sin(theta), duration
	end
end
notes = tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		quo, rem = (2*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		r *= sin(2*theta) <=> 0
		x, y = 5*r*cos(theta), 5*r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 2
end
tp_drop -8, 0, 1 do
	t -4, 4; b 1
	f -4, 0, :l; b 1
end
clover_pattern
tp_drop 8, 0, 1 do
	t 4, 4; b 1/2
	t 6, 2; b 1/2
	f 8, 0, :r; b 1
end

notes = tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6-2*prog**2
		y = 4-8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	t 0, 0; b 1/2
	t -2, 2; b 1/2
end
transform duplicate notes do
	horizontal_flip
	translate 2, 0
	beat_translate 1
end
tp_drop 8, 0, 1 do
	f 4, -4, :r; b 1
end
transform duplicate notes do
	horizontal_flip
	translate 12, 0
	beat_translate 2
end
group preserve_beat: false do
	align_lyrics 14 do
		center_lyrics '明 日がもっと', [1]*6 + [5/2], 3, 2
		center_lyrics '曇 ってたって', [1/2, 1/2, 1, 1/2, 1, 1, 3], -3, 2
	end
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1/2
	t -4, -2; b 1/2
	t -6, 0
end
tp_chain 0, 8, 1 do
	f 8, -4, :r; b 1/2
end
tp_chain 0, -8, 1 do
	t -4, 2; b 1/4
	t -2, 3; b 1/4
end

tp_chain 0, -8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		angle = PI/2 + 3*PI*prog
		x = -6+4*prog + 2*cos(angle)
		y = 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 0, 4, :dr; b 1
	f 4, 0, :r; b 1
	t 2, -4; b 1/2
	t 4, -2; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6-4*prog**2
		y = 4*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -2, -4, :l; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -4-4*(1-(1-prog)**2)
		y = 2-4*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 2, 4; b 1/2
	t 0, 2; b 1/2
	f -2, 0, :r; b 1/2
end
tp_chain 0, 8, 1 do
	t 0, -4; b 1/4
	t 2, -3; b 1/4
	tp_drop(8, 0, 1) { f 4, -2, :r }
	t -4, -2; b 1/2
	tp_drop(-8, 0, 1) { t -6, 0 }
	t 6, 0; b 1/2
	tp_drop(-8, 0, 1) { f -8, 2, :l }
	t 8, 2; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	f -5, 4, :dl; b 1/2
	t -8, 1; b 1/2
	t -5, -2; b 1/2
	t -2, 1; b 1/2
	t 5, 4; b 1/2
	t 8, 1; b 1/2
	t 5, -2; b 1/2
	f 1, 1, :ur; b 1/2
end
tp_drop 8, 0, 1 do
	t 4, 4; b 1
	f 8, 0, :r; b 1
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1/2
	t -4, -2; b 1/2
	t -6, 0; b 1/2
	diamond_grid 3/2
	f -8, 2, :ul; b 1/2
end

tp_chain 0, -8, 1, preserve_beat: false do
	b 1
	t 8, 4; b 1/2
end
tp_drop -8, 0, 1 do
	b 1
	f -6, 4, :l; b 1/2
end
tp_chain 0, 8, 1 do
	notes = group do
		t 3, 3; b 1/2
		t 5, -1; b 1/2
		t 6, 2; b 1/2
		t 4, -2; b 1/2
		t 3, 1; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
group preserve_beat: false do
	b -2
	align_lyrics 7 do
		big_bg_note -7, 1, 'い'; b 1
		big_bg_note -3, 3, 'つ'; b 1
		big_bg_note 3, 3, 'か'; b 1
		big_bg_note 7, 1, 'は'; b 1
		big_bg_note -5, -2, 'く'; b 1
		big_bg_note 0, -3, 'る'; b 1
		big_bg_note 5, -2, 'よ'; b 1
	end
end

grid 5
tp_chain 0, -8, 1, preserve_beat: false do
	32.times do |i|
		prog = i/32
		quo, rem = (8*prog).divmod 1
		theta = case quo % 4
		when 0 then 3*PI/2 + rem*PI/4
		when 1 then 3*PI/4 - rem*PI/4
		when 2 then PI/2 - rem*PI/4
		when 3 then 5*PI/4 + rem*PI/4
		end
		r = 4*cos(2*theta)
		x, y = -6-r*cos(theta), r*sin(theta)
		i.zero? ? h(x, y, 2) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 2, 4, :dr; b 1/2
	t 4, 2; b 1/2
	f 6, 0, :r; b 1
	t 4, -4; b 1/2
	t 6, -2; b 1/2
	f 8, 0, :r; b 1
end

notes = group do
notes = tp_chain 0, 8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		prog = prog**2 / (prog**2 + (1-prog)**2)
		x = -6+8*((2*prog-1)**3+1-prog)-4*4*prog*(1-prog)
		y = -4+8*((2*prog-1)**3+1-prog)+2*4*prog*(1-prog)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
notes.concat(tp_drop 8, 0, 1 do
	bg_note 0, -4
	t -2, -4; b 1/2
	t 0, -2; b 1/2
	bg_note 4, 0
	f 2, 0, :r; b 1
end)
transform duplicate notes do
	rotate PI
	beat_translate 2
end
big_text 6, "ラッキー\nクローバー"
b 2

tp_chain 0, 8, 1, preserve_beat: false do
	12.times do |i|
		prog = i/12
		x = -8+2*(prog-1/3)**2*9
		y = -4+8*(prog+3/4*prog*(1-prog))
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t -2, -4; b 1
	f -2, 2, :r; b 1/2
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = 1-i/12
		x = 8-2*(prog-1/3)**2*9
		y = -4+8*(prog+3/4*prog*(1-prog))
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	b 1/2
	clover_pattern
	t -6, 4; b 1/2
	t -4, 2; b 1/2
	f -2, 0, :l; b 1
end
b -3/2
tp_chain 0, 8, 1 do
	t 8, 0; b 1/2
	t 5, -3; b 1/2
	t 2, 0; b 1/2
	mark :violin
end
end
transform(notes) { vertical_flip }

tp_drop 8, 0, 1 do
	t 8, 2; b 1/2
	t 6, 0; b 1/2
	t 4, -2; b 1/2
	f 2, -4, :r; b 1
	t 2, 4; b 1/2
	f 4, 2, :r; b 1/2
end
at :violin do
	f -8, 1, :ur; b 1/2
	t -5, -2; b 1/2
	t -2, 1; b 1/2
	f -5, 4, :dl; b 3/2
end
tp_chain 0, 8, 1 do
	t 3, -1; b 1/4
	t 5, -2; b 1/4
end

diamond_grid 16
group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒に', [1/2, 1/2, 1/2, 1], 4, 2 do
			translate -5, 0
		end
		transform center_lyrics '笑 おうよ', [1, 1, 0, 1, 5/2], 2, 2 do
			translate -4, 0
		end
	end
end
group preserve_beat: false do
	6.times do |i|
		tp_drop 0, 8, 1 do
			t 4+3*(-1)**i, -3; b 1/2
		end
		tp_drop 0, -8, 1 do
			t 4, 1+(i/2).floor; b 1/2
		end
	end
	tp_drop 0, 8, 1 do
		t 7, -3; b 1/2
		t 2, 0; b 1/2
		h 7, 3, 1/2; b 1
	end
end
tp_drop -8, 0, 1 do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		@connected.add h -1-i*2, 2-i*2, delta-1/2
		b delta
	end
end

group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒に', [1/2, 1/2, 1/2, 1], 4, 2 do
			translate 5, 0
		end
		transform center_lyrics '行こうよ', [1, 1, 1, 5/2], 2, 2 do
			translate 5, 0
		end
	end
end
group preserve_beat: false do
	6.times do |i|
		tp_drop 0, 8, 1 do
			t -5-3*(-1)**i, -2; b 1/2
		end
		tp_drop 0, -8, 1 do
			t -5, 2+(i/2).floor; b 1/2
		end
	end
end
tp_drop 8, 0, 1 do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		x, y = 1+i*2, 2-i*2
		@connected.add i==3 ? t(x, y) : h(x, y, delta-1/2)
		b delta
	end
end
b -2
notes = tp_chain 0, 8, 1 do
	notes = group do
		t 5, -1; b 1/2
		t 6, 2; b 1/2
		t 4, -2; b 1/2
		t 3, 1; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, 1
		beat_translate 1/4
	end
end
transform(notes) { rotate PI }

group preserve_beat: false do
	align_lyrics 14 do
		big_bg_note -6, 1, '君'; b 1/2
		big_bg_note 0, 2, ''; b 1/2
		big_bg_note 6, 1, 'と'; b 5
		big_bg_note -5, -3, 'ず'; b 2
		big_bg_note 5, -3, 'っと'; b 6
	end
end
7.times do |i|
	tp_drop 0, 8, 1 do
		t(-7*(-1)**i, -3)
	end
	tp_chain 0, 8, 1 do
		x, y = (2-(i/2).floor)*(-1)**i, -3
		i<4 ? t(x, y) : f(x, y, i%2*PI); b 1/2
		t -4*(-1)**i, 1+(i/2).floor; b 1/2
	end
end
tp_chain 0, 8, 1 do
	t 5, 1; b 1/4
	t -5, 0; b 1/4
	t 4, -1; b 1/4
	t -4, -2; b 1/4
end

tp_drop 0, 8, 1, preserve_beat: false do
	checkerboard 3
	h 0, 0, 5/2; b 4
	checkerboard 3
	h 0, 0, 5/2; b 4
end
14.times do |i|
	angle = 5*PI/4 - PI/4 * i
	r = 3+(i/8).floor
	r *= sqrt(2) if i.even?
	x, y = r*cos(angle), r*sin(angle)
	tp_drop 8*cos(angle), 8*sin(angle), 1 do
		i.even? ? f(x, y, angle-3*PI/4) : t(x, y); b 1/2
	end
end
group preserve_beat: false do
	b -3
	bg_note -2, -1; b 1
	bg_note 0, -3; b 1
	bg_note 2, -1; b 1
	align_lyrics 6 do
		big_bg_note -7, 3, '最'; b 1
		big_bg_note 0, 1, ''; b 3/2
		big_bg_note 7, 3, '後'; b 1
		big_bg_note -6, -3, 'ま'; b 1/2
		big_bg_note 6, -3, 'で'; b 3
	end
end
tp_chain 0, -8, 1 do
	t 7, -1; b 1/4
	t -7, 0; b 1/4
	t 8, 1; b 1/4
	t -8, -2; b 1/4
end

def corner_circle
	group do
		0.upto 8 do |i|
			prog = i/8
			angle = -PI/2 - PI/2*prog
			bg_note 8+5*cos(angle), 4+4*sin(angle)
		end
	end
end
diamond_grid 1/2
tp_drop -8, 0, 1 do
	corner_circle
	f 7, 3, :ul
end
tp_drop 8, 0, 1 do
	transform(corner_circle) { rotate PI }
	h -7, -3, 1; b 1
end
tp_drop 0, 8, 1 do
	f 0, 0, :u; b 1/2
end
diamond_grid 1/2
tp_drop 8, 0, 1 do
	transform(corner_circle) { horizontal_flip }
	f -8, 4, :ur
end
tp_drop -8, 0, 1 do
	transform(corner_circle) { vertical_flip }
	h 8, -4, 1; b 3/2
end
diamond_grid 3
32.times do |i|
	prog = i/32
	angle = 2*PI*prog
	bg_note 5*cos(angle), 4*sin(angle)
end
tp_drop 0, -8, 1 do
	h -3, 0, 1
	h 3, 0, 1; b 1
end

b 1/2
notes = group do
	tp_drop 8, -8, 1 do
		t 1, -1; b 1/2
	end
	tp_drop 8, 8, 1 do
		t 3, 2; b 1/2
	end
	tp_drop 8, -8, 1 do
		t 5, -3; b 1/2
	end
	tp_drop 8, 8, 1 do
		f 6, 4, :ur; b 3/4
	end
end
transform duplicate notes do
	rotate PI
end
tp_chain 0, -8, 1 do
	5.times do |i|
		t -(-1)**i, -3+i; b 1/4
	end
end

transform(interlude true) do
	horizontal_flip
end

def pattern second = false; group do
	tp_drop -8, 0, 1, preserve_beat: false do
		t -5, -3; b 1/2
		t -3, -1
	end
	tp_chain 8, 0, 1 do
		t 5, -3; b 1/2
		t 3, -1; b 1/4
		t -1, 0; b 1/4
		t 1, 1; b 1/2
	end
	tp_drop 8, 0, 1, preserve_beat: false do
		t 5, -3; b 1/2
		t 3, 0
	end
	tp_chain -8, 0, 1 do
		t -5, -3; b 1/2
		t -3, 0; b 1/4
		t 1, 1; b 1/4
		t -1, 2; b 1/2
	end
	tp_drop -8, 0, 1, preserve_beat: false do
		t -5, -3; b 1/2
		t -3, 1
	end
	tp_chain 8, 0, 1 do
		t 5, -3; b 1/2
		t 3, 1; b 1/4
		t -1, 2 unless second; b 1/4

		t 1, 3 unless second; b 1/2
	end
	tp_drop 8, 0, 1, preserve_beat: false do
		t 5, -3; b 1/2
		t 3, 2
	end
	tp_chain -8, 0, 1 do
		t -5, -3; b 1/2
		t -3, 2; b 1/2
	end
end; end
pattern
tp_chain 0, 8, 1 do
	t 8, 4; b 1/4
	t 6, 3; b 1/4
	t 8, 2; b 1/2
	t 8, 0; b 1/2
	t 8, -2; b 1
end

transform(pattern true) do
	vertical_flip
end
b 1/2
tp_chain 0, 8, 1 do
	t -8, 4; b 3/4
	t -8, 1; b 3/4
	t -8, -2; b 1/2

	f -8, -4, :l
end
hexagon 1/2
tp_chain -8, 0, 1 do
	t -5, 1, ?ど; b 1
	t -2, 1, ?ん; b 1/2
	t 0, 1, ?な; b 1
	t 3, 1, ?に; b 1
	t 6, 1, ?と; b 1/2
end

b 2
tp_chain -8, 0, 1 do
	t -6, -1, ?待; b 1
	bg_note -4, -1, ?っ
	t -2, -1, ?て; b 1/2
	t 0, -1, ?る
	bg_note 2, -1, ?ん; b 1/2
	tp_none preserve_beat: false do
		b -3/10
		[1/10, 1/10, 1/10, 1/5].each_with_index do |delta, i|
			d -(i+1)/2, -1+(i+1)/2; b delta
		end
	end

	b 1/2
	t 4, -1, ?だ; b 1/2
	h 6, -1, 7/2, ?ろ
	bg_note 8, -1, ?う; b 3
end

b 3/2
tp_chain -8, 0, 1 do
	t -3, 3, ?期; b 1/2
	t -1, 3, ?待; b 1/2
	t 1, 3; b 1/2
end
tp_chain 0, 8, 1 do
	t 1, 1; b 1/4
	t -1, 0; b 1/4
	bg_note 3, 3, ?は
	t 1, -1; b 1/4
	t -1, -2; b 1/4
end

group preserve_beat: false do
	b 3/2
	center_lyrics '不安 でも', [1/2, 1/2, 1, 3/2, 1/2], -2, 2
	center_lyrics 'あるけれど', [1, 1, 1, 1/2, 0], -4, 2
end
def pattern second = false; group do
	pentagon 3/2
	4.times do |i|
		angle = PI/2 - 2*PI/5*(1+i%2)
		notes = tp_drop 8, 0, 1 do
			x, y = 4*cos(angle), 4*sin(angle)
			second && i==3 ? f(x, y, :r) : t(x, y)
		end
		attach_bg_notes notes, 1, 0
		notes = tp_drop -8, 0, 1 do
			x, y = 4*cos(angle-4*PI/5), 4*sin(angle-4*PI/5)
			second && i==3 ? f(x, y, :l) : t(x, y); b 1/2
		end
		attach_bg_notes notes, -1, 0
	end
end; end
pattern; b 2

pattern true; b 3/2
tp_chain 0, 8, 1 do
	t -1, 2; b 1/4
	t 0, 1; b 1/4
	
	f -1, 0, :l; b 1/2
	t 1, -1; b 1/2
	t -1, -2; b 1/2
	t 1, -3; b 1/2
end
tp_chain 0, -8, 1 do
	h 0, 3, 1
end
8.times do |i|
	bg_note -3*(-1)**i, -3+i; b 1/4
end
b -1/3
tp_chain 0, 8, 1 do
	t 1, 0; b 1/6
	t -1, -1; b 1/6
end

turntable 5/2
notes = tp_drop -8, 0, 1 do
	t -2, -2; b 1/2
	t -3, 1; b 1
	t -6, 4; b 1
	f -7, 0, :l; b 1
end
notes.concat attach_bg_notes notes, -1, 0
transform duplicate notes do
	rotate PI
end
tp_chain 0, 8, 1 do
	t -1, -2; b 1/4
	t 1, -3; b 1/4
end

group preserve_beat: false do
	align_lyrics 12 do
		center_lyrics 'さっきより', [1, 1/2, 1, 1, 5/2], 4
		center_lyrics '少 しだけは', [1, 1/2, 3/2, 1, 3/2, 1], -4
	end
end
turntable 1/2
tp_drop -8, 0, 1 do
	f -3, -4, :ul
end
tp_drop 8, 0, 1 do
	f 3, -4, :ur; b 3/2
end
tp_drop -8, 0, 1 do
	f -6, -1, :l; b 1
end
tp_drop 8, 0, 1 do
	t 5, 1; b 1/2
	f 7, 2, :r; b 1
end

notes = tp_drop -8, 0, 1 do
	t -5, 4; b 1/2
	t -3, 2; b 1
end
transform duplicate notes do
	horizontal_flip
end
tp_drop 8, 0, 1 do
	bg_note 4, -2
	f 6, 1, :r; b 1
end
tp_drop -8, 0, 1 do
	t -5, -1; b 1/2
	bg_note 2, 1
	f -7, -2, :l; b 1
end

diamond_grid 7/2
tp_drop 8, 0, 1 do
	@connected.add h 2, -2, 1
end
tp_chain 0, -8, 1 do
	f -2, 2, :ul; b 1
	t 1, 3; b 1
	tp_drop(-8, 0, 1) { t -4, 3 }
	@connected.add f 4, 1, :ur; b 1/2
	tp_drop(-8, 0, 1) { t -5, 1 }
	t 7, 2; b 1/2
	tp_none { t -4, -1 }; b 1/2
	tp_drop(8, 0, 1) { h 5, -2, 1 }
	@connected.add f -5, -3, :ul; b 1/2
end

group preserve_beat: false do
	b 2
	align_lyrics 14+1/2 do
		center_lyrics '優 しい気持ちに', [1, 1, 1/2, 1/2, 1/2, 1, 1, 5/2], 4
		center_lyrics 'なれたかな', [1, 1/2, 1, 1/2, 1], -4
	end
end
b 1/2
tp_drop -8, 0, 1 do
	t -6, 1; b 1/2
	f -7, 3, :l; b 1/2
end
notes = tp_chain 0, 8, 1 do
	notes = group do
		t 1, 0; b 1/2
		t 3, 1; b 1/2
		t 3, -1; b 1/2
		t 5, 0; b 1/2
		t 5, -2; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
notes.each do |note|
	next unless note.type == :tap
	bg_note(note[:x], note[:y]+3).beat = note.beat
end

bg_note 7, 2; bg_note -7, 1
tp_chain -8, 0, 1, preserve_beat: false do
	h -6, -4, 1/2; b 1
	h -8, -1, 1/2; b 1
	h -7, 2, 1/2; b 1
	t -4, 3; b 1/2
	h 2, 4, 3/4; b 1/2

	b 3/4
	h 5, 2, 3/4; b 5/4
	h 7, -1, 1/2; b 1
	t 6, -4; b 1
end

tp_chain 0, -8, 1 do
	f 6, -4, :ur; b 1/2
	t 8, -3; b 1
end
tp_drop 8, 0, 1 do
	t 4, -1; b 1/2
	f 5, 1, :r; b 1/2
	f 6, 3, :r; b 1
end
tp_chain 0, 8, 1 do
	f -3, 1, :ul; b 1/2

	b 1/2
	3.times do |i|
		t -2-2*i, -2+i; b 1/2
		i==2 ? t(-4, 1) : t(-4-2*i, -3+i); b 1/2
	end
end
tp_chain 0, 8, 1 do
	t 0, 0; b 1/4
	t 2, -1; b 1/4
end

diamond_grid 8
tp_chain 0, -8, 1, preserve_beat: false do
	@connected.add h -1, -2, 1; b 3/2
	@connected.add h 2, 2, 1; b 2
	t -2, 2; b 1/2

	@connected.add t -3, 0; b 1/2
	t -2, -2; b 1/2
	t 0, -3; b 1/2
	@connected.add t 2, -2; b 1/2
	notes = group do
		t 3, 0; b 1/2
		t 5, -1; b 1/2
		t 5, 1; b 1/2
		t 7, 0; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end

tp_drop 8, 0, 1 do
	t 4, -2; b 1/2
	t 7, 0; b 1/2
	t 6, 3; b 1/2
end
tp_drop -8, 0, 1 do
	f -3, 3, :l; b 1
	t -5, -3; b 1/2
	f -6, 0, :ul; b 1
end

tp_drop 8, 0, 1 do
	f 3, 0, :r; b 3/2
end
tp_drop -8, 0, 1 do
	f -5, 3, :ul; b 5/2
end

tp_drop 0, -8, 1, preserve_beat: false do
	4.times do |i|
		4.times { t 8-2*i, 2-i; b 1 }
	end
end
tp_drop 0, 8, 1, preserve_beat: false do
	4.times do |i|
		([3/2, 1/2, 1/2] + (i==3 ? [] : [1, 1/2])).each do |delta|
			t -8+2*i, -2+i; b delta
		end
	end
end

group preserve_beat: false do
	align_lyrics 14+1/2 do
		center_lyrics '悔 しさに', [2, 3/2, 1/2, 1/2, 2], 4
		center_lyrics '負けないように', [1/2, 1/2, 3/2, 1/2, 1, 1, 1], -4
	end
end
bg_note -8, 4; b 3/2
bg_note -6, 3; b 3/2
bg_note -4, 2; b 1

bg_note -2, 1; b 1
bg_note 6, -3; b 1
bg_note 4, -2; b 1
bg_note 2, -1; b 1

bg_note 2, 4; b 3/2
bg_note 4, 3; b 3/2
bg_note 6, 2; b 1

bg_note 8, 1; b 3/2
bg_note -4, -3; b 1/4
bg_note -5, -2; b 1/4
bg_note -6, -1; b 1
tp_chain 8, 0, 1 do
	d 2, -1; b 1/4
	t -4, 3; b 1/4
	t 4, -2; b 1/4
	t -6, 2; b 1/4
	mark :violin
end

group preserve_beat: false do
	align_lyrics 14+1/2 do
		center_lyrics 'イメージを', [2, 3/2, 1/2, 1/2, 2], 4
		center_lyrics 'さけん でみてよ', [1/2, 1/2, 1/2, 1, 1/2, 1, 1, 1], -4
	end
end
tp_drop 0, 8, 1 do
	4.times { t 6, -3; b 1 }
end
at :violin, update_mark: true do
	h -7, 3, 1; b 2
	h -3, 2, 1; b 2
end

8.times do |i|
	tp_drop(0, 8*(-1)**i, 1) do
		i.even? ? t(-6, -3) : d(-6, -3); b 1/2
	end
end
at :violin, update_mark: true do
	h 3, 2, 1; b 2
	h 7, 3, 1; b 2
end

tp_drop 8, 0, 1 do
	f 4, -2, :r; b 1
	f 5, 1, :r; b 1
	t 5, -4; b 1/2
	t 4, -2; b 1/2
	t 3, 0; b 1/2
end
tp_drop -8, 0, 1 do
	f -3, -2, :ul; b 1/2
end
at :violin, update_mark: true do
	h -7, 4, 1; b 2
	h -2, 3, 1/2; b 3/2
	grid 9/2
	@connected.add h 2, 2, 1/2; b 1/2
end

@flipping = true
notes = group do
b 1/2
t 0, 0; b 1/2
tp_chain 0, -8, 1 do
	(1..5).each do |i|
		prog = i/6
		x, y = i+1, (i/2+1).floor*(-1)**i
		t x, y; tp_none { t -x, -y }; b 1/2
	end
end
tp_chain 0, -8, 1 do
	t -1, 2; b 1/4
	t -3, 3; b 1/4
end

group preserve_beat: false do
	align_lyrics 15 do
		center_lyrics '忘 れてた', [2, 3/2, 1/2, 1/2, 2], 1
		center_lyrics '大 切 なもの', [1/2, 1/2, 3/2, 1/2, 1, 1, 9/2], -1
	end
	align_lyrics 29 do
		center_lyrics '僕 と', [1/2, 1/2, 11/2], 2
		center_lyrics 'きっと僕 と', [1/2]*5 + [5], 0
		center_lyrics '思 い出せるから', [1, 1, 3, 1/2, 3, 1/2, 1/2, 8], -2
	end
end
group preserve_beat: false do
	bg_note 7, 2; b 2
	bg_note -4, -2; b 2
	bg_note 6, -4; b 1
	bg_note 8, -2; b 1
	bg_note -8, 2; b 1
	bg_note -6, 4; b 1
	bg_note 8, 4; b 3/2
	bg_note 2, 3; b 2
	bg_note -3, 4; b 3/2
	bg_note 3, -4; b 1/2
	bg_note -1, -3
end

tp_chain 0, -8, 1, preserve_beat: false do
	h 4, 3, 3; b 4
	mark :vocal
end
tp_drop -8, 0, 1 do
	t -5, 4; b 1
	f -6, 0, :l; b 1
	t -6, -4; b 1/2
	t -7, -2; b 1/2
	f -8, 0, :l; b 1/2
	t -7, 2; b 1/2
end

tp_drop 8, 0, 1 do
	t 3, -4; b 1
	f 3, -1, :r; b 1/2
	t 4, 1; b 1
	t 7, 3; b 1/2
	f 8, 1, :r; b 1
end
at :vocal, update_mark: true do
	h -5, 3, 2; b 4
end

tp_drop -8, 0, 1 do
	t -4, 4; b 1
	f -6, 0, :l; b 1
	t -6, -4; b 1/2
	t -7, -2; b 1/2
	t -8, 0; b 1/2
	f -7, 2, :ul; b 1/2
end
at :vocal, update_mark: true do
	h 5, -2, 1; b 2
	h 3, 1, 1/2; b 3/2
	h 7, 2, 3/2; b 1/2
end

tp_drop -8, 0, 1, preserve_beat: false do
	b 3/2
	t -4, 2; b 1
	tp_chain 0, 8, 1 do
		6.times do |i|
			t (-1)**i, 2-i; b 1/4
		end
	end
end
tp_drop -8, 0, 1 do
	b 1/2
	t -4, -2; b 1/2
	t -3, 0; b 1
end
tp_drop 8, 0, 1 do
	t 4, 3
end
tp_drop -8, 0, 1 do
	t -6, 3; b 2
end

tp_drop 8, 0, 1, preserve_beat: false do
	f 2, -4, :ur; b 1
	f 2, 0, :r; b 1
	t 4, 4; b 1
	f 4, 0, :r; b 1
end
tp_chain -8, 0, 1 do
	t -2, -4; b 1/2
	t -2, -2; b 1
	t -3, 2; b 1/2
	t -3, 0; b 3/2
	t -6, 2; b 1/2
	mark :guitar
end

tp_drop 8, 0, 1 do
	t 6, -4; b 1
	f 6, 0, :r; b 1
	t 4, 4; b 1
	f 4, 0, :r; b 1/2
end
tp_chain 0, 8, 1 do
	t -1, -2; b 1/4
	t 1, -3; b 1/4
end
at :guitar, update_mark: true do
	b 1/2
	t -6, -2; b 1
	t -5, 3; b 1
	t -4, -2; b 1/2
	f -4, 0, :l; b 1
end

tp_chain 8, 0, 1 do
	f -2, -4, :ul; b 3/2
	t -1, -1; b 1/2
	t -3, 0; b 1/2
	t -5, -1; b 1/2
	t -7, 0; b 1/2
	t -6, 2; b 1/2
	mark :violin
end
at :guitar, update_mark: true do
	t 2, -4; b 1/2
	t 2, -2; b 1
	t 3, 2; b 1/2
	t 3, 0; b 3/2
	t 6, 2; b 1/2
end

at :violin do
	b 1/2
	t 2, 2; b 1/2
	t 4, 3; b 1/2
	bg_note 6, 4; b 1/2
end
at :guitar do
	b 1/2
	t -7, -1; b 1/2
	t -8, 1; b 1/2
	bg_note -7, 3; b 1/2
	bg_note -5, 4; b 1/2
end
tp_chain 0, 8, 1 do
	b 3/2
	notes = group do
		t -1, 0; b 1/2
		t -3, 1; b 1/2
		t -3, -1; b 1/2
		t -5, 0; b 1/2
		t -5, -2; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end

tp_chain -8, 0, 1, preserve_beat: false do
	h -7, -1, 3; b 4
	h -4, 2, 3
end
tp_drop 8, 0, 1 do
	t 6, -4; b 3/2
	t 7, -1; b 1/2
	f 8, 1, :r; b 1
	t 5, 2; b 1/2
	f 6, 0, :r; b 1/2

	group preserve_beat: false do
		b 1
		bg_note -8, -4; b 1
		bg_note -8, 1; b 1
		bg_note -6, 4; b 1/2
		bg_note 8, -1; b 1/2
	end
	t 5, -2; b 1/2
	t 4, -4; b 1
	t 7, -2; b 1/2
	f 8, 0, :r; b 1/2
	t 7, 2; b 1/2
	t 6, 4; b 1
end

group preserve_beat: false do
	b 3/2
	bg_note 2, -4; b 3/2
	bg_note -8, -3; b 1
end
tp_chain 8, 0, 1, preserve_beat: false do
	5.times do |i|
		(i < 4 ? 3 : 1).times do |j|
			t 3-i+2*j, 4-2*i-j; b 1/2
		end
	end
	bg_note 1, -3; b 1/2
	bg_note 3, -2; b 1/2
end
tp_drop -8, 0, 1 do
	tp_drop(-8, 8, 1) { f -6, -4, :ul }; b 3/2
	t -7, -1; b 1/2
	f -8, 1, :l; b 1
	t -5, 4; b 1/2
	tp_drop(-8, 8, 1) { t -4, 2 }; b 1/2

	notes = group preserve_beat: false do
		4.times do |j|
			bg_note -2-j*2, 4-j; b 1/4
		end
		4.times do |j|
			bg_note -5-j, 4-j*2; b 1/4
		end
	end
	transform duplicate notes do
		horizontal_flip
		beat_translate 1/4
	end
	t -3, 0; b 1/2
	t -4, -2; b 1/2
	tp_drop(-8, 8, 1) { t -5, -4 }; b 1/2
	t -6, -2; b 1/2
	f -7, 0, :l; b 1/2
end
tp_chain 0, 8, 1 do
	5.times do |i|
		t (-1)**i, -2+i; b 1/4
	end
	b 1/4
end

group preserve_beat: false do
	b -1
	align_lyrics 5 do
		center_lyrics '握 り締めていて', [1/2, 1/2, 1] + [1/2]*6, -4
	end
end

diamond_grid 7/2
tp_drop 0, 8, 1 do
	h 0, 4, 3
end
notes = tp_chain 0, -8, 1 do
	f 0, -1, :u; b 1
	6.times do |i|
		x, y = (2+i)*(-1)**i, 2-i
		i==5 ? f(x, y, :ul) : t(x, y)
		b 1/2 unless i==5
	end
	tp_none do
		f 7, -3, :ur; b 1/2
	end
end
notes.each do |note|
	next unless %i[tap flick].include? note.type
	4.times do |i|
		angle = PI/2*i
		x, y = note[:x]+cos(angle), note[:y]+sin(angle)
		bg_note(x, y).beat = note.beat
	end
end

b 1/2
tp_drop 8, 8, 1, preserve_beat: false do
	t 6, 0; b 1/2
	t 2, 2; b 1/2
end
tp_chain -8, 0, 1 do
	t 0, -2; b 1/2
	t -3, 1; b 1/2
	t -6, 4
	5.times do |i|
		prog = i/5
		angle = -PI*(1-prog)
		x, y = 2+4*cos(angle), 4+6*sin(angle)
		t x, y
		tp_drop(8, 8, 1) { d x, y }; b 1/4
		prog = (i+1/2)/5
		angle = PI/2+prog*PI
		x, y = -6+4*prog+3*cos(angle), 4*sin(angle)
		t x, y; b 1/4
	end
end
group preserve_beat: false do
	b -2
	align_lyrics 7 do
		big_bg_note -7, 1, 'チャ'; b 1
		big_bg_note -3, 3, 'ン'; b 1
		big_bg_note 3, 3, 'ス'; b 1
		big_bg_note 7, 1, 'は'; b 1
		big_bg_note -5, -2, 'く'; b 1
		big_bg_note 0, -3, 'る'; b 1
		big_bg_note 5, -2, 'よ'; b 1
	end
end

grid 5
tp_chain 0, 8, 1, preserve_beat: false do
	32.times do |i|
		prog = i/32
		quo, rem = (8*prog).divmod 1
		theta = case quo % 4
		when 0 then 3*PI/2 + rem*PI/4
		when 1 then 3*PI/4 - rem*PI/4
		when 2 then PI/2 - rem*PI/4
		when 3 then 5*PI/4 + rem*PI/4
		end
		r = 4*cos(2*theta)
		x, y = 6+r*cos(theta), r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -2, -4, :ul; b 1
	f 0, 0, :l; b 1
	t -2, 4; b 1/2
	t -4, 2; b 1/2
	f -6, 0, :l; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		angle = PI/2 - 2*PI*prog
		x = -6+2*prog + 2*cos(angle)
		y = 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 6, 4; b 1
	f 2, 0, :r; b 1
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6+2*4*(1-prog)*prog - 2*prog
		y = 4-8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
big_text 6, "ラッキー\nクローバー"
tp_drop -8, 0, 1 do
	b 1/2
	t -4, -2; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -6-2*4*(1-prog)*prog + 2*prog
		y = -4+8*prog*(1-(1-prog)**2)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 4, -4, :r; b 1/2
	t 2, -2; b 1/2
end

def clover_pattern duration = 2
	64.times do |i|
		prog = i/64
		quo, rem = (4*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		bg_note 5*r*cos(theta), 5*r*sin(theta), duration
	end
end
notes = tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		quo, rem = (2*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		r *= sin(2*theta) <=> 0
		x, y = 5*r*cos(theta), 5*r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 2
end
tp_drop -8, 0, 1 do
	t -4, 4; b 1
	f -4, 0, :l; b 1
end
clover_pattern
tp_drop 8, 0, 1 do
	t 4, 4; b 1/2
	t 6, 2; b 1/2
	f 8, 0, :r; b 1
end

notes = tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6-2*prog**2
		y = 4-8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	t 0, 0; b 1/2
	t -2, 2; b 1/2
end
transform duplicate notes do
	horizontal_flip
	translate 2, 0
	beat_translate 1
end
tp_drop 8, 0, 1 do
	f 4, -4, :r; b 1
end
transform duplicate notes do
	horizontal_flip
	translate 12, 0
	beat_translate 2
end
group preserve_beat: false do
	align_lyrics 14 do
		center_lyrics '明日 がもっと', [1]*6 + [5/2], 3, 2
		center_lyrics '悲 しくたって', [1/2, 1/2, 1, 1/2, 1, 1, 3], -3, 2
	end
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1/2
	t -4, -2; b 1/2
	t -6, 0
end
tp_chain 0, 8, 1 do
	f 8, -4, :r; b 1/2
end
tp_chain 0, -8, 1 do
	t -4, 2; b 1/4
	t -2, 3; b 1/4
end

tp_chain 0, -8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		angle = PI/2 + 3*PI*prog
		x = -6+4*prog + 2*cos(angle)
		y = 4*sin(angle)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 0, 4, :dr; b 1
	f 4, 0, :r; b 1
	t 2, -4; b 1/2
	t 4, -2; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 6-4*prog**2
		y = 4*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	f -2, -4, :l; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -4-4*(1-(1-prog)**2)
		y = 2-4*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 2, 4; b 1/2
	t 0, 2; b 1/2
	f -2, 0, :r; b 1/2
end
tp_chain 0, 8, 1 do
	t 0, -4; b 1/4
	t 2, -3; b 1/4
	tp_drop(8, 0, 1) { f 4, -2, :r }
	t -4, -2; b 1/2
	tp_drop(-8, 0, 1) { t -6, 0 }
	t 6, 0; b 1/2
	tp_drop(-8, 0, 1) { f -8, 2, :l }
	t 8, 2; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	f -5, 4, :dl; b 1/2
	t -8, 1; b 1/2
	t -5, -2; b 1/2
	t -2, 1; b 1/2
	t 5, 4; b 1/2
	t 8, 1; b 1/2
	t 5, -2; b 1/2
	f 1, 1, :ur; b 1/2
end
tp_drop 8, 0, 1 do
	t 4, 4; b 1
	f 8, 0, :r; b 1
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1/2
	t -4, -2; b 1/2
	t -6, 0; b 1/2
	diamond_grid 3/2
	f -8, 2, :ul; b 1/2
end

tp_chain 0, -8, 1, preserve_beat: false do
	b 1
	t 8, 4; b 1/2
end
tp_drop -8, 0, 1 do
	b 1
	f -6, 4, :l; b 1/2
end
tp_chain 0, 8, 1 do
	notes = group do
		t 3, 3; b 1/2
		t 5, -1; b 1/2
		t 6, 2; b 1/2
		t 4, -2; b 1/2
		t 3, 1; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
group preserve_beat: false do
	b -2
	align_lyrics 7 do
		big_bg_note -7, 1, 'い'; b 1
		big_bg_note -3, 3, 'つ'; b 1
		big_bg_note 3, 3, 'か'; b 1
		big_bg_note 7, 1, 'は'; b 1
		big_bg_note -5, -2, 'く'; b 1
		big_bg_note 0, -3, 'る'; b 1
		big_bg_note 5, -2, 'よ'; b 1
	end
end

grid 5
tp_chain 0, -8, 1, preserve_beat: false do
	32.times do |i|
		prog = i/32
		quo, rem = (8*prog).divmod 1
		theta = case quo % 4
		when 0 then 3*PI/2 + rem*PI/4
		when 1 then 3*PI/4 - rem*PI/4
		when 2 then PI/2 - rem*PI/4
		when 3 then 5*PI/4 + rem*PI/4
		end
		r = 4*cos(2*theta)
		x, y = -6-r*cos(theta), r*sin(theta)
		i.zero? ? h(x, y, 2) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	f 2, 4, :dr; b 1/2
	t 4, 2; b 1/2
	f 6, 0, :r; b 1
	t 4, -4; b 1/2
	t 6, -2; b 1/2
	f 8, 0, :r; b 1
end

notes = group do
notes = tp_chain 0, 8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		prog = prog**2 / (prog**2 + (1-prog)**2)
		x = -6+8*((2*prog-1)**3+1-prog)-4*4*prog*(1-prog)
		y = -4+8*((2*prog-1)**3+1-prog)+2*4*prog*(1-prog)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
notes.concat(tp_drop 8, 0, 1 do
	bg_note 0, -4
	t -2, -4; b 1/2
	t 0, -2; b 1/2
	bg_note 4, 0
	f 2, 0, :r; b 1
end)
transform duplicate notes do
	rotate PI
	beat_translate 2
end
big_text 6, "ラッキー\nクローバー"
b 2

tp_chain 0, 8, 1, preserve_beat: false do
	12.times do |i|
		prog = i/12
		x = -8+2*(prog-1/3)**2*9
		y = -4+8*(prog+3/4*prog*(1-prog))
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t -2, -4; b 1
	f -2, 2, :r; b 1/2
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		prog = 1-i/12
		x = 8-2*(prog-1/3)**2*9
		y = -4+8*(prog+3/4*prog*(1-prog))
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	b 1/2
	clover_pattern
	t -6, 4; b 1/2
	t -4, 2; b 1/2
	f -2, 0, :l; b 1
end
b -3/2
tp_chain 0, 8, 1 do
	t 8, 0; b 1/2
	t 5, -3; b 1/2
	t 2, 0; b 1/2
	mark :violin
end
end
transform(notes) { vertical_flip }

tp_drop 8, 0, 1 do
	t 8, 2; b 1/2
	t 6, 0; b 1/2
	t 4, -2; b 1/2
	f 2, -4, :r; b 1
	t 2, 4; b 1/2
	f 4, 2, :r; b 1/2
end
at :violin do
	f -8, 1, :ur; b 1/2
	t -5, -2; b 1/2
	t -2, 1; b 1/2
	f -5, 4, :dl; b 3/2
end
tp_chain 0, 8, 1 do
	t 3, -1; b 1/4
	t 5, -2; b 1/4
end

diamond_grid 16
group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒な', [1/2, 1/2, 1/2, 1], 4, 2 do
			translate -5, 0
		end
		transform center_lyrics 'らいいな', [1, 1, 1, 5/2], 2, 2 do
			translate -5, 0
		end
	end
end
group preserve_beat: false do
	6.times do |i|
		tp_drop 0, 8, 1 do
			t 4+3*(-1)**i, -3; b 1/2
		end
		tp_drop 0, -8, 1 do
			t 4, 1+(i/2).floor; b 1/2
		end
	end
	tp_drop 0, 8, 1 do
		t 7, -3; b 1/2
		t 2, 0; b 1/2
		h 7, 3, 1/2; b 1
	end
end
tp_drop -8, 0, 1 do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		x, y = -1-i*2, 2-i*2
		@connected.add h x, y, delta-1/2
		b delta
	end
end

group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒に', [1/2, 1/2, 1/2, 1], 4, 2 do
			translate 5, 0
		end
		transform center_lyrics '行こうよ', [1, 1, 1, 5/2], 2, 2 do
			translate 5, 0
		end
	end
end
group preserve_beat: false do
	6.times do |i|
		tp_drop 0, 8, 1 do
			t -5-3*(-1)**i, -2; b 1/2
		end
		tp_drop 0, -8, 1 do
			t -5, 2+(i/2).floor; b 1/2
		end
	end
end
tp_drop 8, 0, 1 do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		x, y = 1+i*2, 2-i*2
		@connected.add i==3 ? t(x, y) : h(x, y, delta-1/2)
		b delta
	end
end
b -2
notes = tp_chain 0, 8, 1 do
	notes = group do
		t 5, -1; b 1/2
		t 6, 2; b 1/2
		t 4, -2; b 1/2
		t 3, 1; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, 1
		beat_translate 1/4
	end
end
transform(notes) { rotate PI }

group preserve_beat: false do
	align_lyrics 14 do
		big_bg_note -7, 1, '君'; b 1/2
		big_bg_note 0, 2, ''; b 1/2
		big_bg_note 7, 1, 'と'; b 5
		big_bg_note -5, -3, '夢'; b 3/2
		big_bg_note 0, -2, ''; b 3/2
		big_bg_note 5, -3, 'っと'; b 6
	end
end
7.times do |i|
	tp_drop 0, 8, 1 do
		t(-7*(-1)**i, -3)
	end
	tp_chain 0, 8, 1 do
		x, y = (2-(i/2).floor)*(-1)**i, -3
		i<4 ? t(x, y) : f(x, y, i%2*PI); b 1/2
		t -4*(-1)**i, 1+(i/2).floor; b 1/2
	end
end
tp_chain 0, 8, 1 do
	t 5, 1; b 1/4
	t -5, 0; b 1/4
	t 4, -1; b 1/4
	t -4, -2; b 1/4
end

tp_drop 0, 8, 1, preserve_beat: false do
	checkerboard 3
	h 0, 0, 5/2; b 4
	checkerboard 3
	h 0, 0, 5/2; b 4
end
14.times do |i|
	angle = 5*PI/4 - PI/4 * i
	r = 3+(i/8).floor
	r *= sqrt(2) if i.even?
	x, y = r*cos(angle), r*sin(angle)
	tp_drop 8*cos(angle), 8*sin(angle), 1 do
		i.even? ? f(x, y, angle-3*PI/4) : t(x, y); b 1/2
	end
end
group preserve_beat: false do
	align_lyrics 6+1/2 do
		big_bg_note -7, 3, '向'; b 1
		big_bg_note 0, 1, 'こ'; b 3/2
		big_bg_note 7, 3, 'う'; b 1
		big_bg_note -6, -3, 'ま'; b 1/2
		big_bg_note 6, -3, 'で'; b 3
	end
end
tp_chain 0, -8, 1 do
	t 7, -1; b 1/4
	t -7, 0; b 1/4
	t 8, 1; b 1/4
	t -8, -2; b 1/4
end

def corner_circle
	group do
		0.upto 8 do |i|
			prog = i/8
			angle = -PI/2 - PI/2*prog
			bg_note 8+5*cos(angle), 4+4*sin(angle)
		end
	end
end
diamond_grid 1/2
tp_drop -8, 0, 1 do
	corner_circle
	f 7, 3, :ul
end
tp_drop 8, 0, 1 do
	transform(corner_circle) { rotate PI }
	h -7, -3, 1; b 1
end
tp_drop 0, 8, 1 do
	f 0, 0, :u; b 1/2
end
diamond_grid 1/2
tp_drop 8, 0, 1 do
	transform(corner_circle) { horizontal_flip }
	f -8, 4, :ur
end
tp_drop -8, 0, 1 do
	transform(corner_circle) { vertical_flip }
	h 8, -4, 1; b 3/2
end
diamond_grid 3
32.times do |i|
	prog = i/32
	angle = 2*PI*prog
	bg_note 5*cos(angle), 4*sin(angle)
end
tp_drop 0, -8, 1 do
	h -3, 0, 1
	h 3, 0, 1; b 1
end

b 1/2
notes = group do
	tp_drop 8, -8, 1 do
		t 1, -1; b 1/2
	end
	tp_drop 8, 8, 1 do
		t 3, 2; b 1/2
	end
	tp_drop 8, -8, 1 do
		t 5, -3; b 1/2
	end
	tp_drop 8, 8, 1 do
		f 6, 4, :dr; b 1/16
	end
end
transform duplicate notes do
	rotate PI
end
(1...12).each do |i|
	prog = i/12
	x, y = 6+8*prog-12*prog**2, 4-8*prog
	d x, y; b 1/16
end
tp_chain 0, -8, 1 do
	5.times do |i|
		t -(-1)**i, -3+i; b 1/4
	end
end
end
transform(notes) { horizontal_flip }
@flipping = false

grid 16
tp_chain 8, 0, 1, preserve_beat: false do
	h 2, 2, 1; b 3/2
	t 5, 0; b 1
	t 7, 2; b 1
	@connected.add h -4, 0, 1; b 1/2
	mark :violin
end
tp_drop -8, 0, 1 do
	@connected.add f -2, 2, :ul; b 1
	tp_drop(-8, 8, 1) { t -6, 4 }; b 1/2
	t -8, 2; b 1/2
	tp_drop(-8, 8, 1) { t -6, 0 }; b 1/2
	t -8, -2; b 1/4
end
tp_drop 8, 0, 1 do
	t 8, 1; b 1/4
end
tp_drop -8, 0, 1 do
	t -6, -4; b 1/2
end
tp_drop 8, 0, 1 do
	f 4, -2, :ur; b 1/2
end

at :violin, update_mark: true do
	b 5/2
	t 1, -4; b 1/2
	t 1, -2; b 1/2
	t 1, 0; b 1/2
end
tp_drop 8, 0, 1 do
	b 1/2
	t 6, 2; b 1/2
	f 4, 4, :r; b 1/2
end
tp_chain 0, 8, 1 do
	t 0, 2; b 1/4
	t 2, 1; b 1/4
	t 0, 0; b 3/4
	t -1, -3; b 1/2
	t -1, -1; b 1/2
	t -1, 1; b 1/4
end

at :violin, update_mark: true do
	h -2, 2, 1; b 3/2
	t -5, 0; b 1
	t -7, 2; b 1
	h 4, 0, 1; b 1/2
end
tp_drop 8, 0, 1 do
	@connected.add f 2, 2, :ur; b 1
	tp_drop(8, 8, 1) { t 6, 4 }; b 1/2
	t 8, 2; b 1/2
	tp_drop(8, 8, 1) { t 6, 0 }; b 1/2
	t 8, -2; b 1/4
end
tp_drop -8, 0, 1 do
	t -8, 1; b 1/4
end
tp_drop 8, 0, 1 do
	t 6, -4; b 1/2
end
tp_drop -8, 0, 1 do
	@connected.add f -4, -2, :ul; b 1/2
end

at :violin, update_mark: true do
	b 5/2
	t -1, 4; b 1/2
	t -1, 2; b 1/2
	h -1, 0, 1; b 1/2
end
tp_drop -8, 0, 1 do
	b 1/2
	tp_drop(-8, 8, 1) { t -4, 3 }; b 1/2
	t -6, 1; b 1/2
end
tp_chain 0, -8, 1 do
	t 0, 0; b 1/4
	t -2, 1; b 1/4
	t 0, 2; b 3/4
	t 1, 3; b 1/2
	t 1, 1; b 1/2
	t 1, -1; b 1/4
end

tp_chain 0, 8, 1, preserve_beat: false do
	b 1
	t -4, 2; b 1/2
	t -6, 4; b 1/2
	t -8, 2; b 1/2
	t -6, 0; b 1/2
	t -4, -2; b 1/2
	h -2, 0, 1/2; b 1/2
	mark :guitar
end
tp_drop -8, 0, 1 do
	f 2, -2, :r; b 1
end
tp_drop 8, 0, 1 do
	f 6, 1, :r; b 1
	t 4, -4; b 1/2
	t 3, -2; b 1/2
	f 2, 0, :r; b 1
end

at :guitar, update_mark: true do
	b 1/2
	t 8, 0; b 1/2
	t 6, 2; b 1/2
	t 4, 4; b 1
	t 1, 1; b 1/4
	d 2, 0; b 1/4
	d 1, -1; b 1/2
	t 3, -3; b 1/2
end
tp_drop -8, 0, 1 do
	b 1/2
	t -5, 3; b 1/2
	f -6, 1, :l; b 1
	t -5, -4; b 1/2
	t -4, -2; b 1/2
	f -3, 0, :l; b 1
end

at :guitar, update_mark: true do
	h -1, -4, 1/2; b 1
	t -6, -4; b 1/2
	t -4, -2; b 1/2
	t -6, 0; b 1/2
	t -8, 2; b 1/2
	t -6, 4; b 1/2
	@connected.add h -4, 2, 1/2; b 1/2
end
tp_drop 8, 0, 1 do
	t 5, -1; b 1
	t 6, 2; b 1
	tp_drop(-8, -8, 1) do
		t 1, 3; b 1/2
		t 2, 1; b 1/2
		t 3, -1; b 1/2
	end
	f 4, -3, :ur; b 1/2
end

at :guitar, update_mark: true do
	b 1/2
	t 7, 0; b 1/2
	t 5, 2; b 1/2
	h 3, 4, 1/2; b 1
	t 2, 0; b 1/2
	@connected.add h 0, 2, 1/2; b 1
	bg_note 0, -4
end
tp_drop -8, 0, 1 do
	b 1/2
	tp_drop(8, -8, 1) { t -1, 0 }; b 1/2
	t -2, -2; b 1/2
	@connected.add f -3, -4, :ul; b 1
	t -5, 0; b 1/2
	f -6, 2, :ul; b 1
end

grid 7/2
notes = tp_drop 8, 0, 1 do
	@connected.add f 3, 3, :r; b 1/2
	@connected.add f 4, 1, :r; b 1/2
	@connected.add f 4, -1, :r; b 1/2
	@connected.add f 3, -3, :r; b 1
	@connected.add f 4, 4, :dr; b 1
end
transform duplicate notes do
	rotate PI
end
tp_drop -8, 0, 1 do
	@connected.add h -8, 0, 1
end
tp_chain 8, 0, 1 do
	h 8, 0, 5/2; b 1/2
	mark :violin
end

at :violin, update_mark: true do
	b 3
	h 5, 2, 1/2; b 1
end
tp_drop -8, 0, 1 do
	b 3/2
	t -2, 4; b 1/2
	t -3, 2; b 1/2
	t -4, 0; b 1/2
	t -5, -2; b 1
end

grid 7/2
notes = tp_drop -8, 0, 1 do
	@connected.add f -3, 3, :l; b 1/2
	@connected.add f -4, 1, :l; b 1/2
	@connected.add f -4, -1, :l; b 1/2
	@connected.add f -3, -3, :l; b 1
	@connected.add f -4, 4, :dl; b 1
end
transform duplicate notes do
	rotate PI
end
tp_drop 8, 0, 1 do
	@connected.add f 8, 0, :ul
end
tp_chain -8, 0, 1 do
	h -8, 0, 1; b 1/2
	mark :violin
end

at :violin, update_mark: true do
	b 1
	h -3, 2, 1/2; b 1
	h -2, -3, 1/2; b 1
	t -6, 0; b 1/2
	bg_note -8, -2; b 1/2
	bg_note -6, -4
end
tp_drop 8, 0, 1 do
	b 1/2
	t 2, 3; b 1/2
	f 3, 0, :r; b 1/2
end
group preserve_beat: false do
	b 1/6
	bg_note -2, 0; b 1/6
	bg_note -3, -1; b 1/6
	bg_note -4, -2; b 1/6
	bg_note -5, -3
end
tp_chain 0, 8, 1 do
	b 1/3
	t 2, -2; b 1/6
end
tp_drop 8, 0, 1 do
	t 3, -3; b 1/2
	t 5, -1; b 1/2
	t 3, 1; b 1/2
end
tp_chain 0, -8, 1 do
	t 1, 3; b 1/4
	t -1, 2; b 1/4
end

tp_chain 8, 0, 1, preserve_beat: false do
	h 4, 3, 5/2; b 7/2
	h -4, 3, 3/2; b 1/2
end
tp_drop -8, 0, 1 do
	@connected.add f -3, 1, :ul; b 3/2
	t -5, -4; b 1/2
	tp_drop(8, -8, 1) do
		t -7, -3; b 1/2
		t -6, -1; b 1/2
		t -5, 1; b 1/2
	end
end
tp_drop 8, 0, 1 do
	@connected.add f 3, -2, :ur; b 1/2
end

tp_drop 8, 0, 1 do
	b 1/2
	tp_drop(-8, -8, 1) { t 4, 4 }; b 1/2
	t 5, 1; b 1/2
end
tp_chain 0, 8, 1 do
	t 2, 0; b 1/4
	t 0, -1; b 1/4
end
tp_drop 8, 0, 1 do
	t 2, -2; b 1/2
end
tp_drop -8, 0, 1 do
	t -2, -4; b 1/2
	t -5, -3; b 1
end

notes = group do
	diamond_grid 7/2
	notes = tp_drop 8, 8, 1 do
		@connected.add f 2, -2, :r; b 1/2
		@connected.add f 2, 2, :r; b 1
		@connected.add f 4, -3, :r; b 1/2
		@connected.add f 4, 3, :r; b 1
		@connected.add f 6, -4, :r; b 1/2
		@connected.add f 6, 4, :r; b 1/2
	end
	notes.concat attach_bg_notes notes, 1, 0
	transform duplicate notes do
		rotate PI
	end
end

tp_chain 0, 8, 1 do
	b 1/2
	t 1, 2; b 1/2
	t 3, 1; b 3/4
	t -1, 0; b 1/4
	t -2, -1; b 3/4
	t 1, -2; b 1/4
	f 2, -3, :r; b 1
end

transform duplicate_connected notes do
	vertical_flip
	beat_translate 8
end
b 4

tp_chain 0, 8, 1 do
	b 1/2
	t -1, 3; b 1
	t 2, 2; b 1/2
	tp_drop(-8, 0, 1) { f -4, 1, :ul }; b 1/2
	t 3, -1; b 1/2
	t -2, -2
end
tp_chain 0, -8, 1 do
	t 1, -2; b 1/4
	t -1, -1; b 1/4
	t 1, 0; b 1/4
	t -1, 1; b 1/4
end

group preserve_beat: false do
	align_lyrics 4 do
		center_lyrics '手の中 に', [1, 1/2, 1, 1/2, 1], -4
	end
end
grid 8
tp_chain 0, 8, 1, preserve_beat: false do
	h -2, 2, 1; b 3/2
	h 6, -3, 3/2; b 2
	t -7, -2; b 1/2
end
tp_drop 8, 0, 1 do
	@connected.add f 3, 3, :ur; b 1/2
	t 4, 1; b 1/2
	t 5, -1; b 1/2
end
tp_drop -8, 0, 1 do
	@connected.add f -3, -2, :ul; b 1
	t -5, 2; b 1/2
	t -6, 0; b 1/2
end
tp_drop 8, 0, 1 do
	@connected.add f 5, 3, :ur; b 1/2
end

tp_chain 0, 8, 1 do
	b 1/2
	tp_drop(8, 0, 1) { t 4, 0 }
	t -4, 1; b 1/2
	tp_drop(-8, -8, 1) { t 5, -2 }
	t -3, -1; b 1/2
	t -1, 0; b 1/2
	tp_none preserve_beat: false do
		32.times do |i|
			prog = i/32
			x, y = -8+16*((2*prog-1)**3-prog+1), -4+8*4*(1-prog)*prog
			i.zero? ? f(x, y, :ur) : d(x, y); b 1/16
		end
	end
	t 1, -1; b 1/2
	t 3, 0; b 1/2
	t 5, -1; b 1/2
	t 7, -2; b 1/2
end

group preserve_beat: false do
	b -2
	align_lyrics 7 do
		big_bg_note -7, 1, 'チャ'; b 1
		big_bg_note -3, 3, 'ン'; b 1
		big_bg_note 3, 3, 'ス'; b 1
		big_bg_note 7, 1, 'は'; b 1
		big_bg_note -5, -2, 'く'; b 1
		big_bg_note 0, -3, 'る'; b 1
		big_bg_note 5, -2, 'よ'; b 1
	end
end
tp_drop 8, 0, 1 do
	t 8, -4; b 2/3
end
tp_chain 0, 8, 1 do
	t -1, -2; b 1/6
	t 1, -3; b 1/6
end
grid 4
tp_chain 0, 8, 1, preserve_beat: false do
	24.times do |i|
		prog = i/24
		x = 5-(2+prog)*cos(3*PI*prog)
		y = -4*cos(5*PI*prog)
		i.zero? ? h(x, y, 2) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	@connected.add f -3, -4, :ul; b 1
	t -5, 0; b 1
	t -2, 3; b 1
end

tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		x = -3+5*cos(3*PI*prog)
		y = 4-8*4*prog*(1-prog)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	t 8, 4; b 1
	f 7, 0, :r; b 1
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 8-6*4*prog*(1-prog)
		y = -4+8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
big_text 6, "ラッキー\nクローバー"
tp_drop -8, 0, 1 do
	t -8, 4; b 1
end
tp_chain 0, 8, 1 do
	t -5, -1
end
tp_drop 8, 0, 1 do
	@connected.add f 8, 4, :r; b 1/2
end
tp_chain 0, -8, 1 do
	t 1, -3; b 1/4
	t 3, -2; b 1/4
end

notes = tp_chain 0, -8, 1, preserve_beat: false do
	16.times do |i|
		prog = i/16
		quo, rem = (2*prog).divmod 1
		theta = PI/2 * (quo + rem**3/(rem**3+(1-rem)**3))
		r = sin(2*theta).abs**(1/3) + (cos(2*theta).abs-1)/4
		r *= sin(2*theta) <=> 0
		x, y = -5*r*cos(theta), 5*r*sin(theta)
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 2
end
tp_drop 8, 0, 1 do
	@connected.add f 5, -1, :ur; b 1
	f 8, 3, :r; b 1
end
clover_pattern
tp_drop -8, 0, 1 do
	t -5, -1; b 1
	f -8, 3, :l; b 1
end

tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = -6+4*4*prog*(1-prog)-2*prog
		y = -4+8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	@connected.add f 0, 0, :ur; b 1
end
tp_chain 0, -8, 1 do
	t 6, 4
end
tp_drop -8, 0, 1 do
	t -8, 4; b 1/2
end
tp_chain 0, 8, 1, preserve_beat: false do
	notes = group do
		t -2, 2; b 1/2
		t -5, 1; b 1/2
		t -3, 0; b 1/2
		t -6, 2; b 1/2
		t -4, -2; b 1/2
	end
	transform duplicate notes do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
b 1/2
bg_note -8, 1; b 1
bg_note 8, -1; b 1

group preserve_beat: false do
	b -2
	align_lyrics 14 do
		center_lyrics '明 日にちょっと', [1]*6 + [0, 5/2], 3, 2
		center_lyrics 'ちょっとだけでも', [1/2, 1/2, 1, 0, 1/2, 1, 1, 3], -3, 2
	end
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		prog = i/8
		x = 3+4*4*prog*(1-prog)+prog
		y = -4+8*prog
		i.zero? ? t(x, y) : d(x, y); b 1/8
	end
end
tp_drop -8, 0, 1 do
	@connected.add f -6, -4, :ul; b 1
end
tp_drop -8, 0, 1 do
	f -6, 2, :l; b 1/2
	tp_drop(8, 8, 1) { t 4, 1 }
	t -2,  0; b 1/2
	t -5, -2; b 1/2
	tp_drop(8, 8, 1) { t 4, -1 }
	t -1, -4; b 1/2
end
tp_drop 8, 0, 1 do
	f 6, 2, :r; b 1/2
	tp_drop(-8, 8, 1) { t -4, 1 }
	t 2,  0; b 1/2

	t 5, -2; b 1/2
	tp_drop(-8, 8, 1) { t -4, -1 }
	t 1, -4; b 1/2
end
tp_drop -8, 0, 1 do
	f -6, 2, :l; b 1/2
end
tp_drop 8, 8, 1 do
	t 4, 1
end
tp_chain 0, -8, 1 do
	t -3, 2; b 1/4
	t -1, 3; b 1/4
	t 1, 4; b 1/2
	tp_drop(-8, 0, 1) { t 4, -1 }
	t 0, 0; b 1/2
	tp_chain(8, 0, 1) { @connected.add f 6, 2, :r }
	t -3, -3; b 1/2
end
tp_drop -8, 8, 1 do
	t -4, 1; b 1/2
end

tp_chain 0, 8, 1 do
	tp_drop -8, 0, 1 do
		@connected.add f -7, 3, :ul
	end
	t 2, 2; b 1/2
	t -1, 0; b 1/2
	tp_drop(8, 0, 1) { @connected.add f 5, 1, :r }
	t -5, -1; b 1/2
	t -2, -3; b 1/2
	tp_drop(-8, 0, 1) { @connected.add f -7, -4, :l }
	t 4, -2; b 1/2
	t 1, 0; b 1/4
	tp_chain(0, 8, 1) { t -1, 1 }; b 1/4
	tp_drop(-8, 0, 1) { t -3, 2 }
	t 5, 3; b 1/2
	diamond_grid 3/2
	tp_drop(8, 0, 1) { @connected.add f 7, 0, :ur }
	t -6, 4; b 1/2
end

b 1/2
tp_drop -8, 8, 1 do
	t -1, -1; b 1/2
end
tp_chain 0, 8, 1 do
	notes = group do
		t 3, 3; b 1/2
		t 6, 0; b 1/2
		t 5, 3; b 1/2
		t 4, -1; b 1/2
		t 7, 2; b 1/2
		t 2, -2; b 1/2
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end
group preserve_beat: false do
	b -3
	6.times do |i|
		bg_note -8*(-1)**i, 4-4*(i/2).floor; b 1/2
	end
end

group preserve_beat: false do
	b -2
	align_lyrics 7 do
		big_bg_note -7, 1, '願'; b 1
		big_bg_note -3, 3, ''; b 1
		big_bg_note 3, 3, 'い'; b 1
		big_bg_note 7, 1, 'を'; b 1
		big_bg_note -5, -2, 'こ'; b 1
		big_bg_note 0, -3, 'め'; b 1
		big_bg_note 5, -2, 'て'; b 1
	end
end
grid 5
tp_chain 0, 8, 1, preserve_beat: false do
	32.times do |i|
		prog = i/32
		x = -4+(3+prog)*cos(4*PI*prog)
		y = -4*cos(7*PI*prog)
		i.zero? ? h(x, y, 2) : d(x, y); b 1/8
	end
end
tp_drop 8, 0, 1 do
	@connected.add f 3, -4, :ur; b 1
	f 5, 0, :r; b 1
	t 7, 4; b 1
	f 3, 1, :r; b 1
end

notes = tp_drop -8, 8, 1 do
	4.times do |i|
		3.times do |j|
			x, y = 2*i+j%2, 4-i-2*j
			j.zero? ? t(x, y) : d(x, y); b 1/3
		end
	end
end
transform duplicate notes do
	horizontal_flip
	translate -1, -1
	beat_translate 1/6
end
group preserve_beat: false do
	b -2
	big_text 6, "ラッキー\nクローバー"
end

tp_drop -8, 8, 1 do
	t 8, 0; b 1/2
end
tp_chain 8, 8, 1 do
	f 0, 0, :d
end
tp_chain -8, 8, 1 do
	d 0, 0; b 3/2
end
clover_pattern
tp_chain 0, 8, 1 do
	tp_drop(8, 0, 1) { @connected.add f 4, -2, :ur }
	t -4, -3; b 1/2
	t 0, -1; b 1/2
	tp_drop(-8, 0, 1) { @connected.add f -5, 0, :l }
	t 3, 2; b 1/2
	tp_drop(8, 0, 1) { @connected.add f 7, 3, :ur }
	t -6, 4; b 1/2

	b 1/2
	tp_drop(8, 0, 1) { t 4, -2 }
	t -2, 0; b 1/2
	tp_drop(-8, 0, 1) { @connected.add f -3, -3, :l }
	t 3, 1; b 1/2
	h 0, 4, 1; b 1/4
end
tp_chain 0, -8, 1 do
	t -2, 3; b 1/4
	t -4, 2; b 1/2
end
tp_drop -8, 0, 1 do
	f -7, 4, :ul; b 1/2
end
tp_chain 0, 8, 1 do
	t -1, 0; b 1/4
	t -3, -1; b 1/4
	t -1, -2; b 1/4
	t -3, -3; b 1/4
end

diamond_grid 16
group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒に', [1/2, 1/2, 1/2, 1], 2, 2 do
			translate -5, 0
		end
		transform center_lyrics '笑 おうよ', [1, 1, 0, 1, 5/2], -2, 2 do
			translate -4, 0
		end
	end
end
group preserve_beat: false do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		bg_note 8, 3-i*2
		b delta
	end
end
group preserve_beat: false do
	8.times do |i|
		tp_drop -8, 8*(-1)**i, 1 do
			angle = PI/2*(-1)**i
			angle *= 3/2 if [0, 4].include? i
			@connected.add f -5, -4*(-1)**i, angle; b 1
		end
	end
end
6.times do |i|
	tp_drop 8, 0, 1 do
		t 0, -4*(-1)**i; b 1/2
	end
	tp_drop -8, 0, 1 do
		t 4+(i/2).floor, 0; b 1/2
	end
end
tp_chain 8, 0, 1 do
	t 0, -4; b 1/2
	t 3, 0; b 1/2
	h 6, 4, 1/2; b 1
end

group preserve_beat: false do
	align_lyrics 6 do
		transform center_lyrics '一 緒に', [1/2, 1/2, 1/2, 1], 2, 2 do
			translate 5, 0
		end
		transform center_lyrics '行こうよ', [1, 1, 1, 5/2], -2, 2 do
			translate 5, 0
		end
	end
end
group preserve_beat: false do
	[3/2, 2, 2, 5/2].each_with_index do |delta, i|
		bg_note -8, 3-i*2
		b delta
	end
end
group preserve_beat: false do
	6.times do |i|
		tp_drop -8, 0, 1 do
			t 0, -4*(-1)**i; b 1/2
		end
		tp_drop 8, 0, 1 do
			t -4-(i/2).floor, 0; b 1/2
		end
	end
	tp_chain -8, 0, 1 do
		t 0, -4; b 1/2
		t -2, 0; b 1/2
		t -4, 4; b 1/2
		t -6, 0; b 1/2
	end
end
tp_drop(8, 8, 1) { @connected.add f 5, -4, :ur }; b 3/2
tp_drop(8, -8, 1) { @connected.add f 5, 0, :d }; b 1
tp_drop(8, 8, 1) { @connected.add f 5, 0, :ur }; b 1
tp_drop(8, -8, 1) { t 5, 0 }; b 1/2
tp_drop(8, 8, 1) { t 5, -4 }; b 1/2
tp_drop(8, 8, 1) { t 5, 0 }; b 1/2
tp_drop(8, -8, 1) { t 5, 4 }; b 1/2
tp_drop(8, -8, 1) { @connected.add f 5, 0, :dr }; b 1
tp_chain(8, 8, 1) do
	@connected.add f 5, 0, :ul; b 1/6
	d 4, 1; b 1/6
	d 3, 2; b 1/6
	d 2, 3; b 1/3
	d 0, 1; b 1/3
	d -2, -1; b 1/3
end

group preserve_beat: false do
	align_lyrics 14 do
		big_bg_note -6, 1, '君'; b 1/2
		big_bg_note 0, 2, ''; b 1/2
		big_bg_note 6, 1, 'と'; b 5
		big_bg_note -5, -3, 'ず'; b 2
		big_bg_note 5, -3, 'っと'; b 6
	end
end
4.times do |i|
	tp_drop 0, 8, 1 do
		f -4*(-1)**i, -3, PI*(i%2)
		@connected.add t -8*(-1)**i, -4; b 1/2
	end
	tp_drop 0, -8, 1 do
		t -5*(-1)**i, 2+(i/2).floor; b 1/2
	end
end

3.times do |i|
	tp_drop 0, 8, 1 do
		f -8*(-1)**i, -1, PI*(i%2)
		@connected.add t -3*(-1)**i, -2; b 1/2
	end
	tp_drop 0, -8, 1 do
		t 0, 4; b 1/2
	end if i != 2
end
tp_chain 0, 8, 1 do
	6.times do |i|
		t (-1)**i, 2-i; b 1/4
	end
end

checkerboard 3
tp_chain 0, 8, 1 do
	h 3, 0, 5/2
end
tp_drop -8, 0, 1 do
	f -3, -4, :ul; b 3/2
	t 4, 2; b 1/2
	f 7, 0, :l; b 1/2
	f 4, -2, :l; b 1/2
	t 1, -3; b 1/2
	t -2, -2; b 1/2
end

checkerboard 3
tp_chain 0, 8, 1 do
	h -3, 0, 5/2
end
tp_drop 8, 0, 1 do
	t -1, 3; b 1/2
	t -4, 2; b 1/2
	t -7, 0; b 1/2
	t -4, -2; b 1/2
	f -1, -3, :r; b 1/2
	t 3, -2; b 1/2
end
group preserve_beat: false do
	b -3
	bg_note -1, -2; b 1
	bg_note 0, 0; b 1
	bg_note 1, -2; b 1
	align_lyrics 5 do
		big_bg_note -7, 3, '最'; b 1
		big_bg_note 0, 1, ''; b 3/2
		big_bg_note 7, 3, '後'; b 1
		big_bg_note -6, -3, 'ま'; b 1/2
		big_bg_note 6, -3, 'で'; b 3
	end
end
tp_chain 0, -8, 1 do
	t 7, -1; b 1/4
	t -7, 0; b 1/4
	t 8, 1; b 1/4
	t -8, -2; b 1/4
end

diamond_grid 1/2
tp_drop -8, 0, 1 do
	corner_circle
	f 7, 3, :ul
end
tp_drop 8, 0, 1 do
	transform(corner_circle) { rotate PI }
	h -7, -3, 1; b 1
end
tp_drop 0, 8, 1 do
	f 0, 0, :u; b 1/2
end
diamond_grid 1/2
tp_drop 8, 0, 1 do
	transform(corner_circle) { horizontal_flip }
	f -8, 4, :ur
end
tp_drop -8, 0, 1 do
	transform(corner_circle) { vertical_flip }
	h 8, -4, 1; b 3/2
end
diamond_grid 3
32.times do |i|
	prog = i/32
	angle = 2*PI*prog
	bg_note 5*cos(angle), 4*sin(angle)
end
tp_drop 0, -8, 1 do
	h -3, 0, 1
	h 3, 0, 1; b 1
end

b 1/2
notes = group do
	tp_drop 8, -8, 1 do
		t 1, -1; b 1/2
	end
	tp_drop 8, 8, 1 do
		t 3, 2; b 1/2
	end
	tp_drop 8, -8, 1 do
		t 5, -3; b 1/2
	end
	tp_drop 8, 8, 1 do
		f 6, 4, :dr; b 1/16
	end
end
transform duplicate notes do
	rotate PI
end
(1...12).each do |i|
	prog = i/12
	x, y = 6+8*prog-12*prog**2, 4-8*prog
	d x, y; b 1/16
end
tp_chain 0, -8, 1 do
	5.times do |i|
		t -(-1)**i, -3+i; b 1/4
	end
end

group preserve_beat: false do
	b -2
	align_lyrics 8+1/2 do
		big_bg_note -7, 2, '駆'; b 2
		big_bg_note -4, -1, 'け'; b 1/2
		big_bg_note 0, -3, '抜'; b 1/2
		big_bg_note 4, -1, 'け'; b 1/2
		big_bg_note 7, 2, 'よう'
	end
end
def interlude_pattern; group do
	tp_drop -8, 0, 1, preserve_beat: false do
		grid 7
		8.times do |i|
			i==7 ? bg_note(-4, 1) : t(-4, 1)
			4.times do |j|
				bg_note -3-2*(-1)**i-j, 3-j*2; b 1/4
			end
		end
	end
	tp_chain 0, 8, 1 do
		notes = group do
			t 3, 2; b 1/2
			t 5, 0; b 1/2
			t 8, 1; b 1/2
			t 6, -1; b 1/2
		end
		transform duplicate notes, new_tip_points: false do
			vertical_flip
			beat_translate 2
		end
		b 2

		b 1/2
		t 1, 1; b 1
		t 3, -2; b 1
		bg_note 4, 2; b 1/2
		bg_note 2, 3; b 1
	end
	b -2
	tp_chain 0, 8, 1 do
		t 2, 0; b 1/2
		6.times do |i|
			t -(-1)**i, 3-i; b 1/4
		end
	end
end; end
transform(interlude_pattern) { horizontal_flip }

checkerboard 1/2
notes = tp_chain 0, -8, 1 do
	t 2, -3; b 1/2
	t 4, -1; b 1/2
	t 2, 1; b 1/2
	f 4, 3, :r
end
checkerboard 1/2; b 3/4
tp_chain 0, -8, 1 do
	4.times do |i|
		t -(-1)**i, -4+i; b 1/4
	end
end
b 1/4
notes.concat(tp_chain 0, -8, 1 do
	f 5, 1, :r
end)
checkerboard 1/2; b 1/2
notes.concat attach_bg_notes notes, 1, 1
transform duplicate notes do
	horizontal_flip
end

tp_chain 8, 0, 1, preserve_beat: false do
	b 1/2
	t -4, 3; b 1/2
	t -5, -1; b 1/2
	tp_chain 0, -8, 1, preserve_beat: false do
		t 2, -3; b 1/4
		t 0, -2; b 1/4
		t -2, -1
	end
	t -2, -3; b 1
	t 5, -1; b 1/2
	t 6, 2; b 1
end
tp_chain 0, 8, 1 do
	b 1
	f 4, 3, :ur; b 2
	f -6, 3, :l; b 1/2
end
tp_chain 0, -8, 1 do
	t -1, 0; b 1/4
	t 1, 1; b 1/4
end

interlude_pattern

checkerboard 1/2
notes = tp_chain 0, -8, 1 do
	t -4, 3; b 1/2
	t -2, 1; b 1/2
	t -4, -1; b 1/2
	f -6, -3, :l
end
checkerboard 1/2; b 3/4
tp_chain 0, -8, 1 do
	4.times do |i|
		t (-1)**i, 1-i; b 1/4
	end
end
b 1/4
notes.concat(tp_chain 0, -8, 1 do
	f -6, 2, :l
end)
checkerboard 1/2; b 1/2
notes.concat attach_bg_notes notes, -1, 1
transform duplicate notes do
	rotate PI
end

tp_chain 0, 8, 1 do
	b 1/2
	t 0, 0; b 1/2
	notes = group do
		3.times do |i|
			2.times do |j|
				t -2-2*i, 3-i-2*j; b 1/2
			end
		end
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		translate 0, -1
		beat_translate 1/4
	end
end

def pattern second = false; group do
	diamond_grid 5
	group preserve_beat: false do
		(second ? 3 : 4).times do |i|
			tp_chain -8, 0, 1 do
				i==2&&second ? f(-7+2*i, -3, :dl) : t(-7+2*i, -3); b 1/2
				t -7+2*i, -1; b 1/2
				i==2&&second ? t(-7+2*i, 1) : f(-7+2*i, 1, :u)
				bg_note -8+2*i, 2
				bg_note -6+2*i, 2
				b 1
			end
		end
	end
	tp_chain 8, 0, 1 do
		notes = group do
			t 7, -3; b 1/2
			t 7, -1; b 1/2
			bg_note 7, 1; b 1/2
		end
		(1...4).each do |i|
			new_notes = transform duplicate notes, new_tip_points: false do
				translate -4, 0
				rotate PI/2*i
				translate 4, 0
				beat_translate 3/2*i
			end
			b 3/2
		end
		second ? bg_note(7, -3) : t(7, -3); b 1/2
		bg_note 7, -1; b 1/2
		second ? bg_note(7, 1) : t(7, 1); b 1/2
		bg_note 7, 3; b 1/2
	end
end; end
group preserve_beat: false do
	b 3/2
	bg_note 6, -4; b 1/4
	bg_note 8, -3; b 1/4
	6.times do |i|
		3.times do |j|
			x, y = (4+2*j)*(-1)**(i/3).floor, -3+i%3*2+j
			bg_note x, y; b 1/3
		end
	end
end
pattern
tp_chain 0, 8, 1, preserve_beat: false do
	b -5/2
	t 1, -1; b 1/4
	t 0, -2; b 1/4
end

transform pattern true do
	rotate PI
end
tp_chain 0, 8, 1, preserve_beat: false do
	b -3
	3.times do |i|
		4.times do |j|
			x, y = (2+i*2)*(-1)**j, 3-i-j
			t x, y unless i.zero? && j.zero?; b 1/4
		end
	end
end

tp_chain 0, 8, 1, preserve_beat: false do
	h 8, 0, 7; b 8

	h -8, 1, 24; b 7/2
	tp_none do
		d -7, 0; b 1/4
		d -6, -1; b 1/4
		d -5, -2
	end
end

tp_chain -8, 0, 1 do
	f -5, -3, :l; b 1
	d -3, 0; b 1/2
	d -1, -1; b 1
	d 1, 1; b 1
	d 3, 3; b 1/2

	b 2
	d -3, 2; b 1
	d -1, 0; b 1/2
	d 1, -1; b 1/2

	b 1/2
	d 3, 1; b 1/2
	d 5, 2; b 1
	b 2

	b 1
	d -3, 0; b 1/2
	d -1, 1; b 1
	d 1, 3; b 1/2
	d 3, 4; b 1
end

notes = @events.filter { %i[tap flick hold].include? _1.type }
notes.sort_by! &:beat
connected = Set[]
@connected.each do |event|
	next if connected.include? event
	index = notes.bsearch_index { _1.beat >= event.beat }
	event2 = notes[(index..).find { notes[_1] != event }]
	x1, y1, x2, y2 = event[:x], event[:y], event2[:x], event2[:y]
	n = hypot(x2 - x1, y2 - y1).ceil
	0.upto n do |i|
		bg_note(x1+(x2-x1)*i/n, y1+(y2-y1)*i/n).beat = event.beat
	end
	connected.add event
	connected.add event2
end

transform @events do
	scale 25/2
end
check

end
