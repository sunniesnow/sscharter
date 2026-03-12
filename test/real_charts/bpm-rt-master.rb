include Math
Integer.alias_method :/, :quo
srand 1108
module Enumerable
	def each_with_sum initial = 0
		return to_enum __method__, initial unless block_given?
		sum = initial
		each do |x|
			yield x, sum
			sum += x
		end
	end
end

Sunniesnow::Charter.open 'master' do

title 'BPM=RT'
artist 't+pazolite'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '13'

offset 0.589 - 60.0/1962*32
bpm 1962/8.0

#==========
# Intro
#==========

intro = group do
	b 3
	tp_chain -25, -25, relative_beat: 1 do
		t 25, -25; b 1/2
		d 37.5, -12.5; b 1/2

		d 50, 0
	end
	tp_chain 0, -100, 1 do
		t 0, 0; b 1
		t -25, 25; b 1
		t -50, 12.5; b 1
		t -75, 0; b 2
		t -75, -37.5; b 1
		t -50, -50; b 1
		t -25, -37.5; b 1

		tp_chain(0, 100, 1) { t 75, 0 }; b 1
		t 0, -12.5; b 3
	end
end
transform(duplicate intro) { horizontal_flip; beat_translate 16 }; b 16
tp_chain -100, 0, 1, preserve_beat: false do
	b 2
	t -25, 25; b 2

	h -50, -25, 2; b 4
	f -50, 12.5, :l; b 4

	h -87.5, -12.5, 2; b 4
	f -87.5, 25, :l; b 4

	b 4
end
tp_chain 0, 100, 1, preserve_beat: false do
	b 3
	t 0, -25; b 1/2
	d 12.5, -12.5; b 1/2

	d 25, 0; b 1
	t 50, 25; b 1
	t 75, 12.5; b 1
	t 100, 0; b 2
	t 87.5, -25; b 1
	t 62.5, -37.5; b 1
	t 37.5, -25; b 1

	b 1
	t 12.5, 0; b 3
end
b 4

def pentagon_bg_note x, y, only_latter: false
	group do
		r = 25
		unless only_latter
			b 1
			(-1..1).each do |i|
				angle = PI/2 - i*PI*2/5
				bg_note x + r*cos(angle), y + r*sin(angle), 1/2; b 1
			end
		end
		[-1/2, 1/2].each do |i|
			angle = -PI/2 - i*PI*2/5
			bg_note x + r*cos(angle), y + r*sin(angle), 3/2; b 2
		end
	end
end
pentagon_bg_note 12.5, 12.5
pentagon_bg_note 37.5, 25

tp_chain -100, 0, 1, preserve_beat: false do
	h 50, -25, 2; b 4
	f 50, 12.5, :r; b 4

	h 87.5, -12.5, 2; b 4
	f 87.5, 25, :r; b 4
end
tp_chain 0, 100, 1, preserve_beat: false do
	b -1
	t -12.5, -37.5; b 1/2
	d -25, -25; b 1/2

	d -37.5, -12.5; b 1
	t -50, 12.5; b 1
	t -75, 25; b 1
	t -100, 37.5; b 2
	t -87.5, 0; b 1
	t -62.5, -12.5; b 1
	t -37.5, 0; b 1
end
pentagon_bg_note -25, 12.5
pentagon_bg_note -37.5, 25

def pentagon_tap
	group do
		r = 25
		tp_chain(0, 100, 1) { h -100, 0, 15; b 1 }
		(-1..1).each_with_index do |i, j|
			angle = PI/2 - i*PI*2/5
			x, y = r*cos(angle), r*sin(angle)
			t x, y; bg_note x, y, 7-j; b 1
		end
		[-1/2, 1/2].each_with_index do |i, j|
			angle = -PI/2 - i*PI*2/5
			x, y = r*cos(angle), r*sin(angle)
			t x, y; bg_note x, y, 4-j*2; b 2
		end

		h 0, 0, 7; b 2
		(1..3).each { d 0, -12.5*_1; b 2 }
	end
end
pentagon_tap
transform(pentagon_tap) { horizontal_flip }

#==========
# Intro (glitch)
#==========

tp_chain 100, 0, 1, preserve_beat: false do
	b -1
	higher_ranges = [[3+1/4, 5], [9+1/2, 11], [15, 17], [17+1/2, 18], [20+1/2, 23+1/2], [27,32]]
	subdiv = 8
	(-subdiv...32*subdiv).each do |i|
		i /= subdiv
		is_higher = higher_ranges.any? { _1 <= i && i < _2 }
		block = ->j, delta do
			angle = PI - j*PI/2
			r = 50 - rand*12.5
			[8, 16, 24].each { r += (1-(i-_1).abs)*12.5 if (i-_1).abs < 1 }
			x, y = 50 + r*cos(angle), r*sin(angle)
			x = -x if i%16>=8 && i>=0; y = y.clamp -50, 50
			y = r*(y<=>0) if i >= 31
			d x, y; b delta
		end
		if is_higher
			block.(i, 1/subdiv/2)
			block.(i+1/subdiv/2, 1/subdiv/2)
		else
			block.(i, 1/subdiv)
		end
	end
end

tp_chain 0, 100, 1, preserve_beat: false do
	deltas = ([[1]*5, [1/2]*2, [1]*2]*2 + [1, [1/2]*4, 1]*4).flatten
	deltas.each_with_sum do |delta, i|
		angle = -i*PI/4
		r = 37.5
		[8, 16, 24].each { r += (2-(i-_1).abs)*6.25 if (i-_1).abs < 2 }
		x, y = -50 + r*cos(angle), r*sin(angle)
		x = -x if i%16 >= 8; y = y.clamp -50, 50
		y = r*(y<=>0) if i >= 31
		i%16==0 ? f(x, y, i==0 ? :l : :u) : t(x, y); b delta
	end
end

pentagon_bg_note 50, 0
pentagon_bg_note -50, 0

pentagon_bg_note 50, 0
pentagon_bg_note -50, 0, only_latter: true
pentagon_bg_note 50, 0, only_latter: true

turntable 24
tp_drop 0, 0, relative: false, relative_beat: 3/2 do
	two_chains = group preserve_beat: false do
		one_chain = group do
			16.times do |i|
				angle = -PI/2+i*PI/16
				r = 50
				x, y = r*cos(angle), r*sin(angle)
				i == 0 ? f(x, y, :r) : d(x, y); b 1/8
			end
		end
		transform(duplicate one_chain) { rotate PI; beat_translate 2 }
	end
	[4, 8, 12].each { |delta| transform(duplicate two_chains) { beat_translate delta } }
end

tp_chain 0, 0, relative: false, relative_beat: 3/2, preserve_beat: false do
	32.times do |i|
		angle = PI/2+i*PI/4; r = 50
		t r*cos(angle), r*sin(angle); b 1/2
	end
end

(1..8).each do |i|
	ornament = group do
		2.times do
			8.times do |j|
				angle = acos(1/8) * (j-3.5)/3.5
				r = 50
				x, y = r*i/8 + r*cos(angle), r*sin(angle)
				bg_note x, y; b 1/8
			end
		end
	end
	transform(duplicate ornament) { rotate PI }
end

=begin
64.times do |i|
	angle = i*PI/32
	x, y = 100*cos(angle), 50*sin(angle)
	bg_note x, y, 8
end
tp_chain 0, 0, 1, relative: false do
	32.times do |i|
		angle = PI/2 + i*PI/32
		angle += PI if i%2 == 1
		r = 50
		x, y = r*cos(angle), r*sin(angle)
		x *= 2 if i%4 >= 2
		t x, y; b 1/8
		d x - 6.25 * (x<=>0), y; b 1/8
	end
end
=end

(1..8).each do |i|
	8.times do |j|
		angle = acos(1/8) * (j-3.5)/3.5
		r = 50
		x, y = r*i/8 + r*cos(angle), r*sin(angle)
		bg_note x, y, 8
		bg_note -x, y, 8
	end
end
32.times do |i|
	tp_chain 0, 0, relative: false, relative_beat: 3/2 do
		angle = PI/2 + PI*(1-(1-i/32)**4)
		angle += PI if i%2 == 1
		r = 50
		x, y = r*cos(angle), r*sin(angle)
		t x, y; b 1/8
		r = 37.5
		x, y = r*cos(angle), r*sin(angle)
		d x, y; b 1/8
	end
end

def inter_pattern
	tp_drop -100, 0, 1 do
		12.times do |i|
			x = [-25, 25, 12.5, 25][i%4]
			y = 100*i/12 - 50
			x += y
			t x, y; b 1/4
		end
		f 25, 50, :l; b 1
	end
end

tp_chain 0, 0, relative: false, relative_beat: 3/2 do
	t 0, -50; b 3/4
	h 0, 0, 1; b 5/4
end
bg_note 100/3, 100/3; b 3/4
bg_note 0, 0; b 3/4
bg_note -100/3, -100/3; b 1/2
inter_pattern

#==========
# Verse 1
#==========

def speed x, y, n, ending: true
	bg_note_places = (
		(-3..3).map { [[_1*25, 50], [_1*25, -50]] } +
		(-2..2).map { [[-100, _1*25], [100, _1*25]] }
	).flatten.each_slice(2).to_a
	(n*4).to_i.times do |i|
		tp_chain 0, 100, 0.5 do
			angle = PI/2 + i*PI*7/8
			group preserve_beat: false do
				b 1
				4.times { bg_note *bg_note_places.sample; b 1/16 }
			end
			t x, y; b 1/8
			d x+12.5*cos(angle), y+12.5*sin(angle); b 1/8
		end
	end
	tp_chain(0, 100, 0.5) { t x, y } if ending
end
def chain x1, y1, x2, y2, delta, length
	bg_note_places = (
		(-2..2).map { [[_1*25, 25], [_1*25, -25]] } +
		(-1..1).map { [[-75, _1*25], [75, _1*25]] }
	).flatten.each_slice(2).to_a
	n = (length/delta).to_i
	n.times do |i|
		x, y = x1 + (x2-x1)*i/n, y1 + (y2-y1)*i/n
		group preserve_beat: false do
			b 1
			bg_note *bg_note_places.sample
		end
		i == 0 ? t(x, y) : d(x, y); b delta
	end
end

verse = group do
	diamond_grid 6
	speed 0, 0, 6; b 1/2
	tp_chain 100, 0, 0.5 do
		chain 25, -25, 75, 25, 1/16, 1/2
		h -25, -12.5, 1/2; b 1
	end

	diamond_grid 4
	speed 25, 0, 5/2; b 1/2
	tp_chain 0, 100, 0.5 do
		chain -75, -25, -25, 25, 1/8, 1
		chain -25, 25, 25, -25, 1/16, 1
	end
	tp_drop 100, 0, 0.5 do
		t 50, 25; b 1/4
		t 37.5, 12.5; b 1/4
		t 50, 0; b 1/4
		t 37.5, -12.5; b 1/4
		t 50, -25; b 1/2
	end
	tp_chain 0, -100, 0.5 do
		chain 25, -50, -25, 0, 1/8, 1/2; b 1
	end
end

transform(duplicate verse) { rotate PI; beat_translate 16 }
b 16

grid 4
tp_drop 0, 100, 0.5 do
	16.times do |i|
		group preserve_beat: false do
			b 1
			x, y = 25+75*i/16, 50*i/16*(-1)**i
			bg_note x, y; b 1/8
			bg_note -x, y; b 1/8
		end
		t 25*(-1)**i, 0; b 1/4
	end
end
3.times do
	tp_chain(0, 100, 0.5) { f 25, 0, :r; b 1/2 }
	tp_chain(0, 100, 0.5) { chain -25, 0, -75, 50, 1/16, 1/2 }
end
tp_chain(0, 100, 0.5) { f 25, 0, :u; b 1 }

diamond_grid 4
speed 75, 0, 5/2; b 1/2
tp_chain 0, 100, 0.5 do
	chain 100, 50, 0, -50, 1/8, 1
	chain 0, -50, -100, 50, 1/16, 1
end
tp_drop 100, 0, 0.5 do
	t 0, 25; b 1/4
	t -12.5, 12.5; b 1/4
	t 0, 0; b 1/4
	t -12.5, -12.5; b 1/4
	t 0, -25; b 1/2
end
tp_chain 0, -100, 0.5 do
	chain -25, -50, -100, 25, 1/8, 1/2; b 1
end

diamond_grid 6
speed 0, 0, 6; b 1/2
tp_chain 100, 0, 0.5 do
	chain -100, 50, 0, -50, 1/16, 1/2
	chain 0, -50, 25, -25, 1/6, 1/2
	d 25, -25; b 1/4
	d 37.5, -12.5; b 1/4
end

diamond_grid 8
speed 50, 0, 5/2, ending: false
tp_chain 0, 100, 0.5 do
	chain 50, 0, 0, 0, 1/6, 1/2
end
speed 0, 0, 4, ending: false
tp_chain 0, 100, 0.5, preserve_beat: false do
	(0..6).each do |i|
		x, y = 50*i/6, 50*i/6
		d x, y; b 1/6 if i < 6
	end
end
tp_chain 0, 100, 0.5 do
	(0..8).each do |i|
		x, y = -50*i/8, 50*i/8
		i == 0 ? h(x, y, 32) : d(x, y); b 1/8 if i < 8
	end
end

#==========
# Intertlude
#==========

def percussion
	group preserve_beat: false do
		b 6
		tp_chain 0, 100, 1 do
			t 50, 25; b 1
			t 37.5, 0; b 1/2
			t 50, -12.5; b 1/2
		end
	end
end
percussion; b 8

percussion; b 8

percussion
tp_chain -100, 0, 1 do
	t -12.5, 25; b 1
	t 12.5, 37.5; b 1
	t 37.5, 25; b 1
	t 62.5, 12.5; b 1
end
b 4

percussion
tp_chain 0, -100, relative_beat: 4 do
	b 1
	t 75, -50; b 1
	t 75, -25; b 1
	t 75, 0; b 1
	f 75, 25, :r; b 1
	t 75, 50; b 1
end
b 2

#==========
# Interlude (glitch)
#==========

group preserve_beat: false do
	subdiv = 8
	(0...56*subdiv).each do |i|
		i /= subdiv
		block = ->j, delta do
			angle = PI - j*PI/2
			r = 50 - rand**2*37.5
			[8, 16, 24].each { r += (1-(i-_1).abs)*3.75 if (i-_1).abs < 1 }
			x, y = 50 + r*cos(angle), r*sin(angle)
			x = -x if i%16>=8 && i>=0; y = y.clamp -50, 50
			bg_note x, y; b delta
		end
		block.(i, 1/subdiv)
	end
end

tp_drop 0, 100, 1 do
	pentagon 2
	[
		-50, 0, [-25, 6],
		62.5, 37.5, [62.5, 6],
		-50, 0, [-25, 6],
		62.5, [37.5, 2], -25, [12.5, 1/2], [0, 3/2], -25, [62.5, 1/4], [37.5, 3/4]
	].each do |x, delta|
		t x, -37.5; b delta || 1
		pentagon 2 if delta == 6
		pentagon 1/2 if delta == 2 || delta == 3/2
	end
end

@tp_distance = 100
def note_1
	tp_drop 0, (@tp_distance*=1.025), 1, preserve_beat: false do
		d 62.5, -37.5; b 1/4
		d 37.5, -37.5
	end
end
def note_2
	tp_drop 0, (@tp_distance*=1.025), 1 do
		d 37.5, -37.5
	end
end
group preserve_beat: false do
	b 1/4
	4.times { note_1; b 5/4 }
	3.times { note_2; b 1 }
	3.times { note_2; b 3/4 }
	11.times { note_2; b 1/2 }

	32.times { note_2; b 1/4 }
end

grid 24
6.times do |i|
	dx = 12.5 + 6.25*i/6
	dy = dx / 4
	tp_chain -8*dx, 8*dy, relative_beat: 4 do
		8.times do |j|
			x = -100 + 6.25*i + dx*j
			y = 50 - 25*(i-3).abs - dy*j
			[0, 3, 6].include?(j) ? t(x, y) : d(x, y); b 1/2
		end
	end
end

tp_chain 0, 100, 1 do
	h 75, -37.5, 3; b 1
end
bg_note 75, -12.5; b 1
bg_note 75, 12.5; b 1
bg_note 75, 37.5; b 1
=begin
4.times do |i|
	angle = -3/4*PI + i*PI/2
	x, y = 25*cos(angle), 25*sin(angle)
	t x-50, y+25; b 1/4
	t x+50, y+12.5; b 1/4
	t x+37.5, y; b 1/4
	t x+50, y-12.5; b 1/4
end
=end
tp_chain 0, 100, 1 do
	t -75, 50; b 1/2
	14.times do |i|
		t 25*(-1)**i, 37.5-6.25*i; b 1/4
	end
end

#==========
# Verse 2
#==========

def kick x, y
	12.times do |i|
		angle = 2*PI*i/12
		bg_note x + 12.5*cos(angle), y + 12.5*sin(angle)
	end
	t x, y
end
def snare x, y, direction
	12.times do |i|
		angle = 2*PI*i/12
		bg_note x + 12.5*cos(angle), y + 12.5*sin(angle)
	end
	f x, y, direction
end
def rectangle x, y, width, height, duration
	(0...width).step(12.5) do |dx|
		bg_note x + dx, y, duration
		bg_note x + width - dx, y + height, duration
	end
	(0...height).step(12.5) do |dy|
		bg_note x, y + height - dy, duration
		bg_note x + width, y + dy, duration
	end
end
def alternating x0, y0, width, height, subdivision, duration
	(n = duration * 4 * subdivision).to_i.times do |i|
		j, k = i.divmod subdivision
		x = 25 * k/subdivision * (width <=> 0)
		x = j%2==0 ? x0 + x : x0 + width - x
		y = y0 + height * i/(n-1)
		tp_chain((j%2==0 ? -100 : 100) * (width <=> 0), 0, 0.5) do
			k == 0 ? t(x, y) : d(x, y)
		end
		b 1/4/subdivision
	end
end
def confined_alternating x0, y0, width, height, subdivision, duration
	x, w = width > 0 ? [x0, width] : [x0 + width, -width]
	y, h = height > 0 ? [y0, height] : [y0 + height, -height]
	group do
		rectangle x - 12.5, y - 12.5, w + 25, h + 25, duration
		alternating x0, y0, width, height, subdivision, duration
	end
end
def chain x1, y1, x2, y2, delta, length
	n = (length/delta).to_i
	group do
		n.times do |i|
			x, y = x1 + (x2-x1)*i/n, y1 + (y2-y1)*i/n
			d x, y; bg_note x, y; b delta
		end
	end
end

def pattern ending = false
	tp_chain 0, 100, 0.5 do
		kick -87.5, -37.5; b 1/2
		confined_alternating -50, 25, -25, -50, 2, 3/2
		snare -37.5, -37.5, :r; b 1/2
		confined_alternating(-25, 25, 25, -37.5, 3, 1).tap do |g|
			g.filter { _1.type == :drag }.take(2).each { remove _1 }
		end
		kick -12.5, -25; b 1/2

		confined_alternating 25, 25, -25, -50, 2, 1
		kick 25, -37.5; b 1/3
		tp_drop 100, 0, 0.5 do
			chain 50, -37.5, 100, 37.5, 1/12, 2/3
		end
		snare 25, 37.5, :l; b 1/2
		tp_drop 0, -100, 0.5 do
			chain 12.5, 37.5, -50, 37.5, 1/6, 1/2
		end
		confined_alternating 12.5, 25, -25, -37.5, 1, 1

		kick 0, -25; b 1/2
		tp_drop -100, 0, 0.5 do
			chain -25, -25, -87.5, 25, 1/8, 1/2
		end
		kick -87.5, 37.5; b 1/3
		tp_drop 0, -100, 0.5 do
			chain -62.5, 37.5, 12.5, 25, 1/12, 2/3
		end
		snare 50, 37.5, :r; b 1
		confined_alternating 12.5, 25, 25, -37.5, 1, 1

		kick 0, -25
		unless ending
			b 1/2
			confined_alternating -37.5, 25, 25, -37.5, 2, 1
			kick -50, -25; b 1/2
			confined_alternating -87.5, 25, 25, -37.5, 2, 1
			kick -75, -37.5; b 1
		else
			b 1/8
			(1...24).each do |i|
				angle = i/24*PI
				x, y = -100*sin(angle), -25-25*sin(2*angle)
				tp_chain -100*cos(angle), 100*sin(angle), 0.5 do
					d x, y
				end
				tp_chain 100*cos(angle), 100*sin(angle), 0.5 do
					i == 8 ? t(-x, y) : i > 8 ? d(-x, y) : bg_note(-x, y)
				end
				b 1/8
			end
			8.times do |i|
				angle = i/24*PI
				x, y = 100*i/8, 50-(1-i/8)**2*75
				note = tp_chain 100*sin(angle), 100*cos(angle), 0.5 do
					d x, y
				end
				transform(duplicate note) { horizontal_flip } if i > 0
				b 1/8
			end
		end
	end
end
transform(pattern) { horizontal_flip }
pattern true

group preserve_beat: false do
	tp_chain 0, 100, 1 do
		t -100, 50; b 1/2
		tp_drop -100, 0, 0.5 do
			chain -100, 50, -50, -12.5, 1/8, 3/2
		end
		t -50, -12.5; b 1/2
		t -75, -37.5; b 1/4
		tp_drop 0, 100, 0.5 do
			chain -75, -37.5, -25, -50, 1/12, 3/4
		end
		t -25, -50; b 1/2

		tp_drop -100, 0, 0.5 do
			chain -25, -50, -75, 12.5, 1/8, 1
		end
		t -75, 12.5; b 1/3
		tp_drop 0, -100, 0.5 do
			chain -75, 12.5, -12.5, 50, 1/12, 2/3
		end
		t -12.5, 50; b 1/2
		tp_drop -100, 0, 0.5 do
			chain -12.5, 50, -25, 25, 1/6, 1/2
			chain -25, 25, -50, -25, 1/4, 1
		end

		t -50, -25; b 1/2
		tp_drop -100, 0, 0.5 do
			chain -50, -25, -100, -37.5, 1/8, 1/2
		end
		t -100, -37.5; b 1/3
		tp_drop -100, 0, 0.5 do
			chain -100, -37.5, -62.5, 0, 1/12, 2/3
		end
		t -62.5, 0; b 1
		tp_drop 0, 100, 0.5 do
			chain -62.5, 0, 0, -50, 1/4, 1
		end

		t 0, -50; b 1/2
		tp_drop -100, 0, 0.5 do
			chain 0, -50, -25, 25, 1/8, 1
		end
		t -25, 25; b 1/2
		tp_drop 0, -100, 0.5 do
			chain -25, 25, -100, -12.5, 1/8, 1
		end
		t -100, -12.5; b 1
	end

	notes = tp_chain 0, 100, 1 do
		t 100, 50; b 1/2
		tp_drop 100, 0, 0.5 do
			chain 100, 50, 75, -37.5, 1/8, 3/2
		end
		t 75, -37.5; b 1/2
		t 50, -12.5; b 1/4
		tp_drop 100, 0, 0.5 do
			chain 50, -12.5, 25, -50, 1/12, 3/4
		end
		t 25, -50; b 1/2

		tp_drop 100, 0, 0.5 do
			chain 25, -50, 25, 37.5, 1/8, 1
		end
		t 25, 37.5; b 1/3
		tp_drop 0, -100, 0.5 do
			chain 25, 37.5, 75, 12.5, 1/12, 2/3
		end
		t 75, 12.5; b 1/2
		tp_drop 0, -100, 0.5 do
			chain 75, 12.5, 50, 0, 1/6, 1/2
			chain 50, 0, 0, -25, 1/4, 1
		end

		t 0, -25; b 1/2
		tp_drop 0, 100, 0.5 do
			chain 0, -25, 62.5, -37.5, 1/8, 1/2
		end
		t 62.5, -37.5; b 1/3
		tp_drop 100, 0, 0.5 do
			chain 62.5, -37.5, 75, 0, 1/12, 2/3
		end
		t 75, 0; b 1
		tp_drop 0, -100, 0.5 do
			chain 75, 0, 0, 50, 1/4, 1
		end
	end
end

def sweep config
	sign = 1
	x = 0
	y = 0
	h0 = 2
	h = 3
	y_ = -> do
		i, r = y.divmod h0
		r += (h-h0) * (r/h0)**2
		i.even? ? r : h-r
	end
	group do
		config.each_with_index do |(delta, is_rest), i|
			n = delta*8
			x0 = x
			n.to_i.times do |j|
				x = x0 + sign * (1-(1-j/n)**2) * delta unless is_rest
				i.zero? && j.zero? ? h(x, y_.(), config.sum { |d,r| d } - 1) : d(x, y_.())
				y += 1/8
				b 1/8
			end
			next if is_rest
			x = x0 + sign * delta
			sign *= -1
		end
	end
end

tp_chain 100, 150, 1, relative: false do
	transform sweep [
		*([1, 1/2, 1/2, [1/2,0], 1/2, 1]*2),
		1, *([1/2]*10), 1, 1/2, 1/2
	] do
		compound_linear -100, 0, -12.5/3, -87.5/3
		translate 100, 50
	end
end

tp_chain -100, 150, 1, relative: false do
	transform sweep [
		1/2, 1/2, 1, *([1/2]*4), 1, *([1/2]*6),
		1, *([1/2]*6)
	] do
		compound_linear 100, 0, -12.5/3, -87.5/3
		translate -100, 50
	end
end

checkerboard 3
tp_chain 0, 200, relative_beat: 4, preserve_beat: false do
	b 2
	d 0, -50; b 1
	f 50, 0, :r; b 1
end
tp_chain 0, 100, relative_beat: 2 do
	(-50..50).step(25) { t 0, -_1; b 1/2 }; b 1/2
	f -50, 0, :l; b 1
end

def arc_chain x, y, start_angle, end_angle, duration
	direction = start_angle + PI/2
	direction += PI if start_angle > end_angle
	direction = (direction / (PI/4)).round * PI/4
	group do
		n = duration * 16
		n.to_i.times do |i|
			angle = start_angle + (end_angle - start_angle) * i/n
			dx = 50 * cos(angle)
			dy = 50 * sin(angle)
			relative_beat = 2 + i/16
			ratio = relative_beat / (relative_beat - 1)
			tp_chain -dx*ratio, -dy*ratio, relative_beat: do
				# i == 0 ? f(x + dx, y + dy, direction) : d(x + dx, y + dy)
				i == 0 ? h(x + dx, y + dy, duration) : d(x + dx, y + dy)
			end
			b 1/16
		end
	end
end

def straight_chain x1, y1, x2, y2, left, duration
	angle = atan2 y2-y1, x2-x1
	direction = (angle / (PI/4)).round * PI/4
	angle += PI/2*(left ? 1 : -1)
	x0, y0 = (x1+x2)/2, (y1+y2)/2
	distance = hypot(x2-x1, y2-y1) / 2
	cx, cy = x0 + distance*cos(angle), y0 + distance*sin(angle)
	group do
		n = duration * 16
		n.to_i.times do |i|
			x, y = x1+(x2-x1)*i/n, y1+(y2-y1)*i/n
			relative_beat = 2 + i/16
			ratio = relative_beat / (relative_beat - 1)
			tx, ty = (cx-x)*ratio, (cy-y)*ratio
			tp_chain tx, ty, relative_beat: do
				# i == 0 ? f(x, y, direction) : d(x, y)
				i == 0 ? h(x, y, duration) : d(x, y)
			end
			b 1/16
		end
	end
end

notes_right = group do
	b 1
	arc_chain 50, 50, PI, PI*3/2, 1/2; b 1/2
	arc_chain 50, -50, PI/2, PI, 1/2; b 1/2
	arc_chain 0, 0, -PI/2, PI/2, 1
end
transform(notes_left = duplicate(notes_right)) { rotate PI }

transform(duplicate [*notes_right, *notes_left]) { vertical_flip; beat_translate 4 }
b 4

notes_right = group do
	b 1
	arc_chain 50, 50, PI*3/2, PI, 1/2; b 1/2
	arc_chain 50, -50, PI/2, PI, 1/2; b 1/2
	straight_chain 50, 0, 100, 0, true, 1/2; b 1/2
end
transform(notes_left = duplicate(notes_right)) { horizontal_flip }

notes_right = group do
	straight_chain 87.5, 37.5, 12.5, -37.5, false, 1/2; b 1/2
	straight_chain 12.5, 37.5, 87.5, -37.5, true, 1/2; b 1/2
end
transform(notes_left = duplicate(notes_right)) { rotate PI; beat_translate 1/2 }
straight_chain 100, 0, 0, 0, false, 1
straight_chain -100, 0, 0, 0, true, 1

notes_right = group do
	b 1
	arc_chain 0, 0, PI/2, 0, 1/2; b 1/2
	arc_chain 0, 0, 0, -PI/2, 1/2; b 1/2
	arc_chain 0, 0, -PI/2, PI/2, 1
end
transform(notes_left = duplicate(notes_right)) { rotate PI }

transform(duplicate [*notes_right, *notes_left]) { vertical_flip; beat_translate 4 }
b 4

notes_right = group do
	b 1
	arc_chain 0, 0, 0, PI/2, 1/2; b 1/2
	arc_chain 0, 0, 0, -PI/2, 1/2; b 1/2
	straight_chain 50, 0, 100, 0, true, 1/2; b 1/2
end
transform(notes_left = duplicate(notes_right)) { horizontal_flip }

notes_right = group do
	straight_chain -50, 50, -50, -50, true, 1/2; b 1/2
	straight_chain -12.5, 0, -100, 0, true, 1/2; b 1/2
end
transform(notes_left = duplicate(notes_right)) { rotate PI; beat_translate 1/2 }
straight_chain -100, 50, 0, -50, false, 1
straight_chain 100, 50, 0, -50, true, 1

def flick_chain x1, y1, x2, y2, delta, duration
	direction = (atan2(y2-y1, x2-x1) / (PI/4)).round * PI/4
	bg_note_places = (
		(-2..2).map { [[_1*25, 25], [_1*25, -25]] } +
		(-1..1).map { [[-75, _1*25], [75, _1*25]] }
	).flatten.each_slice(2).to_a
	n = (duration/delta).to_i
	group do
		n.times do |i|
			x, y = x1 + (x2-x1)*i/n, y1 + (y2-y1)*i/n
			i == 0 ? snare(x, y, direction) : d(x, y)
			group preserve_beat: false do
				b 1
				bg_note *bg_note_places.sample
			end
			b delta
		end
	end
end

kick -37.5, 0; b 1/4
speed 0, 0, 15/4, ending: false

tp_chain -100, 0, 0.5 do
	flick_chain -50, 0, 0, -37.5, 1/8, 3/2
	flick_chain 0, -37.5, 50, 0, 1/8, 3/2
end
speed 0, 0, 1, ending: false

kick -37.5, 0; b 1/4
speed 0, 0, 11/4, ending: false
tp_chain -100, 0, 0.5 do
	flick_chain -25, -25, 25, -25, 1/8, 1
end

kick 37.5, 0; b 1/4
speed 0, 0, 5/4, ending: false
tp_chain 100, 0, 0.5 do
	flick_chain 50, 0, 0, -37.5, 1/8, 3/2
	flick_chain 0, -37.5, -50, 0, 1/8, 1
end

8.times do |i|
	tp_chain -100, -100*(-1)**i, 0.5 do
		kick i*12.5, 25*(-1)**i; b 1/2
	end
	angle = PI/2*i
	tp_drop 100*cos(angle), 100*sin(angle), 0.5 do
		flick_chain -25, 25, -75, -25, 1/16, 1/2
	end
end

notes_right = tp_drop -100, 0, 0.5 do
	kick 50, 25; b 1
	kick 50, -25; b 1
end
transform(duplicate notes_right) { horizontal_flip; beat_translate 1/2 }
tp_drop 0, 100, 0.5 do
	8.times do |i|
		kick (75-75*i/8)*(-1)**i, 37.5-75*i/8; b 1/4
	end
end

transform(inter_pattern) { horizontal_flip }

#==========
# Climax
#==========

def hexagon_x x
	x1 = x.abs
	y = x1 < 50/sqrt(3) ? 50 : 50-(x1-50/sqrt(3))*sqrt(3)
	[x, y].tap { define_singleton_method(:-@) { [x, -y] } }
end
def hexagon_y y
	y1 = y.abs
	x = 100/sqrt(3) - y1/sqrt(3)
	[x, y].tap { define_singleton_method(:-@) { [-x, y] } }
end
def hexagon_i i
	r = 100/sqrt(3)
	angle1 = i.floor * PI/3
	angle2 = (i+1).floor * PI/3
	x1, y1 = r*cos(angle1), r*sin(angle1)
	x2, y2 = r*cos(angle2), r*sin(angle2)
	[x1+(x2-x1)*(i%1), y1+(y2-y1)*(i%1)]
end
def rand_bg_note
	group preserve_beat: false do
		b 1
		bg_note -100 + 25*rand(9), -50 + 25*rand(5)
	end
end

group(preserve_beat: false) { b -1; hexagon 8 }
8.times do |i|
	tp_chain 100, 0, 0.5 do
		d *hexagon_i(1-i*2/7); rand_bg_note; b 1/8
	end
end
7.times do |i|
	tp_chain -100*(-1)**i, 0, 0.5 do
		x, y = hexagon_y -50+100*i/7
		t -x*(-1)**i, y; b 1/4
	end
end
tp_drop 100, 0, 0.5 do
	10.times do |i|
		x, y = hexagon_i 1-i*2/9
		i == 0 ? t(x, y) : d(x, y); rand_bg_note; b 1/8
	end
end

tp_drop -100, 0, 0.5 do
	4.times do |i|
		x, y = hexagon_i -2-i*2/3
		t x, y; b 1/8
		d x*3/4, y*3/4; rand_bg_note; b 1/8
		d x/2, y/2; rand_bg_note; b 1/4
	end
end
h 0, 0, 1; b 1
tp_drop 0, 200, 0.5 do
	32.times { d 0, 0; b 1/32 }
end

def tap_chain x1, y1, x2, y2, delta, duration
	n = (duration/delta).to_i
	group do
		n.times do |i|
			x, y = x1 + (x2-x1)*i/n, y1 + (y2-y1)*i/n
			i == 0 ? t(x, y) : d(x, y)
			rand_bg_note
			b delta
		end
	end
end
def arc_chain x, y, r, start_angle, end_angle, delta, duration
	group do
		n = duration / delta
		n.to_i.times do |i|
			angle = start_angle + (end_angle - start_angle) * i/n
			d x + r*cos(angle), y + r*sin(angle)
			rand_bg_note
			b delta
		end
	end
end

tp_drop 0, -100, 0.5 do
	tap_chain 50, 50, -25, 37.5, 1/8, 1/2
	tap_chain -50, 25, 25, 12.5, 1/8, 1/2
	t 75, 0; b 1/4
	t -75, 0; b 1/4
	tap_chain 50, -12.5, -25, -25, 1/8, 1/2
	tap_chain -50, -37.5, 25, -50, 1/8, 1/2
	t 75, -50; b 1/2
end

tp_drop -100, 0, 0.5, preserve_beat: false do
	b 1/2
	tap_chain 0, 0, 0, -50, 1/8, 1/2

	b 1/16
	tp_drop 0, 0, 0.5, relative: false do
		arc_chain 0, 0, 50, -PI/2, PI/2, 1/8, 1
	end
end
tp_drop 100, 0, 0.5 do
	tap_chain 0, 0, 0, 50, 1/8, 1/2
	b 1/2
	turntable 1
	tp_drop 0, 0, 0.5, relative: false do
		arc_chain 0, 0, 50, PI/2, 3*PI/2, 1/8, 1
	end
end
tp_drop 100, 0, 0.5 do
	t 0, -50; b 1/4
	t 0, 50; b 1/4
	t 0, -25; b 1/4
	t 0, 25; b 1/4
	t 0, 0; b 1/2
end
tp_drop 0, 100, 0.5 do
	tap_chain 50, 0, 0, 0, 1/8, 1/2
end
b 1

tp_drop 0, 100, 0.5 do
	tap_chain -25, 25, -75, 0, 1/8, 1/2
	t 12.5, 12.5; b 1/4
	t -12.5, 0; b 1/4
	tap_chain 50, 0, -50, -50, 1/8, 1
	t 0, 0; b 1/2
end
hexagram 3/2
notes = group do
	tp_drop -25, -25*sqrt(3), 0.5 do
		tap_chain 0, 50, 25*sqrt(3), -25, 1/16, 1/2
	end
	tp_drop 0, 50, 0.5 do
		tap_chain 25*sqrt(3), -25, -25*sqrt(3), -25, 1/12, 1/2
	end
	tp_drop 25*sqrt(3), -25, 0.5 do
		tap_chain -25*sqrt(3), -25, 0, 50, 1/24, 1/2
	end
end

tp_drop -100, 0, 0.5 do
	tap_chain -75, 25, -75, -25, 1/8, 1/2
end
tp_drop 0, -100, 0.5 do
	tap_chain -50, 50, 25, 50, 1/12, 1/2
end
tp_drop 100, 0, 0.5 do
	tap_chain -25, 25, -25, -50, 1/6, 1
end
tp_drop 0, 100, 0.5 do
	t 50, 0; b 1/2
	tap_chain -75, 0, 0, 50, 1/16, 1/2
	t 50, 0; b 1/2
	tap_chain -75, 0, 0, -50, 1/16, 1/2
end
tp_drop 0, -100, 0.5 do
	tap_chain 75, 25, 0, 25, 1/8, 1
	t -50, 0; b 1/2
	tap_chain 75, -25, 0, -25, 1/12, 1
end
tp_drop 100, 0, 0.5 do
	t -25, 25; b 1/4
	t -12.5, 12.5; b 1/4
end
tp_drop 0, 100, 0.5 do
	tap_chain -25, 0, 25, -50, 1/8, 1

	tap_chain 37.5, 0, -37.5, 25, 1/16, 1
end
tp_drop -100, 0, 0.5 do
	t -75, 0; b 1/4
	t -62.5, -12.5; b 1/4
	t -75, -25; b 1/2
end
tp_drop 0, -100, 0.5 do
	t -25, 50; b 1/2
end
tp_drop 0, 100, 0.5 do
	tap_chain -37.5, -25, 12.5, 0, 1/8, 1/2
end
b 1

grid 2
tp_drop 0, 100, 0.5 do
	8.times do |i|
		t 37.5, 0; rand_bg_note
		bg_note 37.5+6.25*i, 6.25*i
		bg_note 37.5+6.25*i, -6.25*i
		b 1/8
		(d 25, 0; rand_bg_note) if i >= 4; b 1/8
		t -37.5, 0
		bg_note -37.5-6.25*(i+1/2), 6.25*(i+1/2)
		bg_note -37.5-6.25*(i+1/2), -6.25*(i+1/2)
		b 1/4
	end
end

pentagon 3
3.times do |i|
	tp_drop 0, 100, 0.5 do
		angle = PI/2 - 2*PI/5
		t 50*cos(angle), 50*sin(angle); b 1/2
	end
	tp_drop *[[0, -100], [-100, 0], [0, 100]][i], 0.5 do
		angle = PI/2 + i*2*PI/5
		tap_chain 50*cos(angle), 50*sin(angle), 50*cos(angle+2*PI/5), 50*sin(angle+2*PI/5), 1/16, 1/2
	end
end
tp_drop 0, 100, 0.5 do
	f 50*cos(PI/2 - 2*PI/5), 50*sin(PI/2 - 2*PI/5), :r; b 1
end

def drag_chain x1, y1, x2, y2, delta, duration
	n = (duration/delta).to_i
	group do
		n.times do |i|
			x, y = x1 + (x2-x1)*i/n, y1 + (y2-y1)*i/n
			d(x, y); b delta
		end
	end
end
tp_drop 0, 100, 0.5 do
	5.times do |i|
		x1, y1 = -87.5+25*i, -25*(-1)**i
		x2, y2 = x1+25, -y1
		i == 0 ? tap_chain(x1, y1, x2, y2, 1/8, 1/2) : drag_chain(x1, y1, x2, y2, 1/8, 1/2)
	end
	t 37.5, 25; b 1/2
	tap_chain 37.5, -25, 62.5, 25, 1/8, 1/2
	drag_chain 62.5, 25, 87.5, -25, 1/8, 1/2
end

tp_drop 0, -100, 0.5 do
	tap_chain 100, 37.5, -50, 37.5, 1/16, 1
end
tp_chain 0, 100, 0.5 do
	t -75, 25; b 1/4
end
tp_chain 100, 0, 0.5 do
	t -50, 25; b 1/4
end
tp_chain 0, 100, 0.5 do
	t -50, 0; b 1/4
end
tp_chain 100, 0, 0.5 do
	t -25, 0; b 1/4
end
tp_drop 0, 100, 0.5 do
	t -25, -25; b 3/4
	t 12.5, -25; b 3/4
	t 50, -25; b 1/2
end

tp_drop 0, 100, 0.5 do
	tap_chain -50, 50, 0, 25, 1/8, 1/2
	tap_chain 50, 37.5, 0, 12.5, 1/8, 1/2
	tap_chain -37.5, 25, 12.5, 0, 1/8, 1/2
end
tp_drop -100, 0, 0.5 do
	tap_chain 37.5, 12.5, 87.5, -12.5, 1/32, 1/4
	drag_chain 87.5, -12.5, 37.5, -25, 1/32, 1/4
end
tp_drop 0, -100, 0.5 do
	t -12.5, -12.5; b 1/4
	tap_chain 0, -25, 75, -37.5, 1/8, 3/4
end
tp_drop 100, 0, 0.5 do
	tap_chain -37.5, -37.5, -87.5, -50, 1/16, 1/4
	drag_chain -87.5, -50, -50, -25, 1/16, 1/4
end
tp_drop 0, 100, 0.5 do
	tap_chain -12.5, -25, 25, 25, 1/8, 1/2

	tap_chain -12.5, 12.5, -37.5, 25, 1/8, 3/8; b 1/8
	tap_chain 37.5, 12.5, 62.5, 25, 1/8, 3/8; b 1/8
	tap_chain -37.5, 0, -62.5, 12.5, 1/8, 3/8; b 1/8
	tap_chain 62.5, 0, 87.5, 12.5, 1/8, 3/8; b 1/8
	t -62.5, -12.5; b 1/2
end
tp_drop 0, -100, 0.5 do
	tap_chain 50, -12.5, -25, 25, 1/16, 1/2
	tap_chain -37.5, 50, -75, 25, 1/6, 1/2
	t -12.5, 25; b 1/4
	t -25, 12.5; b 1/4

	tap_chain -12.5, 0, 50, -25, 1/8, 1
end
tp_drop 100, 0, 0.5 do
	tap_chain -50, -12.5, -87.5, -25, 1/24, 1/4
	drag_chain -87.5, -25, -50, -37.5, 1/24, 1/4
end
tp_drop 0, 100, 0.5 do
	tap_chain -25, -37.5, 50, -12.5, 1/8, 1
	tap_chain 25, -12.5, 0, 0, 1/6, 1/2
	tap_chain 50, -37.5, 75, -50, 1/8, 1/2
end
tp_drop 0, -400, 0.5 do
	tap_chain 0, 50, 0, 50, 1/64, 1/2
end

group preserve_beat: false do
	32.times do |i|
		angle = PI/2 + PI*i/8
		x, y = 50*cos(angle), 50*sin(angle)
		tp_chain -y*4, x*4, 0.5 do
			d x*(1-i/32), y*(1-i/32)
		end
		tp_chain y*4, -x*4, 0.5 do
			d x*(1-i/32), y*(1-i/32)
		end
		b 1/8
	end
end
24.times do |i|
	angle = PI/2 + PI*i/6
	x, y = 25*cos(angle), 25*sin(angle)
	tp_chain -y*4, x*4, 0.5 do
		d x*(1-i/24), y*(1-i/24)
	end
	tp_chain y*4, -x*4, 0.5 do
		d x*(1-i/24), y*(1-i/24)
	end
	b 1/6
end

turntable 32
tp_chain -200, 0, 0.5 do
	d 0, 0
end
tp_chain 200, 0, 0.5 do
	h 0, 0, 32
end

end
