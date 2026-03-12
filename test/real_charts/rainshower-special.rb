include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'special' do

title '驟雨の狭間'
artist 'Silentroom'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '?'

offset 1.379
bpm 174

@old_bg_note_method = method :bg_note
def turn_off_bg_note
	def bg_note *; end
end
def turn_on_bg_note
	def bg_note *args
		@old_bg_note_method.call *args
	end
end
# turn_off_bg_note

x_positions = (-11.75..11.75).step(0.5).to_a
y_positions = (-5.75..5.75).step(0.5).to_a
@bg_positions = x_positions.product y_positions
@bg_positions.shuffle!
n = @bg_positions.size
@bg_positions.each_slice n/8 do |slice|
	slice.each_slice(n/32).zip [0, 1/2, 3/4, 1] do |positions, duration|
		positions.each do |x, y|
			bg_note x, y, duration
		end
	end
	b 4
end

group preserve_beat: false do
	n = x_positions.size
	x_indices = (0..4).each_cons(2).map { (n*_1/8).to_i...(n*_2/8).to_i }
	x_indices.map! { |indices| indices.map { [(n/2).to_i-_1, (n/2).to_i+_1] }.flatten }
	8.times do
		x_indices.zip [1/2, 1/4, 1/4, 3] do |indices, delta|
			indices.each do |i|
				x = x_positions[i]
				bg_note x, y_positions.sample
			end
			b delta
		end
	end
end

4.times do |i|
	f 0, 4-i, :u
	t 0, 2-i/2; b 1/2
	d 0, -2; b 1/4
	d 0, -3; b 1/4
	f 0, -4, :d; b 3
end

def e
	1e-3
end
4.times do |i|
	f 0, -i/2+e, :u
	t 0, -i/2; b 1/2
	d 0, -2; b 1/4
	d 0, -3; b 1/4
	f 0, -4, :d; b 3
end

def ornament_chain position, velocity, span_width = 8
	group do
		25.times do |j|
			x, y = position.(j/24)
			vx, vy = velocity.(j/24)
			angle = atan2 vy, vx
			tp_angle = angle+PI/4 + j*PI/2
			tp_chain 32*cos(tp_angle), 32*sin(tp_angle), 1 do
				case j
				when 0
					f x-e*cos(angle), y-e*sin(angle), angle+PI
				when 24
					f x, y, angle
				else
					d x, y
				end
			end
			group preserve_beat: false do
				span_width.times do |k|
					bg_note x+k*cos(angle+PI/2), y+k*sin(angle+PI/2)
					bg_note x+k*cos(angle-PI/2), y+k*sin(angle-PI/2)
					b 1/span_width
				end
			end
			b 1/8
		end
		b 1-1/8
	end
end

f 0, -2+e, :u; t 0, -2; b 1
4.times do |i|
	notes = group do
		tp_chain -8, 0, 1, preserve_beat: false do
			h -8, 0, 3; b 1
			f -4, 4, :u; b 1
			f 4, -4, :d; b 1
		end
		ornament_chain(
			->t { [-8+t*16, -sin(t*2*PI)*(i/2+2)] },
			->t { [16, -2*PI*cos(t*2*PI)*(i/2+2)] }
		)
	end
	transform(notes) { horizontal_flip } if i.even?
end

4.times do |i|
	notes = group do
		tp_chain 0, 8, 1, preserve_beat: false do
			h 0, 4, 3; b 1
			f 8, 2, :r; b 1
			f -8, -2, :l; b 1
		end
		ornament_chain(
			->t { [-sin(t*2*PI)*(i+4), 4-t*8] },
			->t { [-2*PI*cos(t*2*PI)*(i+4), -8] }
		)
	end
	transform(notes) { vertical_flip } if i.even?
end

def anti_flick_chain x, y, three
	tp_drop @second_buildup ? -8 : 8, @second_buildup ? -8 : 8, 1, preserve_beat: false do
		notes = group preserve_beat: false do
			7.times do |i|
				j_max = (3-(i-3).abs)/2
				(-j_max..j_max).step 1 do |j|
					bg_note j, -i
				end
				b 1/8
			end
		end
		transform(notes) { rotate PI/4; translate x, y }
		f x, y, :ul; b 1/4
		d x+1, y-1; b 1/4
		d x+2, y-2 if three
	end
end
def build_up variation
	group do
		8.times do |i|
			notes = group do
				anti_flick_chain -7, 0, i >= 4
				tp_chain -8, 8, 1 do
					t -7+e, -e; b 3/4
				end
				anti_flick_chain -3, 4, i >= 4; b 1/2
				anti_flick_chain -5, 2, i >= 4; b 3/4
			end
			transform(notes) { horizontal_flip } if i.odd?
		end

		14.times do |i|
			angle = 7/8*PI + i*PI/4
			r = 4*(1-i/14)
			(r*14).to_i.times do |j|
				x, y = r*2*cos(angle+j/(r*14)*2*PI), r*2*sin(angle+j/(r*14)*2*PI)
				bg_note x, y
			end
			x, y = r*cos(angle), r*sin(angle)
			tp_drop 8*cos(angle-PI/2), 8*sin(angle-PI/2), 1 do
				case variation
				when :first, :second
					tp_drop 16*cos(angle+PI), 16*sin(angle+PI), 1 do
						f x+e*cos(angle), y+e*sin(angle), angle
					end if i%4 == 0
					t x, y
				when :third
					f x, y, angle
					tp_drop 16*cos(angle+PI), 16*sin(angle+PI), 1 do
						t x-e*cos(angle), y-e*sin(angle)
					end if i%4 == 0
				end
				b 1/4
				d x-cos(angle), y-sin(angle); b 1/4
			end
		end

		16.times do |i|
			@bg_positions[9*i...9*(i+1)].each do |x, y|
				bg_note x, y, 4-i/4
			end
			angle = 3/8*PI - i/16 * PI*3/4 + PI*i
			tp_drop 8*cos(angle-PI/2), 8*sin(angle-PI/2), 1 do
				case variation
				when :first, :second
					tp_drop 16*cos(angle+PI*(i/8).floor), 16*sin(angle+PI*(i/8).floor), 1 do
						f e*cos(angle), e*sin(angle), angle
					end if i%8 == 4
					t 0, 0
				when :third
					f 0, 0, angle
					tp_drop 16*cos(angle+PI*(i/8).floor), 16*sin(angle+PI*(i/8).floor), 1 do
						t -e*cos(angle), -e*sin(angle)
					end if i%8 == 4
				end
				b 1/4
			end
		end

		grid 4
		b 4
	end
end
build_up :first

def neuro_chain duration
	y0 = 33/8
	r0 = y0 + 4
	theta = atan2(7, y0)*duration/(3/4)
	n = (duration*8).to_i
	tp_chain 8*cos(theta), 8*sin(theta), beat_speed: r0*theta/(3/4), preserve_beat: false do
		n.times do |i|
			(0..i).each do |j|
				r = r0*i/n
				angle = i.zero? ? 0 : -PI/2 + theta*j/i
				bg_note r*cos(angle), y0+r*sin(angle)
			end
			angle = -PI/2 + theta*(1-i/n)
			x, y = r0*cos(angle), y0+r0*sin(angle)
			if i.zero?
				tp_chain -8, 0, 1, preserve_beat: false do
					b -1/4; t x-2, y+1
				end
				f x, y, angle+PI/2
				t x-e*cos(angle+PI/2), y-e*sin(angle+PI/2)
			else
				d x, y
			end
			b 1/8
		end
		t 0, -4
	end
end
2.times do |j|
	notes = group do
		4.times do |i|
			tp_chain 0, 8, 1 do
				t 0, -4; b 1
			end
			neuro_chain 3/4; b 2
			transform(neuro_chain [3/4, 1/2, 1/2, 1/2][i]) { horizontal_flip }; b 1

			b 1/4
			tp_chain 0, 8, 1 do
				t 5, 3; b 1/4
				t 7, 2; b 1/2
			end
			neuro_chain 3/4; b 1
			if j == 1 && i == 3
				4.times do |k|
					x, y = -(4+k)*(-1)**k, -3+k*2
					tp_drop 8*(-1)**k, 0, 1 do
						t x, y; b 1/4
						t x, y+1; b 1/4
					end
				end
			else
				b 1
				transform(neuro_chain [3/4, 1/2, 3/4, 1/2][i]) { horizontal_flip }; b 1
			end
		end
	end
	transform(notes) { rotate PI } if j.odd?
end

def neuro_chain2 duration
	n = duration ? (duration*8).to_i : 4
	tp_chain -8, 8, beat_speed: 8*sqrt(2), preserve_beat: false do
		(n+1).times do |i|
			x, y = i, -i+i**2/16
			if i.zero?
				tp_chain 8, 0, 1, preserve_beat: false do
					b -1/4; t 2, 1
				end
				f x-e, y+e, :ul
			elsif i == n
				duration ? t(x, y) : d(x, y)
			else
				d x, y
			end
			bg_note x, y
			bg_note -x, y
			bg_note x, -y
			bg_note -x, -y
			b 1/8
		end
	end
end
group preserve_beat: false do
	b 1
	4.times do
		h 0, 0, 5; b 8
		h 0, 0, 3; b 4
		h 0, 0, 3; b 4
	end
end
2.times do |j|
	notes = group do
		4.times do |i|
			tp_chain 0, 8, 1 do
				t 0, -4; b 1
			end
			neuro_chain2 3/4; b 2
			transform(neuro_chain2 [3/4, 1/2, 1/2, 1/2][i]) { horizontal_flip }; b 1

			b 1/4
			tp_chain 0, 8, 1 do
				t 2, 3; b 1/4
				t 0, 2; b 1/2
			end
			neuro_chain2 3/4; b 2
			transform(neuro_chain2 [3/4, 1/2, 3/4, [1/2, nil][j]][i]) { horizontal_flip }; b 1
		end
	end
	transform(notes) { rotate PI } if j.odd?
end

def bass_verse1 second = false, length = 12
	if length == 15
		length = 7
		has_second_hold = true
	end
	tp_drop 0, 8, 1, preserve_beat: false do
		diamond_grid length
		h 0, -4, length; b 1
		13.times do
			h 0, -4, 1/4; b 1/2
		end
		if has_second_hold
			b 1/2
			diamond_grid 7
			h 4, -4, 7; b 4
			h -4, -4, 3
		end
	end

	4.times do |i|
		tp_chain 8*(-1)**i, 8, 1 do
			b 1
			f e*(-1)**i, -4, PI*i if second; b 1
		end
	end

	tp_drop -8, 0, 1 do
		t -6, 3; b 1
		tp_drop(8, 0, 1) { f -2+e, 2, :r }; t -2, 2; b 3/4
		t -5, 1; b 1/2
		t -6, -1; b 3/4
		tp_drop(8, 0, 1) { f -2+e, -2, :r }; t -2, -2; b 3/4
	end
	tp_drop 8, 0, 1 do
		t 5, 4; b 1/4

		t 6, 3; b 1
		tp_drop(-8, 0, 1) { f 2-e, 2, :l }; t 2, 2; b 3/4
		t 7, 1; b 1/2
		t 5, 0; b 1/2
		t 3, -1; b 1/4
		tp_drop(-8, 0, 1) { f 2-e, -2, :l }; t 2, -2; b 1
	end
end

def bass_verse2 second = false
	tp_drop 0, 8, 1, preserve_beat: false do
		diamond_grid 7
		h 0, -4, 7; b 1
		13.times do
			h 0, -4, 1/4; b 1/2
		end
		b 1/2
		diamond_grid 7
		h -4, -4, 7; b 1/2
		7.times do
			h 0, -4, 1/4; b 1/2
		end
		h 4, -4, 3
	end

	6.times do |i|
		tp_chain 8*(-1)**i, 8, 1 do
			b 1
			f -e*(-1)**i, -4, PI*(i+1) if second; b 1
		end
	end

	tp_drop -8, 0, 1 do
		b 1
		tp_drop(8, 0, 1) { f 2+e, 2, :r }; t 2, 2; b 3/4
		t -2, 1; b 1/2
		t 2, 0; b 1/2
		t -1, -1; b 1/4
		tp_drop(8, 0, 1) { f -2-e, -2, :l }; t -2, -2; b 1
	end
end
notes = group do
	bass_verse1
	bass_verse2
end
transform(notes) { horizontal_flip }

tp_drop 0, 8, 1 do
	t 0, -4; b 1
end
@second_buildup = true
transform(build_up :second) { rotate PI }

b -4
positions = (-7..7).step(2).to_a.product((-3..3).step(2).to_a)
positions.shuffle!
positions.each_with_index do |(x, y), i|
	bg_note x, y; b 1/8
end

def sobol_sequence m, primitive
	s = primitive.size
	d = m.size
	(0..).each do |i|
		while (i >> d) > 0
			m.push 0
			s.times { |j| m[d] ^= primitive[j]*m[d-j] << j%(s-1) }
			d += 1
		end
		result = 0
		d.times { |j| result ^= m[j] << d-j if (i>>j)&1 > 0 }
		yield result / (1<<d+1)
	end
end
qrng = to_enum :sobol_sequence, [1, 3, 5], [1, 1, 1, 1]

def raindrop x, y, dx
	dy = 16
	b -1/2
	9.times do |i|
		bg_note x + dx*2/3*(1-i/8), y + dy*2/3*(1-i/8)
		b 1/4
	end
	b -3/2-1/4
	tp_chain dx, dy, relative_beat: 3 do
		t x, y
	end
end
last_two_xs = []
256.times do |i|
	begin
		x = qrng.next*15-8
	end while last_two_xs.size == 2 && (x - last_two_xs[1])*(last_two_xs[0]-last_two_xs[1]) <= 0
	last_two_xs.push x
	last_two_xs.shift if last_two_xs.size > 2
	y = -3.75+0.25*sin(i)
	tp_drop(3, 16, 1) { t x, y } if i%8 == 4 && i < 248
	raindrop x, y, 3+0.5*cos(E*i); b 1/4
end
last_two_xs.reverse!
256.times do |i|
	if i>=248 && i%2==1
		x = last_two_xs[1]
	else
		begin
			x = qrng.next*15-7
		end while last_two_xs.size == 2 && (x - last_two_xs[1])*(last_two_xs[0]-last_two_xs[1]) <= 0
		last_two_xs.push x
		last_two_xs.shift if last_two_xs.size > 2
	end
	y = -3.75+0.25*sin(i)
	tp_drop(-3, 16, 1) { t x, y } if i%8 == 4 && i < 248
	raindrop x, y, -3+0.5*cos(E*i); b 1/4
end

group preserve_beat: false do
	b 2
	d 5, 3; b 6

	b 8

	b 1
	d -3, 3; b 5/2
	d -1, 0; b 1/4
	d 0, 1; b 5/4
	d 2, 4; b 1/3
	d 3, 3; b 1/3
	d 4, 2; b 2/3
	d 5, 0; b 2/3
	d 3, -1; b 2/3
	d 0, 0; b 1/3

	b 2/3
	d -2, 0; b 1/3+7

	b 1/2
	d 1, 0; b 3/4
	d -1, 1; b 1
	d -3, 2; b 3/4
	d -5, 3; b 5

	b 1/2
	d 2, -3; b 3/4
	d 0, -2; b 3/4
	d -2, -1; b 1
	d -4, 0; b 5

	b 1/2
	d -5, -3; b 1/2
	d -3, -2; b 1/2
	d -1, -1; b 1/2
	d 1, 0; b 1/2
	d 2, 2; b 1/2
	d 1, 4; b 3-1/4
	d -2, 3; b 1/4
	d -3, 2; b 2/3
	d -1, 0; b 1/3
	d 1, -1; b 1

	b 5/2
	d 4, 2; b 11/2
end

def multi_hold x, y, angles
	group preserve_beat: false do
		angles.each do |angle|
			tp_drop 8*cos(angle), 8*sin(angle), 2 do
				h x, y, 8
			end
		end
		angle0 = 2*PI*rand
		angles.size.times do |j|
			group preserve_beat: false do
				(0..).each do |i|
					r = i/4
					angle = 5*log(1+i) + angle0 + 2*PI*j/(angles.size)
					x1, y1 = x+r*cos(angle), y+r*sin(angle)
					break if i >= 32 && (x1.abs > 11 || y1.abs > 7)
					bg_note x+r*cos(angle), y+r*sin(angle)
					b 1/4
				end
			end
		end
	end
end
multi_hold 8, 2, [PI]; b 8
multi_hold -6, 0, [PI/4, 5*PI/8, -PI/3]; b 8
multi_hold 4, -4, [3*PI/8, 2*PI/3]; b 8
multi_hold -8, -3, [PI/3]; b 8
multi_hold 3, 3, [-3*PI/4, 7*PI/8]; b 8
multi_hold -7, 1, [PI/6, 3*PI/4, -3*PI/8]; b 8
multi_hold 5, -1, [PI/2, 3*PI/4]; b 8
multi_hold -4, 4, [-PI/4]; b 8

t 0, 0; b 1
4.times do |i|
	notes = group do
		tp_chain -8, 0, 1, preserve_beat: false do
			h -8, 2, 3; h -8, -2, 3; b 1
			f -4, -4, :d; b 1
			f 4, 4, :u; b 1
		end
		group preserve_beat: false do
			ornament_chain(
				->t { [-8+t*16, 2+(1+4*t)*sin(t*2*PI)] },
				->t { [16, 4*sin(t*2*PI)+2*PI*(1+4*t)*cos(t*2*PI)] },
				4
			)
		end
		ornament_chain(
			->t { [-8+t*16, -2+(5-4*t)*sin(t*2*PI)] },
			->t { [16, -4*sin(t*2*PI)+2*PI*(5-4*t)*cos(t*2*PI)] },
			4
		)
	end
	transform(notes) { horizontal_flip } if i.even?
end

4.times do |i|
	notes = group do
		tp_chain 0, 8, 1, preserve_beat: false do
			h (i+4)/2, 4, 3; h -(i+4)/2, 4, 3; b 1
			f -8, 2, :l; b 1
			f 8, -2, :r; b 1
		end
		group preserve_beat: false do
			ornament_chain(
				->t { [(2+(1+4*t)*sin(t*2*PI))*(1+i/4), 4-t*8] },
				->t { [(4*sin(t*2*PI)+2*PI*(1+4*t)*cos(t*2*PI))*(1+i/4), -8] },
				4
			)
		end
		ornament_chain(
			->t { [(-2+(5-4*t)*sin(t*2*PI))*(1+i/4), 4-t*8] },
			->t { [(-4*sin(t*2*PI)+2*PI*(5-4*t)*cos(t*2*PI))*(1+i/4), -8] },
			4
		)
	end
	transform(notes) { vertical_flip } if i.even?
end

@second_buildup = false
transform(build_up :third) { horizontal_flip }

bass_verse1 true, 15
notes = group do
	bass_verse1 true
	bass_verse2 true
end
transform(notes) { horizontal_flip }
bass_verse1 true, 16

all_notes = @events.filter { %i[tap hold drag flick].include? _1.type }
all_notes.sort_by! &:beat
all_notes.each_with_index do |note, i|
	next unless note.type == :flick
	simultaneous_notes = []
	while i > 0 && all_notes[i-1].beat == note.beat
		i -= 1
	end
	while i < all_notes.size && all_notes[i].beat == note.beat
		simultaneous_notes.push all_notes[i] if all_notes[i] != note && hypot(all_notes[i][:x]-note[:x], all_notes[i][:y]-note[:y]) < 10*e
		i += 1
	end
	next if simultaneous_notes.empty?
	if simultaneous_notes.size > 1
		puts "===== More than one notes coincide with a flick ====="
		puts "at time #{note.time}"
		puts 'defined at:'
		puts note.backtrace
		next
	end
	simultaneous_note = simultaneous_notes.first
	distance = hypot(simultaneous_note[:x]-note[:x], simultaneous_note[:y]-note[:y])
	angle = atan2(note[:y]-simultaneous_note[:y], note[:x]-simultaneous_note[:x])
	if distance < e/2 || (angle % (2*PI) - note[:angle] % (2*PI)).abs > e
		puts "===== A flick is not properly offset ====="
		puts "at time #{note.time}"
		puts 'defined at:'
		puts note.backtrace
	end
end

transform @events do
	scale 12.5
end

end
