Integer.alias_method :/, :quo
include Math

Sunniesnow::Charter.open 'special' do

title 'Unleashed World'
artist 'sak feat.みゅい'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '14'

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
def lyrics_display data
	group preserve_beat: false do
		b data.shift if data.first.is_a? Numeric
		duration = data.sum { _1.last }
		data.each do |text, x, y, delta|
			bg_note x, y, duration, text; b delta
			duration -= delta
		end
	end
end

b 11

group preserve_beat: false do
	lyrics_display [
		['DES', -8, 1, 3],
		['PERATE', -8, -1, 6],
		['ne', 8, 2, 1],
		['ver', 8, 0, 2],
		['ends', 8, -2, 5/2],
	]; b 16

	lyrics_display [
		['The', -4, 1, 3],
		['end', -2, 1, 1],
		["won't", 0, 1, 2],
		['lead', 2, 1, 2],
		['me', 4, 1, 4],
		['to', -4, -1, 2],
		['the', -2, -1, 2],
		['un', 0, -1, 7],
		['leashed', 2, -1, 1],
		['world', 4, -1, 12],
	]
end

tpc :u do
	t -3, 2; b 4

	t 2, -2; b 2
	t 3, 0; b 2

	t 5, 1; b 2
	t 6, 3; b 2

	t 0, 3; b 1
	t -1, 1; b 1
	t -2, -1; b 1
	t -3, -3; b 1

	h 2, -2, 4; b 4

	h -4, 0, 4; b 3
	tpd :d do
		2.times { t 3, 4; b 1/2 }

		h 3, 4, 12; b 4
	end

	b 3
	tpd :u do
		2.times { t -3, -4; b 1/2 }

		h -3, -4, 20; b 4
	end

	b 3
	tpd :u do
		2.times { t 3, -4; b 1/2 }

		h 3, -4, 12; b 12
	end
end

b 3/2
tpd :u do
	14.times do
		t 0, 0; b 1/4
	end
end

group preserve_beat: false do
	lyrics_display [
		2,
		['Wheats', -5, -4, 2],
		['shi', -3, -4, 1],
		['ning', -1, -4, 1],
		['in', 1, -4, 1],
		['the', 3, -4, 1],
		['breath', 5, -4, 15/2],
	]; b 16

	lyrics_display [
		2,
		['Birds', -7, -4, 2],
		['sing', -5, -4, 1],
		['ing', -3, -4, 1],
		['in', -1, -4, 1],
		['a', 1, -4, 1],
		['har', 3, -4, 3],
		['mo', 5, -4, 1],
		['ny', 7, -4, 7/2],
	]
end

notes = group do
	tpc(:r) { h -4, -1, 8; b 8 }

	tpc(:l) { h 4, -1, 8; b 4 }

	tpd :d do
		[1, 1/2, 1, 1/2, 1].each do |delta|
			t 0, 4; b delta
		end
	end

	tpc(:r) { h -4, 1, 8; b 8 }

	tpc(:l) { h 4, 1, 4; b 4 }
end

tpc(:r) { h -4, 0, 4; b 4 }

group preserve_beat: false do
	lyrics_display [
		2,
		["They're", -5, -4, 2],
		['li', -3, -4, 1],
		['ving', -1, -4, 1],
		['with', 1, -4, 1],
		['no', 3, -4, 1],
		['fear', 5, -4, 15/2],
	]; b 16

	lyrics_display [
		2,
		['E', -7, -4, 2],
		['ven', -5, -4, 1],
		['though', -3, -4, 1],
		['in', -1, -4, 1],
		['the', 1, -4, 1],
		['far', 3, -4, 5/2],
		['cical', 5, -4, 3/2],
		['tale', 7, -4, 7/2],
	]
end

transform duplicate notes do
	horizontal_flip
	beat_translate 32
end
b 28

tpc(:l) { t 4, 0; b 1 }
tpd :u do
	12.times do
		t 0, 0; b 1/4
	end
end

group preserve_beat: false do
	lyrics_display [
		4,
		['Pho', 6, 2, 3/2],
		['nies', 8, 2, 3/2],
		['dis', 6, 0, 1],
		['turb', 8, 0, 3/2],
		['my', 6, -2, 3/2],
		['mind', 8, -2, 5],
	]; b 16

	lyrics_display [
		4,
		['Change', -7, 2, 3/2],
		['less', -5, 2, 3/2],
		['world', -6, 0, 1],
		['an', -8, -2, 3/2],
		['guishes', -6, -2, 3/2],
		['me', -4, -2, 5],
	]; b 16

	lyrics_display [
		4,
		['Now', -1, 3, 3/2],
		['then', 1, 3, 3/2],
		['how', -1, 1, 1],
		['can', 1, 1, 3/2],
		['I', -2, -1, 3/2],
		['say', 0, -1, 3],
		['who', 2, -1, 1],
		['I', -1, -3, 1],
		['am', 1, -3, 6],
	]; b 24

	lyrics_display [
		['Fruit', -1, 0, 4],
		['less', 1, 0, 3],
	]
end

tpd :l, preserve_beat: false do
	32.times do |i|
		t -6-asin(sin(PI*i/4))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
	end
end
tpc :d do
	t 4, 3; b 1/8
	d 6, 2; b 1/8
	d 8, 1; b 11/4
	t 2, -1; b 1/4
	d 3, -2; b 1/4
	d 4, -1; b 1/4
	d 5, 0; b 1/4

	t 4, 1; b 2
	t 2, 4; b 2

	t -1, 2; b 3/2
	t 2, -1; b 2
	t 5, -3; b 1/4
	d 6, -2; b 1/4

	d 7, -1; b 2
	t 1, 1; b 1
	tpd :r do
		t 4, 0; b 1/2
		t 5, 2; b 1/2
	end

	tpd :r, preserve_beat: false do
		32.times do |i|
			t 6+asin(sin(PI*i/4))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
		end
	end
	t -3, 3; b 1/8
	d -1, 2; b 1/8
	d 1, 1; b 11/4
	t -2, -3; b 1/4
	d -3, -4; b 1/4
	d -4, -3; b 1/4
	d -5, -2; b 1/4

	t -4, -1; b 1
	t -6, 2; b 1/2
	t -4, 3; b 1/2
	t -2, 4; b 1
	t 0, 1; b 1

	t -1, -3; b 1/4
	d -2, -2; b 1/4
	d -3, -1; b 1
	t -7, -2; b 3/2
	t -7, 4; b 1

	t -3, 3; b 1/2
	t -2, 1; b 3/2
	t 1, -2; b 1/2
	tpd :l do
		4.times do |i|
			x, y = -i, -4+i
			i.zero? ? t(x, y) : d(x, y); b 1/8
		end
		t -4, 0; b 1/2
		t -5, 2; b 1/2

		t -6, 4
	end
end
tpc :u do
	t 6, 4; b 1/8
	d -4, 3; b 1/8
	d -2, 2; b 1/4
	group preserve_beat: false do
		(1...8).each do |i|
			t 6+asin(sin(PI*i/2))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
		end
	end
	b 1/2
	(2...4).each do |i|
		b 1/4
		t -6-(-1)**i, 3-i*2; b 1/4
	end
	4.times do |i|
		b 1/4
		t -2+(-1)**i, -3+i*2; b 1/4
	end

	group preserve_beat: false do
		4.times do |i|
			t 1+(-1)**i, 4-i*2; b 1/2
		end
		2.times do |i|
			t 3-(-1)**i, -4+i*2; b 1/2
		end
	end
	6.times do |i|
		b 1/4
		t -6+asin(sin(PI*i/2))/(PI/2)*2+(i/4).floor, asin(cos(PI*(i+1/2)/4))/(PI/2)*4; b 1/4
	end
	tpd(:l) { t -4, 0 }
	t 4, 0; b 1/4
	d -3, 1; b 1/4
	tpd(:l) { t -5, 2 }
	t 5, -2; b 1/4
	d -4, 3; b 1/4

	tpd(:r) { t 6, -4 }
	t -6, 4; b 1/8
	d 4, -3; b 1/8
	d 2, -2; b 1/4
	group preserve_beat: false do
		(1...8).each do |i|
			t -6-asin(sin(PI*i/2))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
		end
	end
	b 1/2
	(2...4).each do |i|
		b 1/4
		t 6+(-1)**i, -3+i*2; b 1/4
	end
	4.times do |i|
		b 1/4
		t 2-(-1)**i, 3-i*2; b 1/4
	end

	group preserve_beat: false do
		4.times do |i|
			t -1-(-1)**i, 4-i*2; b 1/2
		end
		2.times do |i|
			t -3+(-1)**i, -4+i*2; b 1/2
		end
	end
	6.times do |i|
		b 1/4
		t 6-asin(sin(PI*i/2))/(PI/2)*2-(i/4).floor, -asin(cos(PI*(i+1/2)/4))/(PI/2)*4; b 1/4
	end
	t -4, 0
	tpd(:r) { t 4, 0 }; b 1/6
	d 3, -1; b 1/6
	d 4, -1; b 1/6
	t -5, 2
	tpd(:r) { t 5, -2 }; b 1/6
	d 4, -3; b 1/6
	d 5, -3; b 1/6
end

notes = group do
	notes = group do
		tpc(:dl) { t -4, 4 }; b 1/2
		tpc(:ur) { t -7, -3 }; b 1/2
		tpc(:dl) { t -2, 3 }; b 1/2
		tpc(:ur) { t -5, -4 }; b 1/2
	end
	transform duplicate notes do
		beat_translate 2
		horizontal_flip
		translate -9, 0
	end
	b 2
end
transform duplicate notes do
	rotate PI
end

notes = group do
	notes = tpd :dl do
		4.times do |i|
			t -2-i*2, 1+i; b 1/8
			d -2-i*2, i if i >= 2; b 7/8
		end
	end
	transform duplicate notes do
		vertical_flip
		beat_translate 1/2
	end
end
transform duplicate notes do
	rotate PI
	beat_translate 1/4
end

def double direction1, direction2
	angle1 = Sunniesnow::Charter::DIRECTIONS[direction1]
	angle2 = Sunniesnow::Charter::DIRECTIONS[direction2]
	tpd(angle1+PI) { t 4*sqrt(2)*cos(angle1), 4*sqrt(2)*sin(angle1) }
	tpd(angle2+PI) { t 4*sqrt(2)*cos(angle2), 4*sqrt(2)*sin(angle2) }
end
double :ul, :ur; b 1/2
double :dl, :dr; b 1
double :ul, :dr; b 1/2
double :dl, :ur; b 1
double :dl, :dr; b 1/2
double :ul, :ur; b 1/2

b 1/2
2.times do
	double :ul, :dl; b 1/2
	double :ur, :dr; b 1/2
end
b 1/2
tpc :u do
	6.times do |i|
		t (-1)**i*2, 2-i; b 1/6
	end
	mark :m
end

group preserve_beat: false do
	lyrics_display [
		['DES', -8, 1, 3],
		['PERATE', -8, -1, 6],
		['ne', 8, 2, 1],
		['ver', 8, 0, 2],
		['ends', 8, -2, 5/2],
	]; b 16

	lyrics_display [
		['There', -8, 3, 1],
		['is', -6, 3, 1],
		['no', -4, 3, 1],
		['one', -2, 3, 1],
		['left', -8, -3, 1],
		['be', -6, -3, 1],
		['hind', -4, -3, 1],
		['but', -2, -3, 1],
		['on', 2, 3, 1],
		['ly', 4, 3, 1],
		['I', 6, 3, 1],
		['still', 8, 3, 1],
		['be', 4, -3, 2],
		['left', 6, -3, 1/2],
	]; b 16

	lyrics_display [
		['God', 8, 1, 3],
		['dess', 8, -1, 6],
		['can', -8, 3, 1],
		['you', -8, 1, 1],
		['hear', -8, -1, 1],
		['me', -8, -3, 5/2],
	]; b 16

	lyrics_display [
		['I', 2, 3, 1],
		['will', 4, 3, 1],
		['leave', 6, 3, 1],
		['the', 8, 3, 1],
		['or', 2, -3, 1],
		['na', 4, -3, 1],
		['ment', 6, -3, 1],
		['and', 8, -3, 1],
		['say', -8, 3, 1],
		['good', -6, 3, 1],
		['bye', -4, 3, 1],
		['to', -2, 3, 1],
		['pho', -6, -3, 3/2],
		['nies', -4, -3, 1/2],
	]
end

def alt x0, y0, x1, y1, x2, y2
	8.times do |i|
		if i % 4 == 0
			t x0, y0; b 1/4
		else
			t x1 + (x2-x1)*i/8 - (-1)**i*2, y1 + (y2-y1)*i/8; b 1/4
		end
	end
end

def pattern
	group do
		tpc(:r) { t 2, -4 }
		angle = 3*PI/2
		([1/4]*60 + [1/6]*6).each_with_index do |delta, i|
			t 4*cos(angle) - (-1)**i*2, 4*sin(angle); b delta
			angle -= PI*delta/2
		end

		alt -3, 0, 0, -4, 3, 4
		alt -3, 0, 3, 4, 6, -4

		alt -3, 0, 6, 4, 3, -4
		alt -3, 0, 3, -4, 0, 4

		alt -6, 0, 3, 4, 0, -4
		alt -6, 0, 0, -4, -3, 4

		alt -6, 0, -3, -4, 0, 4
	end
end
at :m, preserve_beat: true do
	pattern
end
tpd :d do
	8.times do |i|
		t -(-1)**i*2, 4; b 1/4
	end
end

transform(tpc(:d) { pattern; mark :m }) { horizontal_flip }
at :m, preserve_beat: true do
	8.times do |i|
		t 2*(-1)**i, 4-i; b 1/4
	end
end

group preserve_beat: false do
	lyrics_display [
		-1,
		['It', -2, 2, 1/2],
		['is', 0, 2, 1/2],
		['time', 2, 2, 5],
		['to', -2, 0, 1],
		['re', 0, 0, 1],
		['write', 2, 0, 1],
		['my', -3, -2, 3/2],
		['own', -1, -2, 3/2],
		['sto', 1, -2, 1],
		['ry', 3, -2, 3/2],
	]; b 16

	lyrics_display [
		-2,
		['Make', -3, 1, 1],
		['a', -1, 1, 1],
		['break', 1, 1, 3],
		['with', 3, 1, 1/2],
		['the', -3, -1, 1/2],
		['fai', -1, -1, 2],
		['ry', 1, -1, 2],
		['tale', 3, -1, 7],
	]; b 16
end

def rewrite
	tpd :r, preserve_beat: false do
		4.times do |i|
			t 4+i, -4+i*2; b 1
		end
		b -1/2; t 6, 3; b 1/2

		4.times do |i|
			t 5-i, 4-i*2; b 1
		end

		4.times do |i|
			t 3+i, -4+i*2; b 1
		end
		b -1/2; t 5, 3; b 1/2
		t 4, 4
	end
	tpd :l do
		t -4, -4; b 2
		h -6, 0, 1; b 2

		t -4, 4; b 2
		h -2, 0, 1; b 2

		t -4, -4; b 2
		h -6, 0, 1; b 2

		t -4, 4; b 1
	end
	notes = tpd :ur do
		t -1, 2; b 1/4
		t -1, -1; b 1/4
		t 2, -1; b 1/4
		t 2, -4; b 1/4
	end
	tpd(:ur) { t 5, -4 }
	tpd(:d) { t -4, -3 }
	transform duplicate notes do
		rotate PI
		beat_translate 2
	end
	b 2

	notes = group do
		notes = group do
			notes = group do
				tpd(:dl) { t -5, 4 }
				tpd(:u) { t 4, 3 }; b 1/2
				tpd(:l) { t -7, -4 }; b 1/2
			end
			transform duplicate notes do
				horizontal_flip
				beat_translate 1
			end
			b 1
		end
		transform duplicate notes do
			beat_translate 2
		end
		b 2
	end

	transform duplicate notes do
		vertical_flip
		beat_translate 4
	end
	b 4

	tpc :u do
		4.times do |i|
			8.times do |j|
				t [-6,2,-2,6][j%4], 3.5 - j - (-1)**(j/2).floor*(i/1.5); b 1/4
			end
		end
	end
end
rewrite

notes1 = group do
	notes = group preserve_beat: false do
		notes = tpd :d do
			t -5, 2; b 1/2
			t 5, 2
		end
		transform(duplicate notes) { rotate PI }
	end
	transform duplicate notes do
		translate -3, 0
		beat_translate 3/2
	end
	transform duplicate notes do
		beat_translate 3
	end
	transform(notes) { translate 3, 0 }
end
b 4

notes2 = group do
	notes = group do
		tpd :l, preserve_beat: false do
			t -1, -2; b 1/4
			t 0, -1
		end
		tpd :r do
			t 1, -2; b 1/2
			t 1, 0; b 1/2
		end
	end
	tpd(:l) { t -1, 2 }
	tpd(:r) { t 1, 2 }; b 1/2
	transform duplicate notes do
		beat_translate 3/2
		horizontal_flip
	end
	b 1
	tpd(:l) { t -1, 2 }
	tpd(:r) { t 1, 2 }; b 1/2
	transform duplicate notes do
		beat_translate 3
	end
	b 1
end

transform duplicate notes1 do
	beat_translate 8
	horizontal_flip
end
b 4

tpd :l, preserve_beat: false do
	t -1, -4; b 1/2
	t -1, -2; b 1/2
	t -1, 0; b 1/4
	t 0, 1; b 1/2
	t 0, 3; b 1/4
end
tpd :r do
	t 1, -4; b 1/4
	t 0, -3; b 3/4
	t 1, 0; b 1/2
	t 1, 2; b 1/2
end
notes = group do
	tpc(:d) { t -1, 4 }
	tpc(:u) { t 4, -4 }
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/4
end
b 3/2
tpd(:d) { t -6, 0; t 6, 0 }; b 1/2

6.times do |i|
	tpd PI*(i%2) do
		t (-1)**i, 2-i; b 1/12
		d 0, 1.5-i; b 1/12
	end
end
tpd(:u) { t -3, -4; t 3, -4 }; b 1
tpd :d, preserve_beat: false do
	t -8, 2; b 3/4
	t 2, 2; b 3/4
	t 8, 2; b 1/2
end
tpd :u do
	t -2, -2; b 3/4
	t 8, -2; b 3/4
	t -8, -2; b 1/2
end

transform duplicate notes2 do
	horizontal_flip
	beat_translate 16
end
b 4

notes = tpd :u do
	t -8, -2; b 1/2
	t 2, -2; b 1
	t -2, -2; b 1/2
	t 8, -2; b 1
	t -5, -2; b 1/2
	t 5, -2; b 1/2
end
transform duplicate notes do
	vertical_flip
end

tpd :l, preserve_beat: false do
	t -1, -4; b 1/4
	t 0, -3; b 1/2
	t 0, -1; b 1/2
	t -1, 1; b 1/2
	t -1, 3; b 1/4
	4.times do |i|
		b 1/4
		t [-3,-2,-1,-2][i], 3-i*2; b 1/4
	end
end
tpd :r do
	t 1, -4; b 1/2
	t 1, -2; b 1/2
	t 1, 0; b 1/2
	t 0, 2; b 1/2
	4.times do |i|
		t [1,2,3,2][i], 4-i*2; b 1/2
	end
end

tpd :r, preserve_beat: false do
	16.times do |i|
		t 6+asin(sin(PI*i/4))/(PI/2)*2, -asin(cos(PI*i/4))/(PI/2)*4; b 1/2
	end
end
tpc :u do
	t -3, -4; b 1/2
	t -5, -4; b 1
	t -8, 2; b 1/2
	t -6, 2; b 1
	t -3, 0; b 1/2
	t -5, 0; b 1/2

	b 1/2
	t -8, -2; b 1/2
	t -6, -2; b 1
	t -1, -1; b 1
	t -3, 2; b 1

	tpd :l, preserve_beat: false do
		15.times do |i|
			t -6-asin(sin(PI*i/4))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
		end
		b -3/4; d -4.5, -1
	end
	t 3, -4; b 1/2
	t 5, -4; b 1
	t 8, 2; b 1/2
	t 6, 2; b 1
	t 3, 0; b 1/2
	t 5, 0; b 1/2

	b 1/2
	t 8, 4; b 1/2
	t 6, 4; b 1
	t 1, 2; b 1
	t 3, -1; b 1/4
	t 4, 0; b 1/4
	t -3, 3; b 1/4
	t 1, 3; b 1/4

	group preserve_beat: false do
		16.times do |i|
			tpd(i%8 < 4 ? :r : :l) do
				t asin(sin(PI*i/4))/(PI/2)*2, asin(cos(PI*i/4))/(PI/2)*4; b 1/2
			end
		end
	end
	t -8, 2; b 1/2
	t -6, 2; b 1
	t -7, -3; b 1/2
	t -5, -3; b 1
	t 5, -1; b 1/2
	t 7, -1; b 1/2

	b 1/2
	t 6, 2; b 1/2
	t 8, 2; b 1
	t -6, 0; b 1
	t 5, -1; b 1
end

double :ur, :ul; b 1/2
double :dr, :dl; b 1
double :ur, :dl; b 1/2
double :dr, :ul; b 1
double :dr, :dl; b 1/2
double :ur, :ul; b 1/2

def small32 x0, y0, x1, y1
	4.times do |i|
		x, y = x0 + (x1-x0)*i/4, y0 + (y1-y0)*i/4
		i.even? ? t(x, y) : d(x, y); b 1/8
	end
end
b 1/2
double :dr, :ul; b 1/2
double :ur, :dl; b 1/2
small32 2, 0, 4, 4
double :dr, :ur; b 1/2
small32 -2, 0, -4, 4
double :dl, :ul; b 1/2
small32 0, 0, 0, -4

group preserve_beat: false do
	lyrics_display [
		-1,
		['Here', -2, 1, 1],
		['I', 0, 1, 3],
		['am', 2, 1, 6],
		['to', -3, -1, 1],
		['change', -1, -1, 1],
		['the', 1, -1, 1],
		['world', 3, -1, 5/2],
	]; b 16

	lyrics_display [
		['There', 2, 4, 1],
		['is', 4, 4, 1],
		['no', 6, 4, 1],
		['thing', 8, 4, 1],
		['I', 2, -2, 1],
		['can', 4, -2, 1],
		['do', 6, -2, 1],
		['but', 8, -2, 1],
		['fight', -8, 4, 1],
		['a', -6, 4, 1],
		['gainst', -4, 4, 1],
		['the', -2, 4, 1],
		['des', -6, -2, 3/2],
		['tiny', -4, -2, 1/2],
	]; b 16

	lyrics_display [
		['God', -8, 1, 3],
		['dess', -8, -1, 6],
		['can', 8, 3, 1],
		['you', 8, 1, 1],
		['hear', 8, -1, 1],
		['me', 8, -3, 5/2],
	]; b 16

	lyrics_display [
		['I', -8, 4, 1],
		['will', -6, 4, 1],
		['tri', -4, 4, 1],
		['gger', -2, 4, 1],
		['Doo', -8, -2, 1],
		['ms', -6, -2, 1],
		['day', -4, -2, 1],
		['and', -2, -2, 1],
		['fill', 2, 4, 1],
		['it', 4, 4, 1],
		['with', 6, 4, 1],
		['deep', 8, 4, 1],
		['dark', 4, -2, 3/2],
		['ness', 6, -2, 1/2],
	]; b 16
end

tpd(:ur) { h -4, -4, 14 }
tpd(:ul) { h 4, -4, 14 }
b 12

b 5/2
tpd :u do
	t 1, 4; b 1/4
	t -1, 3; b 1/4
	t -3, 2
end
tpc :r do
	6.times do |i|
		t 2*(-1)**i, 2-i; b 1/6
	end
end

def small16 x0
	tpd :u do
		b 1/4
		t x0-2, -4; b 1/4
		t x0+2, -4; b 1/4
		t x0-2, -4; b 1/4
	end
end
def pattern
	tpc :r do
		t 4, 0; small16 -2
		t 2, 1; small16 -2
		t 0, 0; small16 -4
		t -2, 1; small16 -4

		t -4, 2; small16 -2
		t -2, 3; small16 -2
		t 0, 2; small16 0
		t 2, 1; small16 0

		t 4, 2; small16 2
		t 2, 3; small16 2
		t 0, 4; small16 0
		t -2, 3; small16 0

		t 0, 2; small16 -2
		t 2, 1; small16 -2
	end
end
pattern
tpd :d do
	8.times do |i|
		t 2*(-1)**i, 4; b 1/4
	end
end

tpc(:r) { t 2, -4 }
tpc :d do
	angle = -PI/2
	([1/4]*60 + [1/6]*6).each_with_index do |delta, i|
		t 4*cos(angle) - (-1)**i*2, 4*sin(angle); b delta
		angle += PI*delta/2
	end
end

transform(pattern) { horizontal_flip }
tpc :d do
	8.times do |i|
		t -2*(-1)**i, -4+i; b 1/4
	end
end

group preserve_beat: false do
	lyrics_display [
		-1,
		['It', -2, 2, 1/2],
		['is', 0, 2, 1/2],
		['time', 2, 2, 5],
		['to', -2, 0, 1],
		['re', 0, 0, 1],
		['write', 2, 0, 1],
		['my', -3, -2, 3/2],
		['own', -1, -2, 3/2],
		['sto', 1, -2, 1],
		['ry', 3, -2, 3/2],
	]; b 16

	lyrics_display [
		-2,
		['Make', -3, 1, 1],
		['a', -1, 1, 1],
		['break', 1, 1, 3],
		['with', 3, 1, 1/2],
		['the', -3, -1, 1/2],
		['fai', -1, -1, 2],
		['ry', 1, -1, 2],
		['tale', 3, -1, 11/2],
	]
end

transform(group { rewrite }) { rotate PI }

lyrics_display [
	-1,
	['To', -5, 0, 1],
	['get', -3, 0, 3],
	['to', 3, 0, 1/2],
	['the', 5, 0, 1/2],
	['un', -1, 4, 2],
	['leashed', 1, 4, 2],
	['world', 0, -4, 8],
]

notes = group do
	8.times do |i|
		angle = -PI/2 + 3/4*PI*i
		tpd(angle+PI) { t 4+4*cos(angle), 4*sin(angle) }
		tpd(-angle+PI) { t -4+4*cos(-angle), 4*sin(-angle) }; b 1/4
		d 4+3*cos(angle), 3*sin(angle); b 1/4
	end
end

transform duplicate notes do
	horizontal_flip
	beat_translate 4
end
b 4

notes = group do
	notes = group do
		tpd :r, preserve_beat: false do
			t 4, 3; b 1/3
			t 6, 0; b 1/3
			t 4, -3; b 1/3
		end
		4.times do |i|
			x, y = -1, -1.5 + i
			i.even? ? t(x, y) : d(x, y); b 1/4
		end
	end
	transform duplicate notes do
		beat_translate 1
		rotate PI
	end
	b 1
end
transform duplicate notes do
	beat_translate 2
	vertical_flip
	scale 4/3
end
b 2

notes = group do
	notes = group do
		tpd(:r) { t 4, -3 }
		d 3, -2; b 1
		tpd(:r) { t 8, -4 }
		d 7, -3; b 1
	end
	transform duplicate notes do
		rotate PI
		beat_translate 1/4
	end
end
transform duplicate notes do
	vertical_flip
	beat_translate 1/2
end
group preserve_beat: false do
	6.times do |i|
		tpd(:r) { t [6,2][i%2], [4,0,-4][i%3] }; b 1/6
		tpd(:l) { t [-2,-6][i%2], [4,0,-4][i%3] }; b 1/6
	end
end
d 5, 3; b 1/4
d -1, 3; b 1/4
d -5, -1; b 1/4
d 5, -3; b 1/4
d 1, 3; b 1/4
d -5, 3; b 1/4
d 5, -1; b 1/4
d -5, -3; b 1/4

transform @events do
	scale 12.5
end

check

end
