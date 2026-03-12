include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'master' do

title '忘れてやらない'
artist '結束バンド'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'
difficulty_sup '+'

offset 0.324
bpm 184

tp_drop 0, 100, 1 do
	8.times { t -50, -37.5; b 1 }

	6.times { t 75, -25; b 1 }
end
b 1/2
tp_chain 100, -100, 1 do
	h -75, -25, 1; b 3/2
end

def pattern
	tp_chain 0, 100, 1 do
		t 75, 25; b 1/2
		d 62.5, 0; b 1/2
		tp_chain -100, 0, 1 do
			t 25, 0
		end
		d 75, -25; b 1/2
		d 62.5, -50; b 1/2
	end
end
pattern
transform pattern do
	horizontal_flip
	translate -12.5, 0
end

transform pattern do
	translate -25, 0
end
tp_chain 0, 100, 1 do
	t -12.5, 37.5; b 1/2
	d -37.5, 25; b 1/2
	tp_chain -100, 0, 1 do
		t 0, -37.5
	end
	d -62.5, 37.5; b 1/2
	d -87.5, 25; b 1/2
end

transform pattern do
	translate 12.5, 0
end
transform pattern do
	horizontal_flip
	translate 25, 0
end

tp_chain 0, 100, 1 do
	t 50, 25; b 1/2
	4.times do |i|
		x = 25 + i*25
		y = -25 + i*12.5
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
tp_chain -100, 0, 1 do
	h -25, 50, 3/2; b 5/2
end

tp_chain -100, 0, 1 do
	4.times do |i|
		x = -37.5 + i*37.5
		y = 25 - i*12.5
		t x, y; b 1/2
		i == 3 ? t(x+25, y+12.5) : tp_drop(0, 100, 1) { t -50, -50 }
		b 1/2
	end
end

tp_chain 100, 0, 1 do
	2.times do |i|
		x = 12.5 - i*37.5
		y = 25 - i*12.5
		t x, y; b 1/2
		i == 3 ? t(x+25, y+12.5) : tp_drop(0, 100, 1) { t 50, -50 }
		b 1/2
	end
	t -62.5, 25; b 1/2
	t -75, 0; b 1/2
	t -62.5, -25; b 1/2
	t -87.5, -37.5; b 1/2
end

tp_chain -100, 0, 1 do
	4.times do |i|
		x = -37.5 + i*37.5
		y = 25 - i*12.5
		t x, y; b 1/2
		i == 3 ? t(x+25, y+12.5) : tp_drop(0, 100, 1) { t -50, -50 }
		b 1/2
	end
end

tp_chain 100, 0, 1 do
	t -12.5, 50; b 1/2
	t -37.5, 37.5; b 1
	t 0, 12.5; b 1
	t 37.5, 0; b 1/2
	d 62.5, -12.5; b 1/2
end
tp_chain 0, 100, 1 do
	t -25, -50; b 1/2
end

tp_chain -100, 100, 1 do
	f -62.5, -37.5, :l; b 1
end
tp_chain 100, 0, 1, preserve_beat: false do
	b 1/2
	t -62.5, 0; b 1
	t -87.5, 12.5; b 3/2
	mark :m
end
tp_chain -100, 0, 1 do
	t 12.5, 25; b 1
	t 50, 12.5; b 1
	t 87.5, 0; b 1/2
	h 100, 25, 1; b 1/2

	b 5/2
	t 50, -25; b 1/2
	t 25, 0; b 1/2
	t 0, 25; b 1/2
end
at :m, preserve_beat: true do
	b 1/2
	t 0, 0; b 1/2
	t -25, -12.5; b 1/2
	t -50, -25; b 1
end
tp_drop 0, 100, 1 do
	t -75, -50; b 1/2
	t -100, -37.5; b 1
end

tp_chain 100, 0, 1, preserve_beat: false do
	t -25, 12.5; b 1/2
	t -50, 25; b 1/2
	t -75, 12.5; b 1/2
	t -87.5, -12.5; b 1
	t 0, -25; b 1
	t -37.5, 12.5; b 1/2
	mark :m
end
tp_drop 0, 100, 1 do
	f 75, 25, :dl; b 1/2
	d 50, 0; b 1/4
	d 37.5, -12.5; b 1/4
	d 25, -25; b 1/2
	f 75, -25, :r; b 1
	f -50, -25, :l; b 1
	f 50, 25, :r; b 1/2
end

at :m do
	b 1/2
	t 25, -25; b 1/2
	t 50, 0; b 1/2
	t 75, 25; b 1/2
end
tp_drop 0, 100, 1 do
	b 3/2
	f -75, 25, :l; b 1
end
tp_chain 0, 100, 1 do
	6.times do |i|
		x = 12.5*(-1)**i
		y = 25 - i*12.5
		t x, y; b 1/4
	end

	t 12.5, -50; b 1/2
end
tp_chain -100, 0, 1 do
	t -100, 25, ?ぜ; b 1/2
	t -75, 25, ?ん; b 1/2
	t -50, 25, ?ぶ; b 1/2
	t -25, 25, ?天; b 1
end
tp_chain 100, 0, 1 do
	t 75, 0, ?気; b 1/2
	t 50, 0, ?の; b 1/2

	tp_chain 0, 100, 1, preserve_beat: false do
		t -25, -25; b 1
		t -50, 25; b 1
		t -37.5, -12.5; b 1
		t -62.5, 37.5; b 1
	end
	t 25, 0, 'せい'; b 1
	t 50, 25, ?で; b 1
	t 37.5, -37.5, 'いい'; b 1
	t 25, 12.5, ?よ; b 1
end

tp_chain 100, 0, 1 do
	b 1/2
	%W[こ の 気 ま ず さ も].each_with_index do |text, i|
		t 100-25*i, 37.5, text; b 1/2
	end

	tp_chain 0, 100, 1, preserve_beat: false do
		t 50, -25; b 1
		t 75, 25; b 1
		t 62.5, -37.5; b 1
		t 37.5, 25; b 1
	end
	t -75, 37.5, ?倦; b 1
	t -50, -25, ?怠; b 1
	t -62.5, 50, ?感; b 1
	t -87.5, -25, ?も; b 1
end

b 1/2
tp_chain -100, 0, 1 do
	t -50, 25, ?太; b 1/2
	t -25, 25, ''; b 1/2
	4.times do |i|
		(i>=2 ? -(i+2)..(i+2) : -(i+1)..(i+1)).each do |j|
			group preserve_beat: false do
				b rand(8)/16
				bg_note j*12.5, 50-i*12.5, 3/2+rand(8)/16
			end
		end
	end
	h 0, 25, 3/2, ?陽; b 1
end
tp_chain 100, 0, 1 do
	t 100, -25, ?は; b 1/2
	t 75, -25, ?隠; b 1/2
	t 50, -25, ''; b 1/2

	tp_chain 0, 100, 1, preserve_beat: false do
		t -75, 25; b 1
		t -62.5, -25; b 1
		t -50, 37.5; b 1
		t -75, -12.5; b 1
	end
	t 25, -25, ?れ; b 1
	t 50, 25, ?な; b 1
	t 75, -12.5, ?が; b 1
	t 62.5, 37.5, ?ら; b 1
end

tp_chain -100, 0, 1 do
	%W[知 ら ん ぷ].each_with_index do |text, i|
		t -100+25*i, 25, text; b 1/2
	end
	h 0, 25, 3/2, ?り
end
tp_chain 0, 100, 1 do
	t 50, 37.5; b 1/2
	t 37.5, 12.5; b 1/2
end
tp_drop 0, 100, 1 do
	t 25, -12.5; b 1
	mark :m
end

at :m do
	b 1
	t -37.5, -12.5; t 12.5, -12.5; b 2
	t -12.5, -12.5; t 37.5, -12.5; b 1
end
tp_chain 0, 100, 1 do
	t -62.5, 37.5; b 1/2
	t -50, 12.5; b 1
	t -50, -37.5; b 1
end
tp_chain 0, 100, 1 do
	t 50, 12.5; b 1
	t 50, -37.5; b 1/2
end

tp_chain -100, 0, 1 do
	b 1/2
	%W[ガ タ ゴ ト 揺 れ る _].each_with_index do |text, i|
		x = -75+25*i
		y = 50
		l = 16-(i+1)/2
		bg_note x-25, y, l; bg_note x-12.5, y, l
		if text == ?_
			bg_note x, y, l
		else
			t x, y, text; b 1/2
		end
	end

	tp_chain 100, 0, 1, preserve_beat: false do
		4.times do |i|
			t 100-50*i, -25; b 1
		end
	end
	%W[満 員 電 車].each_with_index do |text, i|
		x = 100 - 50*i
		l = 16-(i+4)
		(-2..2).each do |j|
			bg_note x, j*12.5, l
		end
		t x, 25, text; b 1
	end
end

tp_chain 100, 0, 1 do
	b 1/2
	%W[す れ 違 \s う の は _].each_with_index do |text, i|
		x = 75-25*i
		y = -50
		l = 8-(i+1)/2
		bg_note x+25, y, l; bg_note x+12.5, y, l
		if text == ?_
			bg_note x, y, l
		else
			t x, y, text; b 1/2
		end
	end

	tp_chain -100, 0, 1, preserve_beat: false do
		4.times do |i|
			t -100+50*i, 25; b 1
		end
	end
	(-2..2).each do |j|
		bg_note -100, j*12.5, 4
	end
	%W[準 急 列 車].each_with_index do |text, i|
		x = -100 + 50*i
		l = 8-(i+4)
		(1..3).each do |j|
			bg_note x+j*12.5, 25, l
			bg_note x+j*12.5, -25, l
		end
		t x, -25, text; b 1
	end
end

tp_chain 0, 100, 1 do
	b 1/2
	t 0, 50, ?輪; b 1/2
	mark -1
end
tp_chain 0, 100, 1 do
	mark 1
end
3.times.each_with_object %W[\s 郭 \s の な い] do |i, texts|
	n = 2+i*3
	(-n..n).each do |j|
		start_beat = i+(j+n)/(4*n)
		end_beat = 7-j.abs/n
		x = j*12.5
		y = 37.5-i*25
		if j.abs == n
			at(j <=> 0) { b start_beat; t x, y, texts.shift }
		elsif rand < 0.7
			group(preserve_beat: false) { b start_beat; bg_note x, y, end_beat-start_beat }
		end
		group(preserve_beat: false) { b start_beat; bg_note x, y-12.5, end_beat-start_beat } if rand<0.7
	end
end
b 3

tp_drop 0, 100, 1 do
	%W[雲 \s の 表].each_with_index do |text, i|
		x = 25+i*25
		y = -37.5
		t x, y; t -x, y, text; b 1
	end
end

tp_chain 0, -100, 1 do
	t -75, 25, ?情; b 1
	h -50, 0, 1, ?を; b 2
end
tp_drop 0, 100, 1, preserve_beat: false do
	f 50, 0, :r; b 1/2
	t -37.5, -25; b 1/2
end
bg_note 0, 50, ?探; b 1

tp_chain 0, 100, 1, preserve_beat: false do
	8.times do |i|
		x = i<4 ? -50-6.25*i : -100+6.25*i
		y = -50+12.5*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
tp_drop 100, 0, 1, preserve_beat: false do
	t 62.5, 50; b 1/2
	t 75, 25; b 1/2
	t 87.5, 0; b 1/2
	t 75, -25; b 1/2
end
bg_note 0, 25, ?し; b 1/2
bg_note 0, 0, ?て; b 1/2
bg_note 0, -25, ?み; b 1
tp_chain 0, -100, 1, preserve_beat: false do
	6.times do |i|
		x = 62.5-6.25*i
		y = -50+12.5*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
bg_note 0, -50, ?る
tp_drop -100, 0, 1 do
	t -50, 50; b 1/2
	t -87.5, 12.5; b 1/2
	t -75, -25; b 1/2
	f -37.5, -37.5, :l
end
tp_chain 100, 0, 1 do
	h 25, 25, 2; b 1/2
end

group preserve_beat: false do
	bg_note -100, -43.75, 8-1/2, ?「
	bg_note 100, -43.75, 8-1/2, ?」; b 1/2
	%W[作 \s 者 の 気 持 ち].each_with_index do |text, i|
		bg_note -75+25*i, -37.5, text; b 1/2
	end
end
tp_drop 0, 100, 1 do
	b 1/2
	t -75, 25; b 1/2
end
tp_chain 0, 100, 1 do
	t -75, 25; b 1
	h -37.5, 25, 1
end
tp_drop 100, 0, 1 do
	t 62.5, -25; b 1/2
	t 87.5, 0; b 1
	h 75, 37.5, 2
end
tp_drop 0, 100, 1 do
	f -25, -25, :l; b 1/2
end

group preserve_beat: false do
	b 1/2
	%W[を 答 \s え な さい].each_with_index do |text, i|
		bg_note -62.5+25*i, -50, text; b 1/2
	end
end
tp_drop 0, 100, 1 do
	b 1/2
	t -75, 25; b 1/2
end
tp_chain 0, 100, 1 do
	t -75, 25; b 1
	tp_chain 0, 100, 1, preserve_beat: false do
		t 12.5, 25; b 1/2
		t 12.5, 0; b 1/2
		4.times do |i|
			x = 12.5 + i*12.5
			y = -25 + i*12.5
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
	end
	b 1/4
	t -12.5, 12.5; b 1/2
	t -12.5, -12.5; b 1/4
	b 1
end

tp_chain 0, -100, 1, preserve_beat: false do
	h 62.5, 25, 2; b 2
	5.times do |i|
		angle = PI/2 - PI/4*i
		x = 62.5+12.5*cos(angle)
		y = 12.5+12.5*sin(angle)
		d x, y; b 1/4
	end
end
tp_chain -100, 0, 1 do
	b 1/2
	t -100, 25, ?い; b 1/2
	t -75, 25; b 1/2
	t -50, 25, 'った'; b 1/2
	t -25, 25, ?い; b 1/2
end
tp_chain 100, 0, 1 do
	t -37.5, 0, ?な; b 1/2
	t -62.5, 0, ?に; b 1/2
	t -87.5, 0, ?が; b 1/2
end

big_text 3, ??
tp_drop 0, 100, 1, preserve_beat: false do
	f 75, -25, :ul; b 1
	f -75, -25, :ur; b 1
	f 75, -25, :ul; b 1
end
t -18.5, 33.4, ?正; b 1
t 20.8, 37.5, ?解; b 1
t -0.7, 6.0, 'なん'; b 1
t -10.0, -33.3, 'だい'
tp_chain 0, 100, 1 do
	4.times do |i|
		x = -75+i*12.5
		y = -25+i*12.5
		i.zero? ? f(-75, -25, :ur) : d(x, y); b 1/4
	end

	f -25, 25, :l; b 1
end
tp_drop 0, 100, 1, preserve_beat: false do
	3.times do |i|
		t 87.5*(-1)**i, -37.5; b 2
		next if i == 2
		t 87.5*(-1)**i, -37.5; b 1
		t -62.5*(-1)**i, 25; b 1
	end
end
b 1
tp_chain 100, 0, 1 do
	t -50, 37.5, ?予; b 1
	t -12.5, 25, ?定; b 1

	b 1
	t 50, -12.5, ?調; b 1
	t 12.5, -37.5, ?和; b 1
	t 0, 25, ?の; b 1

	h -50, 12.5, 1/2, ?シ; b 3/2
	t -75, -12.5, ?ナ; b 1/2
	t -50, -25, ?リ; b 1
	t 0, 0, ?オ
end
tp_chain 0, 100, 1 do
	t 87.5, -37.5; b 1/2
	t 62.5, -50; b 1/2

	group preserve_beat: false do
		%W[踏 み 抜 い て].each_with_index do |text, i|
			bg_note -50+25*i, 50, text; b 1/2
		end
	end
	tp_drop 0, 100, 1 do
		f -87.5, 0, :l; b 1/2
	end
	t 50, 0; b 1/2
	t -12.5, 25; b 1/4
	t 12.5, 12.5; b 1/4
	t -12.5, 0; b 1/4
	t 12.5, -12.5; b 1/4
	t -12.5, -25; b 1/2
	t -50, 0; b 3/2
end

def pattern text1, text2
	group do
		tp_chain 100, 0, 1, preserve_beat: false do
			13.times do |i|
				u = (i-6)/3
				x = u**2*37.5 - 100
				y = (-sin(u)-sin(3*u)/3)*37.5 - 12.5
				case i
				when 0 then h x, y, 2, text1
				when 12 then t x, y
				else d(x, y)
				end
				b 1/4
			end
		end
		b 2
		tp_chain 100, 0, 1, preserve_beat: false do
			13.times do |i|
				u = (i-6)/3
				x = u**2*37.5 - 75
				y = (-sin(u)-sin(2*u)/3)*30 + 12.5
				mark :m
				case i
				when 0 then h x, y, 1, text2
				when 12 then t x, y
				else d(x, y)
				end
				b 1/4
			end
		end
		b 2
	end
end
def chorus_start texts
	group do
		group preserve_beat: false do
			b 1
			t -75, (-sin(2)-sin(4)/3)*30 + 12.5
		end
		pattern texts[0], texts[1]
		notes = transform(pattern texts[2], texts[3]) { horizontal_flip }
		remove notes.last

		tp_chain -100, 0, 1, preserve_beat: false do
			6.times do |i|
				u = (i-3)/1.5
				x = (-u**2-2*u)*15 + 80
				y = (-u**2/3+2*u)*10 + 10
				i.zero? ? h(x, y, 1, texts[4]) : d(x, y); b 1/4
			end
		end
		b 1
		at :m do
			6.times do |i|
				u = (3-i)/1.5
				x = (u**2/3-3*u)*5 - (4/3-6)*5 - 75
				y = (2*u**2-2*u)*9 - (8-4)*9 + (-sin(2)-sin(4)/3)*30 + 12.5
				i.zero? ? h(x, y, 1, texts[5]) : d(x, y); b 1/4
			end
		end
		b 1
		tp_chain 100, 0, 1, preserve_beat: false do
			6.times do |i|
				u = i/6
				x = -u*125 + 25
				y = u**3/4*100 - 37.5
				i.zero? ? h(x, y, 1, texts[6]) : d(x, y); b 1/4
			end
		end
		b 1
		tp_chain -100, 0, 1, preserve_beat: false do
			8.times do |i|
				u = PI - i/8*3*PI/2
				x = (u+2)*cos(u)*15 + 35
				y = (u+2)*sin(2*u/(1+u**2))*15
				i.zero? ? h(x, y, 1, texts[7]) : d(x, y); b 1/4
			end
		end
		b 1

		tp_chain -100, 0, 1, preserve_beat: false do
			12.times do |i|
				u = (i-6)/6
				x = (2*u**3+u**2/2)*50 - 10
				y = (-sin(2*u)-u**2/3)*40
				i.zero? ? h(x, y, 2, texts[8]) : d(x, y); b 1/4
			end
		end
		b 2
		tp_chain 0, 100, 1 do
			4.times do |i|
				u = (i+2)/6
				x = (2*(1/3)**3+(1/3)**2/2)*50 - (2*u**3+u**2/2)*50 - 10
				y = (-sin(2*u)-u**2/3)*40
				i.zero? ? h(x, y, 1/2, texts[9]) : d(x, y); b 1/4
			end
		end
		b 1
		end
end
chorus_start %W[青 \s い 春 \s な ん て もん は]
transform(chorus_start %W[僕 \s に は 似 合 わ な いん だ]) { horizontal_flip }

group preserve_beat: false do
	4.times do |i|
		2.times do
			tp_chain 0, (-1)**i*100, 1 do
				t (-1)**(i/2).floor*75, -(-1)**i*50; b 1
			end
			tp_chain -(-1)**(i/2).floor*100, 0, 1 do
				f (-1)**(i/2).floor*100, 0, %i[r l][(i/2).floor]; b 1
			end
		end
	end
end
tp_chain 0, 100, 1 do
	t -75, 25, ?そ; b 1
	t -37.5, 12.5, ?れ; b 1/2
	t -12.5, 12.5, ?で; b 1
	t 25, 37.5, ?も; b 1
	t 12.5, -12.5, ?知; b 1/2

	b 1/2
	t -37.5, -37.5, 'って'; b 1/2
	t -62.5, -50, ?る; b 1/2
	t -87.5, -37.5, ?か; b 1/2
	t -100, -12.5, ?ら; b 2
end

tp_chain 0, 100, 1 do
	t 50, 25, ?一; b 1
	t 12.5, 12.5, ?\s; b 1/2
	t -12.5, 12.5, ?度; b 1
	t 25, 37.5, ?し; b 1/2
	t 50, 50, ?か; b 1/2
	t 75, 37.5, 'ない'; b 1/2

	b 1/2
	t 62.5, -12.5, ?瞬; b 1/2
	t 37.5, -25, ?\s; b 1/2
	t 12.5, -12.5, ?間; b 1/2
	t 0, 12.5, ?\s; b 1
	t -25, -25, ?は; b 1
end

tp_chain -100, 0, 1, preserve_beat: false do
	13.times do |i|
		u = (6-i)/4
		x = (u**2+u/3)*50 - 40
		y = (u**3-3/2*u)*30
		case i
		when 0 then h x, y, 2, ?儚
		when 12 then t x, y
		else d x, y
		end
		b 1/4
	end
end
b 1
tp_chain -100, 0, 1 do
	t 0, 37.5; b 1
end
tp_chain -100, 0, 1, preserve_beat: false do
	13.times do |i|
		u = (i-8)/5
		x = (u**2+u**3/2)*130 - 50
		y = (u**3-u**2/2-2*u)*25+20
		case i
		when 0 then h x, y, 2
		when 12 then t x, y
		else d x, y
		end
		b 1/4
	end
end
b 2

tp_chain 100, 0, 1, preserve_beat: false do
	25.times do |i|
		u = (i+2)/5
		x = (-cos(u)-cos(2*u)-sin(u)-sin(2*u))*35
		y = (+cos(u)+cos(2*u)-sin(u)-sin(2*u))*25+5
		case i
		when 0 then h x, y, 2, ?\s
		when 12 then h x, y, 5/2, ?を
		when 24 then t x, y
		else d x, y
		end
		b 1/4
	end
end
b 2
tp_chain 100, 0, 1 do
	4.times do |i|
		u = (i-4)/2
		x = u*40 + (-cos(14/5)-cos(28/5)-sin(14/5)-sin(28/5))*35
		y = (-u**2-2*u)*25 + (cos(14/5)+cos(28/5)-sin(14/5)-sin(28/5))*25+5
		i.zero? ? h(x, y, 1, ?さ) : d(x, y); b 1/4
	end
end
b 1

def parabola x0, y0, text, flip = false
	tp_chain 100, 0, 1, preserve_beat: false do
		5.times do |i|
			x = ((i-2)**2/4-1)*(flip ? -25 : 25) + x0
			y = y0 - i*12.5
			i.zero? ? h(x, y, 1, text) : d(x, y); b 1/4
		end
	end
end
tp_chain 0, 100, 1 do
	t -50, 50; b 1/2
	t -75, 25; b 1/2
	f -50, 0, :ur; b 1
	t 12.5, -12.5; b 1/2
	t -25, 0; b 1/2
	parabola -50, 12.5, ?孕
	t 12.5, 50; b 1/2
	t 50, 25; b 1/4
	d 62.5, 12.5; b 1/4
end

parabola 75, 0, ?\s, true; b 1/2
tp_chain 0, 100, 1 do
	t -25, 37.5; b 1/2
end
parabola -75, 25, ?ん; b 1/2
tp_chain 0, 100, 1 do
	t 37.5, -25; b 1/2
end
parabola 50, 12.5, ?で, true; b 1/2
tp_chain 0, 100, 1 do
	t -50, 50; b 1/2
end
parabola -25, 37.5, ?る; b 1/2
tp_chain 0, 100, 1 do
	t 62.5, 25; b 1/4
	d 75, 12.5; b 1/4
end

tp_drop 0, 100, 1, preserve_beat: false do
	8.times { t 87.5, 0; b 1 }
	7.times { t -87.5, 0 unless _1 == 3; b 1 }
end
tp_chain 0, 100, 1 do
	b 1/2
	t -25, -25, ?絶; b 1/2
	t -50, -25, ?\s; b 1/2
	t -75, -25, ?対; b 1/2
	t -75, 0, ?\s; b 1/2
	t -75, 25, ?忘; b 1/2
	t -50, 25, ?\s; b 1/2
	t -25, 25, ?れ; b 1/2

	b 1/2
	t -25, -25, ?て; b 1/2
	t -50, -25, ?や; b 1/2
	t -75, -25, ?ら; b 1/2
	t -75, 0, ?な; b 1/2
	t -50, 0, ?い; b 1/2
	t -25, 0, ?よ; b 1

	b 1/2
	t 25, 0, ?い; b 1/2
	t 25, -25, ?つ; b 1/2
	t 50, -25, ?か; b 1/2
	t 75, -25, ?死; b 1/2
	t 75, 0, ?ぬ; b 1/2
	t 75, 25, ?ま; b 1/2
	t 50, 25, ?で; b 1/2

	t 25, 25, ?何; b 1
	f 25, -25, :r, ?回; b 1
	t 75, -25, ?だ; b 1
	t 75, 25, 'って'
end
tp_chain 0, 100, 1 do
	4.times do |i|
		x = -87.5 + 12.5*i
		y = 0
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tp_drop 0, 100, 1, preserve_beat: false do
	f -37.5, 0, :l; b 1
	t 0, 37.5; b 1
	t 0, -25; b 1/2
	t -25, 0; b 1/2
	f -50, 25, :l; b 1

	t 37.5, 0; b 1
	f 0, 37.5, :r; b 1
	t 0, -25; b 1/2
	t 25, 0; b 1/2
	f 50, 25, :r; b 1
end

tp_chain 0, 100, 1 do
	b 1
	t 50, -25, ?こ; b 1/2
	t 37.5, 0, ?ん; b 1
	t 25, -37.5, ?な; b 1
	t 12.5, 12.5, ?こ; b 1/2

	t -12.5, 12.5, ?と; b 1
	t -25, -12.5, ?も; b 1
	t -37.5, 37.5, ?あ; b 1
	t -62.5, 12.5, 'った'; b 1

	tp_drop 0, -100, 1, preserve_beat: false do
		7.times do |i|
			angle = PI/8*(i+1)
			t 75*cos(angle), 50*sin(angle); b 1/2
		end
	end
	13.times do |i|
		angle = PI+PI/14*(i+1)
		x = 75*cos(angle)
		y = 50*sin(angle)
		i.zero? ? h(x, y, 2, 'って') : d(x, y); b 1/4
	end
end
b 1/4
tp_chain -100, 0, 1 do
	t -25, 0, ?笑; b 1/4
	d 0, 0; bg_note 0, 0, ?\s; b 1/4

	d 25, 0; bg_note 25, 0, ?\s; b 1/2
end
tp_drop 0, 100, 1, preserve_beat: false do
	t 50, 0, 'って'; t -50, 0; b 1/2
	t 0, 0; b 1
	t 0, 0
end
b 1
tp_drop 100, 0, 1, preserve_beat: false do
	t 25, 25, 'やん'; b 1
	t 37.5, -25, ?の; b 1/2
	t 50, -50, ?さ; b 1
end
tp_drop -100, 0, 1 do
	t -25, 25; b 1
	t -37.5, -25; b 1/2
end
tp_chain -100, 0, 1 do
	4.times do |i|
		x = -50+12.5*i
		y = -50+12.5*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

notes = tp_drop 100, -100, 1, preserve_beat: false do
	b 1/2
	t 12.5, -37.5; b 1/2
	t 37.5, -12.5; b 1
end
transform(duplicate notes) { rotate PI }
transform(duplicate notes) { horizontal_flip; beat_translate 3/2 }
transform(duplicate notes) { vertical_flip; beat_translate 3/2 }
tp_drop 0, 100, 1 do
	t 0, 0; b 3/2
	t 0, 0; b 3/2
	t 0, 0; b 1/2
	tp_drop 0, -100, 1 do
		t -75, 0; t 75, 0; b 1/2
	end

	t 0, 0; b 1/2
	notes = tp_drop 100, 0, 1 do
		t 0, 50; b 1/2
	end
	transform(duplicate notes) { rotate PI }
end
t 12.5, 12.5; b 1/4
t -12.5, 0; b 1/4
h 25, -12.5, 5/2
f -25, -12.5, :l; b 3/2
t -25, 25; b 1

def stream x, n = 1, flick_start = false
	n.times { flick_start && _1.zero? ? f(x, -50, :u) : t(x, -50); b 1 }
end
group preserve_beat: false do
	[
		[[?_, 1/2], [?狭, 1], [?い, 1/2], [?教, 1], [?室, 1]],
		[[?真, 1], [?空, 1], [?状, 1], [?態, 1]],
		[[?_, 1/2], [?少, 1], [?年, 1], [?た, 1/2], [?ち, 1/2], [?は, 1/2]],
		[[?青, 1], [?春, 1], [?全, 1], [?開, 1]],
		[[?_, 1/2], [?キ, 1/2], [?リ, 1/2], [?ト, 1/2], [?リ, 1/2], [?線, 1], [?で, 1/2],
		[?区, 1], [?切, 1], [?れ, 1], [?た, 1]],
		[[?僕, 1], [?の, 1/2], [?世, 1/2], [?界, 2]]
	].each_with_index do |data, i|
		width = (data.count { _2; _1 != ?_ } - 1) * 200/9
		y = 37.5 - 25*(i%2)
		data.reduce -width/2 do |x, (text, delta)|
			if text != ?_
				bg_note x, y, text; b delta; x + 200/9
			else
				b delta; x
			end
		end
	end
end
tp_drop 0, 100, 1 do
	stream -37.5, 4, true

	stream 37.5, 4

	stream -62.5, 4

	stream 50
	stream 75
	stream 50
	stream 25

	stream 62.5, 3
	h 62.5, -50, 1; b 1

	stream -75, 2
	stream -37.5, 2

	stream 0, 4

	[25, -50, 50, -25].each { |x| t x, -50; b 1/2 }
	b 1
	h 0, 0, 1/2; b 1
end

def curve x, y, width, up
	n = width.to_r/25
	(-n..n).step 1 do |i|
		dx = 12.5*i
		dy = width*sqrt(3)/2 - sqrt(width**2 - dx**2)
		dy *= -1 if up
		group preserve_beat: false do
			b i.abs/8
			bg_note x+dx, y+dy, 4-i.abs/4
		end
	end
end
def sad
	curve -75, 25, 25, false
	curve -25, 25, 25, false
	curve -50, -25, 50, true
end
def happy
	curve 75, 25, 25, true
	curve 25, 25, 25, true
	curve 50, -25, 50, false
end
tp_drop 0, 100, 1 do
	b 1/2
	t 37.5, 37.5, ?嫌; b 1/2
	t 62.5, 37.5, ?\s; b 1/2
	bg_note 87.5, 37.5, ?い; b 1/2
	sad
	t 12.5, 25, ?な; b 1/2
	t 37.5, 25, ?僕; b 1/2
	t 62.5, 25, ?\s; b 1/2
	t 87.5, 25, ?の; b 1/2
end

notes = tp_drop 100, 0, 1 do
	t 75, -37.5, ?劣; b 1
	t 75, 0, ?等; b 1
	t 75, -50, ?感; b 1
	t 75, -12.5, ?と; b 1
end
notes = transform duplicate notes do
	horizontal_flip
	translate 100, 0
end
notes.each { _1[:text] = '' if _1[:text] }

tp_drop 0, 100, 1 do
	b 1/2
	t -62.5, 37.5, ?他; b 1/2
	t -37.5, 37.5, ?人; b 1
	happy
	t -87.5, 25, ?と; b 1/2
	t -62.5, 25, ?違; b 1/2
	t -37.5, 25, ?\s; b 1/2
	t -12.5, 25, ?う; b 1/2
end

tp_drop -100, 0, 1, preserve_beat: false do
	b 3/2
	t -50, -25
end
notes = tp_drop -100, 0, 1 do
	t -75, 0, ?優; b 1
	t -75, -37.5, ?越; b 1
	t -75, -12.5, ?感; b 1
	t -75, -50, ?と; b 1
end
notes = transform duplicate notes do
	horizontal_flip
	translate -100, 0
end
notes.each { _1[:text] = '' if _1[:text] }

b 1/2
tp_chain 100, 0, 1 do
	%W[せ め ぎ あ].each_with_index do |text, i|
		t 37.5-i*25, 37.5, text; b 1/2
	end
end
tp_chain -100, 0, 1 do
	%W[う 絶 \s 妙].each_with_index do |text, i|
		t -37.5+i*25, 12.5, text; b 1/2
	end
end
b -1/2
tp_drop 100, 0, 1, preserve_beat: false do
	t -25, -37.5; b 1
	t -37.5, 12.5, ?な; b 1
	t -37.5, -50, ?感; b 1
	t -25, 0; b 1
end
tp_drop -100, 0, 1 do
	b 1
	t 25, -37.5; b 1
	t 25, 0; b 1
	t 37.5, -50, ?情; b 1
end

tp_chain 0, 100, 1 do
	t -75, 25, ?い; b 1
	h -50, 0, 1, 'ったい'; b 2
end
tp_chain 0, 100, 1 do
	t 75, 0, ?な; b 1/2
	t 62.5, -25, ?に; b 1/2

	group preserve_beat: false do
		bg_note -25, 50, ?や; b 1
		bg_note 0, 50, 'ってん'; b 1
		bg_note 25, 50, ?だ; b 1
	end
	tp_drop -100, 0, 1 do
		f -50, 0, :l; b 1/2
	end
	t 25, -50; b 1/2
end
tp_chain 0, -100, 1 do
	t -12.5, -25; b 1/4
	t 12.5, -12.5; b 1/4
	t -12.5, 0; b 1/4
	t 12.5, 12.5; b 1/4
	h -12.5, 25, 1; b 1/2
	t 37.5, 37.5; b 1/2
	t 50, 0; b 1/2
	f 37.5, -37.5, :r
end
tp_chain 100, 0, 1 do
	h -25, -12.5, 2; b 1/2
end

group preserve_beat: false do
	bg_note -100, -43.75, 8-1/2, ?「
	bg_note 100, -43.75, 8-1/2, ?」; b 1/2
	%W[わ か る わ か る].each_with_index do |text, i|
		bg_note -62.5+25*i, -37.5, text; b 1/2
	end
end
tp_drop 0, 100, 1 do
	b 1/2
	t 75, 25; b 1/2
end
tp_chain 0, 100, 1 do
	t 75, 25; b 1
	h 37.5, 25, 1
end
tp_drop -100, 0, 1 do
	t -62.5, -25; b 1/2
	t -87.5, 0; b 1
	h -75, 37.5, 2
end
tp_drop 0, 100, 1 do
	f 25, -25, :r; b 1/2
end

group preserve_beat: false do
	b -1/2
	%W[同 \s じ 気 持 ち さ].each_with_index do |text, i|
		bg_note -75+25*i, -50, text; b i.zero? ? 1 : 1/2
	end
end
tp_drop 0, 100, 1 do
	b 1/2
	t 75, 25; b 1/2
end
tp_chain 0, 100, 1 do
	t 75, 25; b 1
	tp_chain 0, 100, 1, preserve_beat: false do
		t -12.5, 25; b 1/2
		t -12.5, 0; b 1/2
		4.times do |i|
			x = -12.5 - i*12.5
			y = -25 + i*12.5
			i.zero? ? t(x, y) : d(x, y); b 1/4
		end
	end
	b 1/4
	t 12.5, 12.5; b 1/2
	t 12.5, -12.5; b 1/4
	b 1
end

tp_chain 0, -100, 1, preserve_beat: false do
	h -62.5, 25, 2; b 2
	5.times do |i|
		angle = PI/2 - PI/4*i
		x = -62.5-12.5*cos(angle)
		y = 12.5+12.5*sin(angle)
		d x, y; b 1/4
	end
end
tp_chain 100, 0, 1 do
	b 1/2
	t 100, 25, ?ホ; b 1/2
	t 75, 25, ?ン; b 1/2
	t 50, 25, ?ト; b 1/2
	t 25, 25, ?に; b 1/2
end
tp_chain -100, 0, 1 do
	t 37.5, 0, ?そ; b 1/2
	t 62.5, 0, ?う; b 1/2
	t 87.5, 0, ?思; b 1/2
end

big_text 3, ??
tp_drop 0, 100, 1, preserve_beat: false do
	f 75, -25, :ul; b 1
	f -75, -25, :ur; b 1
	f 75, -25, :ul; b 1
end
t -18.5, 33.4, ?\s; b 1
t 20.8, 37.5, 'ってい'; b 1
t -0.7, 6.0, ?ま; b 1/2
bg_note -4.6, -8.5, ?す; b 1/2
t -10.0, -33.3, ?か
tp_chain 0, 100, 1 do
	4.times do |i|
		x = -75+i*12.5
		y = -25+i*12.5
		i.zero? ? f(-75, -25, :ur) : d(x, y); b 1/4
	end

	f -25, 25, :l; b 1
end
tp_drop 0, 100, 1, preserve_beat: false do
	3.times do |i|
		t 87.5*(-1)**i, -37.5; b 2
		next if i == 2
		t 87.5*(-1)**i, -37.5; b 1
		t -62.5*(-1)**i, 25; b 1
	end
end
b 1
tp_chain 100, 0, 1 do
	t -50, 37.5, ?た; b 1
	t -12.5, 25, ?じ; b 1

	b 1
	t 50, -12.5, ?ろ; b 1
	t 12.5, -37.5, ?ぐ; b 1
	t 0, 25, ?僕; b 1

	h -50, 12.5, 1/2, ?\s; b 3/2
	t -75, -12.5, ?の; b 1/2
	t -50, -25, ?気; b 1
	t 0, 0, ?も
end
tp_chain 0, 100, 1 do
	t 87.5, -37.5; b 1/2
	t 62.5, -50; b 1/2

	group preserve_beat: false do
		%W[知 ら な い で].each_with_index do |text, i|
			bg_note -50+25*i, 50, text; b 1/2
		end
	end
	tp_drop 0, 100, 1 do
		f -87.5, 0, :l; b 1/2
	end
	t 50, 0; b 1/2
	t -12.5, 25; b 1/4
	t 12.5, 12.5; b 1/4
	t -12.5, 0; b 1/4
	t 12.5, -12.5; b 1/4
	t -12.5, -25; b 1/2
	t 50, -12.5; b 1/2
	t -50, 0; b 1/2
	t 50, 25; b 1/2
end

def arc x1, y1, x2, y2, deviation, n, &block
	return to_enum __method__, x1, y1, x2, y2, deviation, n unless block
	ux, uy = (x2-x1)/2, (y2-y1)/2
	dis = hypot ux, uy
	ux /= dis
	uy /= dis
	x0, y0 = (x1+x2)/2, (y1+y2)/2
	r = (deviation + dis**2/deviation)/2
	cx, cy = x0 - uy*(r-deviation), y0 + ux*(r-deviation)
	ang = asin(dis/r)*2
	ang0 = atan2(uy, ux) - PI/2 - ang/2
	n.to_i.times do |i|
		angle = ang*i/n + ang0
		block.(cx+r*cos(angle), cy+r*sin(angle))
	end
end
def arc_chain x1, y1, x2, y2, deviation, duration, text
	arc(x1, y1, x2, y2, deviation, duration*4).each_with_index do |(x, y), i|
		i.zero? ? h(x, y, duration, text) : d(x, y); b 1/4
	end
end
def arc_tap x1, y1, x2, y2, deviation, duration, zero_onset = false
	arc(x1, y1, x2, y2, deviation, duration*2).each_with_index do |(x, y), i|
		i.zero? ? (d(x, y) unless zero_onset) : t(x, y); b 1/2
	end
end
def chorus_start lyrics
	result = group do
		tp_chain 100, 0, 1, preserve_beat: false do
			arc_chain -75, 25, 12.5, -50, 12.5, 2, lyrics[0]
			arc_tap 12.5, -50, 75, 12.5, 25, 2
			mark :l
		end
		tp_chain -100, 0, 1 do
			arc_tap 112.5, 0, 0, 50, 12.5, 2, true
			arc_chain 0, 50, -37.5, -50, -25, 2, lyrics[1]
			mark :r
		end
	end

	at :l, update_mark: true do
		arc_chain 75, 12.5, -25, 37.5, 12.5, 2, lyrics[2]
		arc_tap -25, 37.5, -100, -50, -12.5, 2
	end
	at :r, update_mark: true, preserve_beat: true do
		arc_tap -37.5, -50, -87.5, 50, -25, 2
		arc_chain -87.5, 50, 12.5, 12.5, 12.5, 2, lyrics[3]
	end

	at :l, update_mark: true do
		arc_chain -100, -50, -62.5, 0, -12.5, 1, lyrics[4]
		arc_tap -62.5, 0, -12.5, -37.5, 12.5, 1
		arc_chain -12.5, -37.5, 37.5, 0, -12.5, 1, lyrics[6]
		arc_tap 37.5, 0, 37.5, -50, -12.5, 1
	end
	at :r, update_mark: true, preserve_beat: true do
		arc_tap 12.5, 12.5, 50, -25, -12.5, 1
		arc_chain 50, -25, -25, 25, -12.5, 1, lyrics[5]
		arc_tap -25, 25, 25, 50, -12.5, 1
		arc_chain 25, 50, 87.5, 50, 12.5, 1, lyrics[7]
	end

	final_notes = at :l, update_mark: true do
		arc_chain 37.5, -50, -62.5, 0, -12.5, 2, lyrics[8]
		arc_tap -62.5, 0, 75, 25, -25, 2
	end
	at :r, update_mark: true, preserve_beat: true do
		arc_tap 87.5, 50, 75, -50, -12.5, 2
		arc_chain 75, -50, final_notes[-2][:x], final_notes[-2][:y], -12.5, 1, lyrics[9]; b 1
	end
	final_notes[-2..].each { _1[:tip_point] = result.last[:tip_point]}
	result
end
chorus1 = chorus_start %W[誰 \s か が 始 \s め る 今日 は]
chorus2 = transform(chorus_start %W[僕 \s に は 終 わ り の 今日 さ]) { horizontal_flip }
target_tp = chorus1.last[:tip_point]
old_tp_placeholder = chorus2.find { _1.type == :placeholder }
old_tp = old_tp_placeholder[:tip_point]
remove old_tp_placeholder
chorus2.each { _1[:tip_point] = target_tp if _1[:tip_point] == old_tp }

notes = tp_drop 100, 0, 1, preserve_beat: false do
	4.times do |i|
		s = (-1)**i
		t 75, 0; b 1/2
		t 87.5, 25*s; b 1/2
		t 100, 50*s; b 1
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 8 }
at :r, preserve_beat: true do
	t -75, 25, ?繰; b 1
	t -37.5, 0, ?り; b 1/2
	t -12.5, 0, ?返; b 1
	t 25, 12.5, ?す; b 1
	t 12.5, -25, ?足; b 1/2

	b 1/2
	t -25, -25, ?\s; b 1/2
	t -50, -37.5, ?踏; b 1/2
	t -75, -25, ?み; b 1/2
	t -87.5, 0, ?に; b 2
end

tp_chain 0, 100, 1 do
	t 50, 25, ?未; b 1
	t 12.5, 12.5, ?来; b 1/2
	t -12.5, 12.5, ?\s; b 1
	t 25, 37.5, ?か; b 1/2
	t 50, 50, ?ら; b 1/2
	t 75, 37.5, ?の; b 1/2

	b 1/2
	t 62.5, -12.5, ?呼; b 1/2
	t 37.5, -25, ?び; b 1/2
	t 12.5, -12.5, ?声; b 1/2
	t 0, 12.5, ?\s; b 1
	t -25, -25, ?が; b 1
end

tp_chain 100, 0, 1, preserve_beat: false do
	arc_chain -75, 12.5, 12.5, -50, 12.5, 2, ?響
	arc_tap 12.5, -50, 12.5, 50, -25, 2
	mark :l
end
tp_chain -100, 0, 1 do
	arc_tap 37.5, 62.5, -50, 12.5, -37.5, 2, true
	arc_chain -50, 12.5, 75, 0, -25, 2, ?\s
	mark :r
end

at :l, update_mark: true do
	arc_chain 12.5, 50, 50, -25, 37.5, 2, ?い
	arc_tap 50, -25, 12.5, 12.5, 12.5, 1
	arc_chain 12.5, 12.5, -100, -25, 25, 2, ?る
end
at :r, update_mark: true, preserve_beat: true do
	arc_tap 75, 0, -50, 0, -37.5, 2
	arc_chain -50, 0, 0, -50, 12.5, 1, ?て
	arc_tap 0, -50, 87.5, 25, -25, 2

	f 87.5, 25, :ur; b 1
end
tp_chain 0, 100, 1 do
	t 25, 50; b 1/2
	6.times do |i|
		t -12.5*(-1)**i, 25-12.5*i; b 1/4
	end

	group preserve_beat: false do
		b -2
		bg_note 75, 50, 9/2, ?﹁
		bg_note 75, -30, 9/2, ?﹂
		b 1
		bg_note 75, 30, ?進; b 2
		bg_note 75, 10, ?め; b 1
		bg_note 75, -10, ?よ; b 1
		bg_note 75, -50, ?と; b 1
	end
	t -12.5, -50; b 1/2
	t 37.5, -25; b 1/2
	f -37.5, 0, :l; b 1
	t -62.5, 25; b 1/2
	6.times do |i|
		t 12.5*(-1)**i, 50-12.5*i; b 1/4
	end
end

tp_drop 0, 100, 1, preserve_beat: false do
	15.times { t 0, -37.5; b 1 }
end
tp_chain 0, 100, 1 do
	b 1/2
	t -12.5, 25, ?運; b 1/2
	t -37.5, 37.5, ?\s; b 1/2
	t -62.5, 50, ?命; b 1
	t -50, 0, ?や; b 1/2
	t -25, 12.5, ?奇; b 1/2
	t 0, 0, ?跡; b 1/2

	b 1/4
	t 50, 0, ?\s; b 1/4
	d 62.5, -12.5; bg_note 62.5, -12.5, 'なん'; b 1
	t 100, -12.5, ?て; b 1/2
	t 75, 0, ?も; b 1/2
	t 50, 12.5, ?の; b 1/2
	t 25, 25, ?は; b 1

	b 1/2
	t -37.5, 37.5, ?き; b 1/2
	t -62.5, 37.5, ?\s; b 1/2
	t -87.5, 37.5, 'っと'; b 1/2
	t -87.5, 12.5, ?僕; b 1/2
	t -62.5, 12.5, ?\s; b 1/2
	t -37.5, 12.5, ?に; b 1/2
	t -12.5, 12.5, ?は; b 1/2

	t 12.5, 12.5, ?も; b 1
	t -50, 0, 'ったい'; b 1
	t 75, 25, 'ない'; b 1
	t -37.5, 37.5, ?や
end
tp_chain 0, 100, 1 do
	4.times do |i|
		x = 12.5*i
		y = -37.5+12.5*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tp_drop 0, 100, 1, preserve_beat: false do
	f 50, 12.5, :r; b 1
	t 0, 37.5; b 1
	t 0, -25; b 1/2
	t 25, 0; b 1/2
	f 50, 25, :r; b 1

	t 50, 12.5; b 1
	f 0, 37.5, :l; b 1
	t 0, -25; b 1/2
	t -25, 0; b 1/2
	f -50, 25, :l; b 1
end

tp_chain 0, 100, 1 do
	b 1
	t -50, -25, ?な; b 1/2
	t -37.5, 0, ?ん; b 1
	t -25, -37.5, ?と; b 1
	t -12.5, 12.5, ?な; b 1/2

	t 12.5, 12.5, ?く; b 1
	t 25, -12.5, ?の; b 1
	t 37.5, 37.5, ?一; b 1
	t 62.5, 12.5, ?歩; b 1

	tp_drop 0, -100, 1, preserve_beat: false do
		7.times do |i|
			angle = PI-PI/8*(i+1)
			t 75*cos(angle), 50*sin(angle); b 1/2
		end
	end
	13.times do |i|
		angle = -PI/14*(i+1)
		x = 75*cos(angle)
		y = 50*sin(angle)
		i.zero? ? h(x, y, 2, ?を) : d(x, y); b 1/4
	end
end
b 1/4
tp_chain -100, 0, 1 do
	t 25, 0, ?踏; b 1/4
	d 0, 0; bg_note 0, 0, ?み; b 1/4

	d -25, 0; bg_note -25, 0, ?出; b 1/2
end
tp_drop 0, 100, 1, preserve_beat: false do
	t -50, 0, ?す; t 50, 0; b 1/2
	t 0, 0; b 1
	t 0, 0
end
b 1
tp_drop 100, 0, 1, preserve_beat: false do
	t -25, 25, ?だ; b 1
	t -37.5, -25, ?け; b 1/2
	t -50, -50, ?さ; b 1
end
tp_drop -100, 0, 1 do
	t 25, 25; b 1
	t 37.5, -25; b 1/2
	t 50, -50; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	f -87.5, 0, :l; b 3/2
	t 25, 12.5; b 1
	t -75, -37.5; b 1
	f 50, 25, :r; b 1/2

	b 1
	t -25, 12.5; b 2
	f 75, 25, :r; b 1

	f -50, 37.5, :l; b 3/2
	t -87.5, 0; b 1
	t 50, 0; b 1
	f -62.5, 0, :l; b 1/2

	b 1
	t -50, -37.5; b 3/2
	6.times do |i|
		t -12.5*(-1)**i, 25-12.5*i; b 1/4
	end
end

tp_chain 0, 100, 1 do
	h 75, 37.5, 1/2; b 1
	t -25, 25; b 1/2
	h -50, 50, 1/2; b 1
	h 50, -25, 1/2; b 1
	h -75, 12.5, 1/2; b 1/2

	b 1/2
	t 25, -25; b 1/2
	t 0, -37.5; b 1/2
	t -25, -25; b 1/2
	h -50, -12.5, 1; b 2

	t 87.5, -50; b 1/2
	t 62.5, -37.5; b 1/2
	t 37.5, -25; b 1/2
	t 50, 37.5; b 1/2
	t 12.5, -12.5; b 1/2
	t -50, 37.5; b 1/2
	t -12.5, 0; b 1/2
	h 87.5, 25, 1/2; b 1/2

	b 1/2
	t 50, -50; b 1/2
	t 62.5, -25; b 1/2
	h 75, 0, 1/2; b 5/2
end

def three x, y, up = true
	dx = 12.5 * (x <=> 1)
	dy = 12.5 * (up ? 1 : -1)
	tp_chain -dx*8, -dy*8, 1 do
		t x, y; b 1/6
		d x+dx, y+dy; b 1/6
		d x+2*dx, y+2*dy; b 1/6
	end
end
tp_chain 100, -100, 1 do
	t -62.5, -50; b 1/4
end
tp_chain -100, -100, 1 do
	t 62.5, -37.5; b 1/4
end
remove three(-75, -25)[-2]
three 37.5, -12.5
three -50, 0
three 75, 25, false
three -25, 37.5, false
three 62.5, 0, false
three -75, 12.5, false

three 25, -25
tp_chain 100, -100, 1 do
	t -50, -25; b 1/4
end
tp_chain -100, -100, 1 do
	t -12.5, -12.5; b 1/4
end
tp_drop 0, 100, 1 do
	h -37.5, 0, 3/2; b 1/2
end
tp_chain 0, 100, 1 do
	h 0, 25, 1; b 3/2
	t 50, 0; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	t -50, 25; b 1
	t -12.5, 0; b 2/3
	t -37.5, -25; b 2/3
	t -50, 0; b 2/3
	t -75, 12.5; b 2/3
	t -75, -12.5; b 1/3
	mark :l
end
tp_chain 0, 100, 1 do
	b 1/3
	t 37.5, 37.5; b 1/3
	t 12.5, 25; b 2/3
	t 37.5, 0; b 2/3
	t 62.5, 25; b 2/3
	t 75, -12.5; b 2/3
	t 37.5, -25; b 2/3
	mark :r
end

at :r do
	t 0, -37.5; b 2/3
	t 37.5, -50; b 2/3
	t 62.5, -25; b 2/3
	h 25, -12.5, 3/2; b 1/4
	d 37.5, 0; b 1/4
	d 50, -12.5; b 1/2
end
at :l, preserve_beat: true do
	b 1/3
	t -75, -37.5; b 2/3
	t -50, -50; b 2/3
	t -25, -37.5; b 1/3
end
tp_drop 0, 100, 1 do
	t -12.5, -12.5; b 1/3
	d -37.5, 0; b 1/3
	d -62.5, 12.5; b 1/3
	d -37.5, 25; b 1/3
	d -12.5, 37.5; b 1/3
	d 12.5, 25; b 1/3

	f 37.5, 12.5, :r
end
def straight x0, y0, direction, duration
	angle = Sunniesnow::Charter::DIRECTIONS[direction]
	dx = 12.5*cos(angle)
	dy = 12.5*sin(angle)
	(duration*4).to_i.times do |i|
		x, y = x0+dx*i, y0+dy*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end
tp_chain -100, 0, 1 do
	group preserve_beat: false do
		b 1/2
		%W[オ ト ナ ほ ど].each_with_index do |text, i|
			bg_note -50+25*i, -50, text; b 1/2
		end
		%W[ク サ _ って も い な く て].reduce -87.5 do |x, text|
			if text != ?_
				bg_note x, 50, text; b 1/2; x+25
			else
				b 1/2; x
			end
		end
	end
	straight -12.5, 12.5, :l, 3/2
	straight -87.5, 12.5, :d, 3/2
	straight -87.5, -50, :r, 1

	straight -37.5, -50, :u, 3/2
	straight -37.5, 25, :r, 3/2
	straight 37.5, 25, :d, 1

	group preserve_beat: false do
		b 1/2
		%W[コ ド モ].each_with_index do |text, i|
			bg_note -87.5+25*i, 12.5, text; b 1/2
		end
		%W[ほ ど 天 \s].each_with_index do |text, i|
			bg_note -100+25*i, -12.5, text; b 1/2
		end
	end
	straight 37.5, -25, :r, 1
	straight 87.5, -25, :u, 1
	straight 87.5, 25, :l, 1
	f 37.5, 25, :d; b 1
end

%W[才 じゃ ない が].each_with_index do |text, i|
	angle = PI*3/4 + PI/2*i
	r = 100*sqrt(2)
	x, y = r*cos(angle), r*sin(angle)
	tp_chain -x, -y, 1 do
		t x*3/8, y*3/8, text
	end
	tp_chain x, y, 1 do
		a = ((angle/PI-1/2).round+1/2)*PI
		f -x/2, -y/2, a
		if i < 3
			b 1 # tp_chain(0, 100, 1) { b 1/2; t 0, 0; b 1/2 }
		else
			b 1/4
			dx, dy = 12.5*cos(a), 12.5*sin(a)
			(1...4).each do |i|
				d -x/2+dx*i, -y/2+dy*i; b 1/4
			end

			f -50, 0, :l; b 1
		end
	end
end
tp_drop 0, 100, 1, preserve_beat: false do
	3.times do |i|
		t 87.5*(-1)**i, -37.5; b 2
		next if i == 2
		t 87.5*(-1)**i, -37.5; b 1
		t -62.5*(-1)**i, 25; b 1
	end
end
b 1
tp_chain 100, 0, 1 do
	t -50, 37.5, ?僕; b 1
	t -12.5, 25, ?\s; b 1

	b 1
	t 50, -12.5, ?は; b 1
	t 12.5, -37.5, ?今; b 1
	t 0, 25, ?\s; b 1

	h -50, 12.5, 1/2, ?人; b 3/2
	t -75, -12.5, ?生; b 1/2
	t -50, -25, ?\s; b 1
	t 0, 0, ?の
end
tp_chain 0, 100, 1 do
	t 87.5, -37.5; b 1/2
	t 62.5, -50; b 1/2

	group preserve_beat: false do
		%W[中 間 だ].each_with_index do |text, i|
			bg_note -25+25*i, 50, text; b 1
		end
	end
	tp_drop 0, 100, 1 do
		f -87.5, 0, :l; b 1/2
	end
	t 62.5, 25; b 1/2
	12.times do |i|
		x = [-12.5, 12.5, -37.5, 37.5][i%4]
		y = [25, 12.5][i%2] - 12.5*(i/2).floor
		t x, y; b 1/4
	end
end

group preserve_beat: false do
	[
		[?風,2], [?\s,2],
		[?に,2], [?お,2],
		[?い,1], [?て,1], [?か,1], [?れ,1],
		['そう',2], [?で,0]
	].each_with_index do |(text, duration), i|
		bg_note -100+200/9*i, 25, text; b duration
	end
end
tp_drop 0, 100, 1 do
	h -12.5, -50, 7; b 1
	tp_none { 3.times { d -12.5, -50; b 2 } }
	b -1
	[25, 75, 37.5, -50, 0].each_with_index do |x, i|
		h x, -50, i>2 ? 2 : 3; b 1
		tp_none { d x, -50; b 1 }
	end
end
b -5/4
tp_chain -100, 0, 1 do
	t -75, 25; b 3/4
	t -62.5, -12.5; b 1/2
end

def arc_drag x1, y1, x2, y2, deviation, duration
	arc(x1, y1, x2, y2, deviation, duration*4).each_with_index do |(x, y), i|
		d x, y; b 1/4
	end
end
tp_chain 100, 0, 1, preserve_beat: false do
	arc_chain -50, -50, -100, 37.5, -12.5, 2, ?必
	arc_drag -100, 37.5, 0, -12.5, 25, 2
	mark :l
end
tp_chain -100, 0, 1 do
	b 2
	arc_chain 100, -37.5, 25, 25, -25, 2, ?死
	mark :r
end

at :l, update_mark: true do
	arc_chain 0, -12.5, 100, 12.5, -25, 2, ?に
	arc_drag 100, 12.5, 12.5, 37.5, 12.5, 2
end
at :r, update_mark: true, preserve_beat: true do
	arc_drag 25, 25, -75, 12.5, 25, 2
	arc_chain -75, 12.5, -37.5, -50, 12.5, 2, ?喰
end

at :l, update_mark: true do
	arc_chain 12.5, 37.5, 62.5, 25, 12.5, 1, ?ら
	arc_drag 62.5, 25, 50, -25, -12.5, 1
	arc_chain 50, -25, 0, 0, 12.5, 1, ?つ
	arc_drag 0, 0, -25, -50, -12.5, 1
end
at :r, update_mark: true, preserve_beat: true do
	arc_drag -37.5, -50, -50, 0, -12.5, 1
	arc_chain -50, 0, -12.5, 37.5, -12.5, 1, ?い
	arc_drag -12.5, 37.5, 37.5, 37.5, 12.5, 1
	arc_chain 37.5, 37.5, 87.5, 0, -12.5, 1, ?い
end

at :l, update_mark: true do
	arc_chain -25, -50, -75, 37.5, -12.5, 2, ?て
	arc_drag -75, 37.5, -25, 0, -25, 1
	b 1
end
at :r, update_mark: true, preserve_beat: true do
	arc_drag 87.5, 0, 50, -50, 37.5, 2
	arc_chain 50, -50, 100, 0, 12.5, 1, ?る
	b 1
end

notes = tp_drop 100, 0, 1, preserve_beat: false do
	4.times do |i|
		s = -(-1)**i
		t -62.5, 0; b 1/2
		t -75, 25*s; b 1/2
		f -87.5, 50*s, :l; b 1
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 8 }
at :r, preserve_beat: true do
	t 75, 25, ?い; b 1
	t 37.5, 0, ?つ; b 1/2
	t 12.5, 0, ?も; b 1
	t -25, 12.5, ?の; b 1
	t -12.5, -25, ?鐘; b 1/2

	b 1/2
	t 25, -25, ?\s; b 1/2
	t 50, -37.5, ?の; b 1/2
	t 75, -25, ?音; b 1/2
	t 87.5, 0, ?も; b 2
end

tp_chain 0, 100, 1 do
	t -50, 25, ?窓; b 1
	t -12.5, 12.5, ?\s; b 1/2
	t 12.5, 12.5, ?際; b 1
	t -25, 37.5, ?\s; b 1/2
	t -50, 50, ?に; b 1/2
	t -75, 37.5, '積ん'; b 1/2

	b 1/2
	t -62.5, -12.5, ?だ; b 1/2
	t -37.5, -25, ?埃; b 1/2
	t -12.5, -12.5, ?\s; b 1/2
	t 0, 12.5, ?\s; b 1
	t 25, -25, ?も; b 1
end

tp_chain 100, 0, 1, preserve_beat: false do
	arc_chain -25, 50, -50, -25, 25, 2, ?教
	arc_drag -50, -25, 25, 12.5, -25, 2
	mark :l
end
tp_chain -100, 0, 1 do
	b 2
	arc_chain 75, 12.5, 12.5, -50, -12.5, 2, ?\s
	mark :r
end

at :l, update_mark: true do
	arc_chain 25, 12.5, 87.5, 37.5, -12.5, 2, ?室
	arc_drag 87.5, 37.5, 100, 0, 12.5, 1
	arc_chain 100, 0, -100, 0, 25, 3, ?の
end
at :r, update_mark: true, preserve_beat: true do
	arc_drag 12.5, -50, -37.5, 12.5, 12.5, 2
	arc_chain -37.5, 12.5, -75, -12.5, 12.5, 1, ?\s
	arc_drag -75, -12.5, 100, -37.5, 12.5, 3
end

b 1
group preserve_beat: false do
	%W[匂 い だ って].each_with_index do |text, i|
		bg_note -37.5+25*i, -50, text; b i==0 ? 2 : 1
	end
end
tp_chain 0, 100, 1 do
	4.times do |i|
		t -12.5*(-1)**i, 12.5-12.5*i; b 1/4
	end

	f -12.5, -37.5, :l; b 1/2
	t 62.5, -25; b 1/2
	12.times do |i|
		x = [-12.5, 12.5, -37.5, 37.5][i%4]
		y = [-25, -12.5][i%2] + 12.5*(i/2).floor
		t x, y; b 1/4
	end
end

tp_drop 0, -100, 1, preserve_beat: false do
	15.times do |i|
		t 0, 50 unless i==11; b 1
	end
end
tp_chain 0, 100, 1 do
	b 1/2
	t 12.5, -25, ?絶; b 1/2
	t 37.5, -12.5, ?\s; b 1/2
	t 62.5, 0, ?対; b 1
	t 50, -50, ?忘; b 1/2
	t 25, -37.5, ?\s; b 1/2
	t 0, -50, ?れ; b 1/2

	b 1/2
	t -50, -37.5, ?て; b 1/2
	t -75, -50, ?や; b 1/2
	t -100, -37.5, ?ら; b 1/2
	t -75, -25, ?な; b 1/2
	t -50, -12.5, ?い; b 1/2
	t -25, 0, ?よ; b 1

	b 1/2
	t 37.5, -12.5, ?い; b 1/2
	t 62.5, -12.5, ?つ; b 1/2
	t 87.5, -12.5, ?か; b 1/2
	t 87.5, -37.5, ?死; b 1/2
	t 62.5, -37.5, ?ぬ; b 1/2
	t 37.5, -37.5, ?ま; b 1/2
	t 12.5, -37.5, ?で; b 1/2

	f -12.5, 12.5, :r, ?何; b 1
	t 50, 0, ?回; b 1
	t -75, -25, ?だ; b 1
	t 37.5, -37.5, 'って'
end
tp_chain 0, -100, 1 do
	4.times do |i|
		x = -12.5*i
		y = 50-12.5*i
		i.zero? ? t(x, y) : d(x, y); b 1/4
	end
end

tp_drop 0, 100, 1, preserve_beat: false do
	f -50, 0, :l; b 1
	t 0, 37.5; b 1
	t 0, -25; b 1/2
	t -25, 0; b 1/2
	f -50, 25, :l; b 1

	t 50, 0; b 1
	f 0, 37.5, :r; b 1
	t 0, -25; b 1/2
	t 25, 0; b 1/2
	f 50, 25, :r; b 1
end

tp_chain 0, 100, 1 do
	b 1
	t 50, -25, ?こ; b 1/2
	t 37.5, 0, ?ん; b 1
	t 25, -37.5, ?な; b 1
	t 12.5, 12.5, ?こ; b 1/2

	t -12.5, 12.5, ?と; b 1
	t -25, -12.5, ?も; b 1
	t -37.5, 37.5, ?あ; b 1
	t -62.5, 12.5, 'った'; b 1

	tp_drop 0, -100, 1, preserve_beat: false do
		7.times do |i|
			angle = PI/8*(i+1)
			t 75*cos(angle), 50*sin(angle); b 1/2
		end
	end
	13.times do |i|
		angle = PI+PI/14*(i+1)
		x = 75*cos(angle)
		y = 50*sin(angle)
		i.zero? ? h(x, y, 2, 'って') : d(x, y); b 1/4
	end
end
b 1/4
tp_chain -100, 0, 1 do
	t -25, 0, ?笑; b 1/4
	d 0, 0; bg_note 0, 0, ?\s; b 1/4

	d 25, 0; bg_note 25, 0, ?\s; b 1/2
end
tp_drop 0, 100, 1, preserve_beat: false do
	t 50, 0, 'って'; t -50, 0; b 1/2
	t 0, 0; b 1
	t 0, 0
end
b 1
tp_drop 100, 0, 1, preserve_beat: false do
	t 25, -25, 'やん'; b 1
	t 37.5, 25, ?の; b 1/2
	t 50, 50, ?さ; b 1
end
tp_drop -100, 0, 1 do
	t -25, -25; b 1
	t -37.5, 25; b 1/2
	t -50, 50; b 1
end

group preserve_beat: false do
	11.times do |i|
		notes = group do
			tp_drop 0, -100, 1 do
				i.zero? ? f(-87.5, 50, :l) : t(-87.5, 50); b 1
			end
			tp_drop -100, 0, 1 do
				t -75, -12.5; b 1
			end
		end
		transform(notes) { horizontal_flip } if i%8>=4
	end
end
tp_chain -100, 0, 1 do
	4.times do |i|
		x = 0 + i*25
		y = 25 - i*12.5
		t x, y; b 1/2
		i == 3 ? t(x+25, y+12.5) : t(x,y-25)
		b 1/2
	end
end

tp_chain 100, 0, 1 do
	t 75, 37.5; b 1/2
	t 75, 12.5; b 1/2
	t 50, 25; b 1/2
	t 50, 0; b 1/2
	t 25, 12.5; b 1/2
	t 0, 0; b 1/2
	t 25, -12.5; b 1/2
	t 50, -25; b 1/2
end

tp_chain 100, 0, 1 do
	4.times do |i|
		x = -i*25
		y = 25 - i*12.5
		t x, y; b 1/2
		i == 3 ? t(x-25, y+12.5) : t(x,y-25)
		b 1/2
	end
end

tp_chain -100, 0, 1 do
	t -75, 37.5; b 1/2
	t -50, 25; b 1
	t -12.5, 25; b 1
	t 0, -12.5; b 1/2
	t -25, -25; b 1/2
	t -50, -25; b 1/2
end

tp_chain -100, 0, 1 do
	b 1
	t -25, -25; b 1/2
	t 0, -12.5; b 1/2
	t 25, 0; b 1/2
	t 50, -12.5; b 1/2
	t 75, -25; b 1/2
	t 87.5, 12.5; b 1/2

	b 1/2
	t 50, 25; b 1/2
	t 25, 12.5; b 1/2
	t 0, 0; b 1/2
	group preserve_beat: false do
		tp_drop 0, -100, 1 do
			t -87.5, 50; b 1/2
		end
		tp_drop -100, 0, 1 do
			t -87.5, 12.5; b 1/2
			f -75, -12.5, :l; b 1
		end
	end
	b 1/2
	t 12.5, -37.5; b 1/2
	t 37.5, -25; b 1/2
	t 62.5, -12.5; b 1/2

	group preserve_beat: false do
		tp_drop 0, -100, 1 do
			f -25, 50, :l; b 3/4
		end
		tp_drop -100, 0, 1 do
			t 12.5, 12.5; b 3/4
		end
		tp_drop 0, 100, 1 do
			f 62.5, -25, :r; b 1/2
			t 12.5, -25; b 1/2
			f -50, 25, :l; b 1/2
			t 0, 12.5; b 1/2
			f 75, 0, :r; b 1/2
		end
	end
	t 87.5, 0; b 1/2
	t 25, 25; b 1/2
	t 25, 0; b 1/2
	t -50, -12.5; b 1
	t 50, 12.5; b 1
	t -50, -25; b 1/2

	b 1/2
	t -75, 37.5; b 1/2
	tp_drop -100, 0, 1, preserve_beat: false do
		6.times do |i|
			b 1/4
			t -25+12.5*(-1)**i, 12.5-12.5*i; b 1/4
		end
	end
	6.times do |i|
		t 25-12.5*(-1)**i, 25-12.5*i; b 1/2
	end

	group preserve_beat: false do
		tp_drop 0, 100, 1 do
			f -50, -37.5, :l; b 3/2
			f 75, 25, :r; b 1
			t 37.5, -12.5; b 1
			f -75, 12.5, :l; b 1
		end
	end
	t 62.5, -25; b 1/2
	t 87.5, -12.5; b 1/2
	t 100, 12.5; b 1/2
	t 0, 25; b 1
	t -50, 37.5; b 1/2
	t -12.5, 50; b 1/2
	t 25, 25; b 1/2

	b 1/2
	t -62.5, -25; b 1/2
end
tp_chain 0, -100, 1 do
	12.times do |i|
		x = [12.5, -12.5, 37.5, -37.5][i%4]
		y = [-25, -12.5][i%2] + 12.5*(i/2).floor
		t x, y; b 1/4
	end
end

tp_drop 0, -100, 1 do
	h -75, 50, 3+1/4; h 75, 50, 3+1/2; b 3+1/2
	t -25, 0; b 1/4
	t 0, 0; b 1/4
	h 25, 0, 2; b 4
end

check

end
