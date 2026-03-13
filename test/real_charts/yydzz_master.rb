include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'master' do

title '嘤嘤大作战'
artist 'iKz @Signal-E feat. 祖娅纳惜'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'

offset 1.467
bpm 128.0075

def pattern start = false
	notes = tp_chain 0, 100, 0.5 do
		if start
			t -50, 0; b 2/6
			t -25, 25; b 1/6
			t -12.5, 37.5; b 2/6
			t 12.5, 62.5; b 1/6
		end
		2.times do |i|
			t 25, 75; b 2/6
			t 50, 50 if i == 1 && !start; b 1/6
			t 62.5, 37.5; b 2/6
			t 87.5, 12.5 if i == 1 && !start; b 1/6
			t 100, 0; b 2/6
			t 75, -25 if start || i == 0; b 1/6
			t 62.5, -37.5; b 2/6
			t 37.5, -62.5 if start || i == 0; b 1/6
			if start || i == 0
				t 25, -75; b 3/6
				t -12.5, -37.5; b 3/6
				t -50, 0; b 3/6
				t -87.5, 37.5 if i == 0; b 3/6
			else
				h 25, -75, 1; b 1
				h -50, 0, 1; b 1
			end
		end
	end
	transform(notes) { scale 1, 0.5 }
	notes
end
pattern true
transform(pattern) { horizontal_flip }

def lude
def pattern ending = false
	group do
		ending ? grid(13+1/2) : grid(14)
		group preserve_beat: false do
			b 1
			t -50, -50; b 1
			b 1
			t 50, 50; b 1

			b 3
			t -50, 50; b 1
		end
		tp_chain -100, 0, 1 do
			t -50, 50; b 1/2
			t -50, 0; b 1/2
			t 50, -50; b 1/3
			t 0, -25; b 1/6
			t 25, 0; b 1/3
			t -75, 25; b 1/6

			t -50, 50; b 1/2
			t 0, 50; b 1/2
			t -50, -50; b 1/2
			t 0, -50; b 1/2

			t 50, -50; b 1/3
			t 0, 0; b 1/6
			t -25, 25; b 1/3
			t 75, 25; b 1/6
			t 50, 50; b 1/2
			t 0, 50; b 1/3
			t 25, -25; b 1/6

			t 0, 0; b 1/2
			t -50, 0; b 1/2
			t 50, 50; b 1/2
			t 50, 0; b 1/2
		end

		group preserve_beat: false do
			b 1
			t -50, 50; b 1
			b 1
			t 50, -50; b 1

			b 1
			b 3/4
			t 50, 0 unless ending; b 1/4
			if ending
				turntable 1/4
				b 1/2
				turntable 1/4
				t 0, -50; b 1/2
				turntable 1/2
				f 50, 0, :right; b 1
			end
		end
		tp_chain -100, 0, 1 do
			t 50, -50; b 1/2
			t 0, -50; b 1/2
			t -50, -50; b 1/3
			t 25, -25; b 1/6
			t 0, 0; b 1/3
			t 75, 25; b 1/6

			t 50, 50; b 1/2
			t 0, 50; b 1/2
			t -50, 50; b 1/2
			t -50, 0; b 1/2

			t -50, -50; b 1/3
			t 25, -50; b 1/6
			t 50, -50; b 1/3
			t 50, 25; b 1/6
			t 50, 50; b 1/3
			t -25, 50; b 1/6
			if ending
				t -50, 50; b 1/3
				t -50, -25; b 1/6
				t -50, -50; b 1/2
				t 0, 50; b 1/2
				f -50, 0, :left; b 1
			else
				t -50, 50; b 1/4
				t -50, 0; b 1/4
			end
		end
		
		(-37.5).step 50, 12.5 do |x|
			bg_note x, 0; b 1/4
		end unless ending
	end
end
group do
	pattern
	transform(pattern true) { horizontal_flip }
end
end
lude

tp_chain -100, 0, beat_speed: 50 do
	f -50, 25, :up, ?贞; b 1
	t 0, 25, ?子; b 1/2
	t 25, 25, ?姐; b 1/2
	t 50, 25, ?打; b 1/2
	t 75, 25, ?招; b 1/4
	t 87.5, 25, ?呼; b 3/4
end
tp_chain -100, 0, beat_speed: 50 do
	t -75, 0, ?让; b 1/2

	t -50, 0, ?观; b 1/2
	t -25, 0, ?众; b 1/2
	t 0, 0, ?头; b 1/2
	t 25, 0, ?皮; b 1/2
	t 50, 0, ?发; b 1/2
	t 75, 0, ?酥; b 1/4
end
tp_chain 0, 100, beat_speed: 50 do
	t 75, 0, ?酥; b 5/4
end

(-37.5).step 37.5, 12.5 do |x|
	bg_note x, 25, 6
	bg_note x, -50, 6
end
(-37.5).step 12.5, 12.5 do |y|
	bg_note -37.5, y, 6
	bg_note 37.5, y, 6
end
[12.5, 25].each do |x|
	bg_note x, 25+x, 6
	bg_note -x, 25+x, 6
end
tp_chain -100, 0, beat_speed: 50 do
	t -37.5, -25, ?我; b 1/2
	t -12.5, -25, ?模; b 1/2
	t 12.5, -25, ?仿; b 1/2
	t 37.5, -25, ?她; b 1/2
end
tp_chain -100, 0, beat_speed: 50 do
	t -25, 0, ?钻; b 1/2
	t 0, 0, ?电; b 1/4
	t 12.5, 0, ?视; b 3/4
end
tp_chain -100, 0, beat_speed: 50 do
	t -50, 25, ?不; b 1/2

	t -25, 25, ?小; b 1/2
	t -0, 25, ?心; b 1/2
	t 25, 25, ?卡; b 1/4
	t 37.5, 25, ?住; b 1/4
	t 50, 25, ?肚; b 1/2
end
tp_chain 0, 100, beat_speed: 50 do
	h 50, 25, 1, ?肚; b 1/8
	(1..8).each do |i|
		angle = PI*i/8
		d 50*cos(angle), 25-50*sin(angle); b 1/8
	end
	b 7/8
end

tp_chain 100, 0, beat_speed: 50 do
	f 50, -25, :up, ?也; b 1
	t 25, -25, ?羡; b 1/2
	t 0, -25, ?慕; b 1/2
	t -25, -25, ?瘦; b 1/2
	t -50, -25, ?长; b 1/4
	t -62.5, -25, ?叔; b 3/4
end
tp_chain 100, 0, beat_speed: 50 do
	t 75, 0, ?立; b 1/2

	t 50, 0, ?正; b 1/2
	t 25, 0, ?就; b 1/2
	t 0, 0, ?把; b 1/2
	t -25, 0, ?人; b 1/2
	t -50, 0, ?吓; b 1/2
	t -75, 0, ?哭; b 1/4
end
tp_chain 0, 100, beat_speed: 50 do
	t -75, 0, ?哭; b 5/4
end

tp_chain 0, 100, beat_speed: 50 do
	t 50, 37.5, ?可; b 1/4
	t 50, 25, ?宝; b 1/4
	t 50, 12.5, ?宝; b 1/2
	t 50, -12.5, ?生; b 1/2
	t 50, -37.5, ?来; b 1/2
end
tp_chain 0, 100, beat_speed: 50 do
	t -50, 37.5, ?贪; b 1/4
	t -50, 25, ?吃; b 1/4
	t -50, 12.5, ?贪; b 1/2
	t -50, -12.5, ?喝; b 1/2
	t -50, -37.5, ?长; b 1/4
	t -50, -50, ?得; b 1/4
end

tp_chain 100, 0, beat_speed: 50 do
	t 50, 50, ?有; b 1/2
	t 25, 50, ?点; b 1/2
	turntable 1
	f 0, 50, :left, ?圆; b 1/2
	group preserve_beat: false do
		b -1/2 + 1/8
		(1..8).each do |i|
			angle = PI*i/8
			d -50*sin(angle), 50*cos(angle); b 1/8
		end
	end
end
tp_drop 100, 0, beat_speed: 50 do
	f 0, 0, :right, ?嘟; b 1/2
	f 0, 0, :right, ?嘟; b 3/2
end
tp_chain 0, 100, 1 do
	t 75, 50, ?我; b 1/4
	t 50, 50, ?出; b 1/4

	f 50, 25, :right, ?道; b 1
	t 0, 25, ?时; b 1/2
	t -25, 0, ?间; b 1/2
	t -50, -25, ?不; b 1/2
	t -75, -50, ?算; b 1/4
	t -100, -50, ?久; b 3/4
end
tp_chain 0, 100, 1 do
	t -75, 50, ?想; b 1/2

	t -50, 30, ?看; b 1/2
	t -25, 10, ?齐; b 1/2
	t 0, -10, ?榜; b 1/2
	t 25, -30, ?样; b 1/2
	t 50, -50, ?加; b 1/2
	t 80, -50, ?油; b 1/4
end
tp_chain 0, 100, 1 do
	t 80, -50, ?油; b 5/4
end

tp_chain 0, -100, beat_speed: 50, preserve_beat: false do
	t 37.5, -50; b 1/2
	t 37.5, -25; b 1/2
	t 37.5, 0; b 1/2
	t 37.5, 25; b 1/2
	t 37.5, 50; b 1/2
end
tp_chain 0, -100, beat_speed: 50 do
	t -37.5, -50, ?可; b 1/2
	t -37.5, -25, ?恨; b 1/2
	t -37.5, 0, ?人; b 1/2
	t -37.5, 25, ?类; b 1/2
	t -37.5, 50, ?一; b 1/2
	t 0, 25, ?直; b 1/4
	t 0, 0, ?对; b 3/4
end
tp_chain 100, 0, beat_speed: 50, preserve_beat: false do
	t 37.5, -37.5; b 1/2
	
	t 12.5, -37.5; b 1/2
	t -12.5, -37.5; b 1/2
	t -37.5, -37.5; b 1/2
end
tp_chain 100, 0, beat_speed: 50 do
	t 37.5, 37.5, ?宝; b 1/2

	t 12.5, 37.5, ?宝; b 1/2
	t -12.5, 37.5, ?尊; b 1/2
	t -37.5, 37.5, ?重; b 1/2
end
tp_chain -50, 50, beat_speed: 100*sqrt(2) do
	f -50, 50, :down_right, ?不; b 1/8
	(1..8).each do |i|
		d -50+12.5*i, 50-12.5*i; b 1/8
	end
end
b -1/8-1/2
tp_chain 50, 50, beat_speed: 100*sqrt(2) do
	f 50, 50, :down_left, ?够; b 1/8
	(1..8).each do |i|
		d 50-12.5*i, 50-12.5*i; b 1/8
	end
end
b -1/8+1/2
tp_chain 0, -100, beat_speed: 100, preserve_beat: false do
	b 1/2

	b 1/2
	t 25, -37.5; b 1/2
	t 25, 0; b 1/2
	t 25, 37.5; b 1/2
end
tp_chain 0, -100, beat_speed: 100 do
	t 0, -25, ?都; b 1/4
	t 0, 0, ?说; b 1/4
	
	t 0, 25, ?一; b 1/2
	t -25, 37.5, ?拳; b 1/2
	t -25, 0, ?能; b 1/2
	t -25, -37.5, ?打; b 1/2
	f -50, 0, :right, ?十; 
	(1..4).each do |i|
		b 1/8; d -50+25*i, 0
	end
	bg_note 25, 50, 0, ?个; b 1/4
	f 0, 50, :down, ?我
	(1..4).each do |i|
		b 1/8; d 0, 50-25*i
	end
	b 1/4
end
bg_note -25, 50, 0, ?全; b 1/2

def cross
	tp_chain -100, 50, relative_beat: 1/2, preserve_beat: false do
		t -100, 50; b 1/8
		(1..8).each do |i|
			d -100+25*i, 50-12.5*i; b 1/8
		end
	end
end
bg_note 0, 50, 0, ?是
cross; b 3/4
bg_note 0, 25, 0, ?胡
transform(cross) { horizontal_flip }; b 3/4
bg_note 0, -37.5, 0, ?扯
cross; b 1/2
bg_note 0, -37.5, 0, ?扯
transform(cross) { horizontal_flip }; b 3/2
hexagon 7
tp_chain 0, 100, 1, preserve_beat: false do
	b 1/2
	b 4

	t 50/sqrt(3), 25; b 3/4
	t 0, 0, ?身; b 1/4
	t 75/sqrt(3), -25; b 1/2
	t 50/sqrt(3), -50; b 1/2
	h 50, 0, 1; b 3/2
end
tp_chain 0, 100, 1 do
	t 0, 0, ?在; b 1/2

	t -50/sqrt(3), 50, ?万; b 1/4
	t -75/sqrt(3), 25, ?圣; b 1/4
	t -100/sqrt(3), 0, ?节; b 1/2
	t -75/sqrt(3), -25, ?之; b 1/2
	t -50/sqrt(3), -50, ?夜; b 1/2
	t 50/sqrt(3), -50, ?将; b 1/4
	t 75/sqrt(3), -25, ?会; b 1/4
	t 100/sqrt(3), 0, ?迎; b 1/2
	t 75/sqrt(3), 25, ?来; b 1/2
	t 50/sqrt(3), 50, ?我; b 1/2
	t -50/sqrt(3), 25, ?翻; b 1/2
	t 0, 0, ?身; b 1/2
	t -75/sqrt(3), -25, ?的; b 1/2
	t -50/sqrt(3), -50, ?时; b 1/2
	h -50, 0, 1, ?刻; b 3/2
end
tp_chain -100, 0, 1 do
	t -50, 25, ?天; b 1/2

	group preserve_beat: false do
		75.step -75, -12.5 do |y|
			(-125).step 125, 12.5 do |x|
				bg_note x, y, 7; b 1/64
			end
			b -1/8
		end
	end
	f -25, 25, :right, ?黑; b 1
	t -25, -25, ?闭; b 1/2
	t 25, -25, ?眼; b 1/2
	t 25, -25, ?眼; b 1
	t 75, 25, ?小; b 1/2
	t 50, 25, ?心; b 1/2

	checkerboard 12
	t 25, 25, ?有; b 1
	t -50, 0, ?危; b 1/2
	t 0, 0, ?险; b 1/2
	h 0, 0, 1, ?险; b 2
end

tp_chain 0, -100, 1 do
	t 37.5, 37.5, ?谁; b 3/4
	t 0, 37.5, ?要; b 3/4
	t -37.5, 37.5, ?敢; b 1/2
	t -37.5, 12.5, ?嘴; b 3/4
	t -37.5, -12.5, ?贱; b 3/4
end
tp_chain -100, 0, 1 do
	t -37.5, -12.5, ?贱; b 1/2
	t -37.5, -37.5, ?吃; b 3/4
	t 0, -37.5, ?我; b 3/4
	t 37.5, -37.5, ?一; b 1/2
	t 37.5, -12.5, ?顿; b 3/4
	t 37.5, 25, ?小; b 3/4
	t 0, 37.5, ?拳; b 1/2
end

tp_chain 0, 100, 1 do
	f 0, 37.5, :up, ?拳; b 1
end
tp_chain -100, 0, 1 do
	t -50, 50, ?别; b 1/2
	t -50, 25, ?意; b 1/2
	t -50, 0, ?外; b 1
	t 0, 25, ?别; b 1/2
	t 0, 0, ?被; b 1/2

	t 0, -25, ?我; b 3/4
	t 50, 37.5, ?身; b 1/4
	t 50, 25, ?份; b 1/2
	t 50, 0, ?惊; b 1/2
	t 50, -25, ?呆; b 1/2
	t 50, -25, ?呆; b 1
end
tp_chain 0, -100, 1 do
	t 62.5, 25, ?宝; b 1/4
	t 50, 25, ?宝; b 1/4
	
	f 37.5, 25, :up, ?就; b 3/4
	t 0, 25, ?是; b 3/4
	t -37.5, 25, ?都; b 1/2
	t 25, 0, ?市; b 3/4
	t -12.5, 0, ?传; b 3/4
	t -50, 0, ?说; b 1/2

	h -75, 0, 1, ?中; b 3/2
end
tp_chain 0, 100, 1 do
	t 87.5, -25, ?大; b 1/4
	t 75, -25, ?名; b 1/4
	t 62.5, -25, ?鼎; b 3/4
	t 25, -25, ?鼎; b 3/4
	t 0, -25, ?的; b 1/2
end

yyg = tp_chain 50, 0, beat_speed: 150 do
	3.times do
		f -25, 0, :up_left, ?嘤; b 1/3
		f 25, 0, :up_right, ?嘤; b 1/3
		f -25, 0, :down_left, ?嘤; b 1/3
		f 25, 0, :down_right, ?嘤; b 1/3
	end
	
	big_text 3, '怪'
	b 1/2
	h 0, 0, 1; b 2
end
notes = tp_drop -100, 0, 1 do
	t -25, -50; b 1/2
	t -25, -25; b 1/2
	t -25, 0; b 1/2
end
transform duplicate notes do
	horizontal_flip
	translate 0, 12.5
	beat_translate 1/4
end

tp_chain 0, 50, beat_speed: 50, preserve_beat: false do
	3.times do
		t -100, -25; b 1
		t -50, -25; b 1
		t -50, 25; b 1
		t -100, 25; b 1
	end
end
tp_chain 100, 0, 1 do
	t 50, 25, ?会; b 1/2
	t 75, -25, ?恶; b 1/4
	t 100, 0, ?心; b 1/4
	t 100, 0, ?心; b 1/2
	t 25, -50, ?也; b 1/4
	t 50, -25, ?会; b 1/4
	t 75, 0, ?锤; b 1/2
	t 37.5, 37.5, ?你; b 1/2
	t 0, 0, ?胸; b 1/2
	t 0, 0, ?胸; b 1/2

	t 37.5, -37.5, ?非; b 3/4
	t 75, 0, ?常; b 3/4
	t 100, 25, ?嘀; b 1/2
	t 50, 25, ?坏; b 3/4
	t 50, 25, ?坏; b 5/4

	t 87.5, -25, ?虽; b 1/2
	t 50, 25, ?然; b 1/4
	t 25, 0, ?外; b 1/4
	t 0, -25, ?表; b 1/2
	t 25, -50, ?看; b 1/2
	t 50, 0, ?起; b 1/2
	t 75, -50, ?来; b 1/2
	t 100, 0, ?真; b 1/2
	t 50, 50, ?嘀; b 1/2
end

bg_note 0, 25, 0, ?可
notes = tp_chain 0, 100, 1 do
	f -25, 0, :up_left
	(1..6).each do |i|
		b 1/8;
		d -25-50.0/6*i, 50.0/6*i
	end
	b 1/4
end
notes.concat transform(duplicate notes) { horizontal_flip }
notes.concat transform(duplicate notes) { beat_translate 1 }
transform duplicate notes do
	vertical_flip
	beat_translate 2
end
bg_note 0, 25, 0, ?可; b 1
bg_note 0, -25, 0, ?爱; b 1
bg_note 0, -25, 0, ?爱; b 1

tp_chain 0, 50, beat_speed: 50, preserve_beat: false do
	3.times do
		t 100, -25; b 1
		t 50, -25; b 1
		t 50, 25; b 1
		t 100, 25; b 1
	end
end
tp_chain 100, 0, 1 do
	t -50, 25, ?但; b 1/2
	t -75, -25, ?没; b 1/4
	t -100, 0, ?糖; b 1/4
	t -100, 0, ?糖; b 1/2
	t -25, -50, ?我; b 1/4
	t -50, -25, ?才; b 1/4
	t -75, 0, ?不; b 1/2
	t -37.5, 37.5, ?当; b 1/2
	t 0, 0, ?什; b 1/2
	t -37.5, -37.5, ?么; b 1/2

	t -75, 0, ?纯; b 3/4
	t -25, 50, ?良; b 3/4
	t -25, -25, ?嘀; b 1/2
	t -50, -37.5, ?小; b 3/4
	t -75, 0, ?乖; b 3/4
	t -75, 0, ?乖; b 1/2

	t -87.5, -25, ?一; b 1/2
	t -50, 25, ?整; b 1/4
	t -25, 0, ?晚; b 1/4
	t 0, -25, ?吓; b 1/2
	t -25, -50, ?人; b 1/2
	t -50, 0, ?大; b 1/2
	t -75, -50, ?作; b 1/2
	t -100, 0, ?战; b 1/2
end
checkerboard 3
tp_chain -100, 0, beat_speed: 50, preserve_beat: false do
	t -37.5, -37.5; b 1/2

	t -12.5, -37.5; b 1/2
	t 12.5, -37.5; b 1/2
	t 37.5, -37.5; b 1/2
	f -37.5, 0, :left; b 1/2
	f 37.5, 0, :right; b 1/2
end
tp_chain -100, 0, beat_speed: 50, preserve_beat: false do
	t 37.5, 37.5, ?绝; b 1/2

	t 12.5, 37.5, ?不; b 1/2
	t -12.5, 37.5, ?能; b 1/2
	t -37.5, 37.5, ?失; b 1/2
	f 37.5, 0, :right; b 1/2
	f -37.5, 0, :left; b 1/2
end
b 1/2

b 3/2
bg_note 0, 0, 0, ?败; b 1/2
bg_note 0, 0, 0, ?败; b 1/2
tp_chain 0, 100, 1, preserve_beat: false do
	t 0, -25; b 1/2
	4.times do
		h -50, 25, 1/2, ?嘤; b 1

		h -75, 0, 5/2, ?嘤; b 3
	end
	4.times do |i|
		h 50, 25, 1/2, ?嘤; b 1

		h 75, 0, (i==3?3/2:5/2), ?嘤; b(i==3?2:3)
	end
	t 0, 50; b 1/2
	t 50, 0; b 1/2
	f 0, 50, :right
end
b 3/2

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 50, ?万; b 1/2
	t 0, 25, ?圣; b 1/2
	t 0, 0, ?节; b 1/2
	t 0, -25, ?鬼; b 1/2
	t 25, 0, ?怪; b 1/4
	t 37.5, 12.5, ?大; b 1/2
	t 62.5, 37.5, ?狂; b 1/4
	t 75, 50, ?欢; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 25, ?嘤; b 1/2
	t 0, 25, ?嘤; b 1/2
	t 0, 0, ?怪; b 1/2
	t 0, -25, ?也; b 1/2
	t 25, 0, ?要; b 1/4
	t 37.5, 12.5, ?捣; b 1/2
	t 62.5, 37.5, ?蛋; b 1/4
	t 62.5, 37.5, ?蛋; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 0, ?宝; b 1/2
	t 0, 0, ?宝; b 1/2
	t 0, -25, ?的; b 1/2
	t 0, -50, ?超; b 1/2
	t 25, -25, ?恐; b 1/4
	t 37.5, -12.5, ?怖; b 1/2
	t 62.5, 12.5, ?作; b 1/4
	t 75, 25, ?战; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 25, 50, ?一; b 1/2
	t 25, 25, ?定; b 1/2
	t 25, 0, ?能; b 1/2
	t 25, -25, ?吓; b 1/2
	t 0, 0, ?破; b 1/4
	t -12.5, 12.5, ?你; b 1/2
	t -37.5, 0, ?胆; b 1/4
	t -37.5, 0, ?胆; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	bg_note 0, 50, 0, ?要; b 1/2
	f 0, 25, :left, ?是; b 1/2
	t 0, 0, ?不; b 1/2
	t 0, -25, ?吓; b 1/2
	t -25, 0, ?人; b 1/4
	t -37.5, 12.5, ?怎; b 1/2
	t -62.5, 37.5, ?么; b 1/4
	t -75, 50, ?办; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 25, ?才; b 1/2
	t 0, 0, ?不; b 1/2
	t 0, -25, ?会; b 1/2
	t 0, -50, ?哭; b 1/2
	t 0, -50, ?哭; b 1/4
	t -12.5, -37.5, ?给; b 1/2
	t -37.5, -12.5, ?你; b 1/4
	t -50, 0, ?看; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 0, ?吃; b 1/2
	t 0, -25, ?饱; b 1/2
	t 0, -25, ?饱; b 1/2
	t 0, -50, ?再; b 1/2
	t -25, -25, ?解; b 1/4
	t -37.5, -12.5, ?决; b 1/2
	t -62.5, 12.5, ?困; b 1/4
	t -75, 25, ?难; b 1/2
end

tp_chain 0, 100, beat_speed: 50 do
	b 1/2
	t 0, 0, ?先; b 1/2
	t 0, -25, ?干; b 1/2
	t 0, -50, ?饭; b 1/2
	turntable
	t 0, -50, ?饭; b 1/2
	turntable
	t -50, 0; b 1/2
	turntable 1/2
	f 0, -50, :left; b 1
end

tp_drop 0, 75, 1 do
	h 50, -25, 3; b 3
	h -50, -25, 1/2; b 1/2
	h 50, -25, 1/2; b 1/2

	h -25, -25, 3/2; b 3/2
	h 25, -25, 5/2; b 5/2

	h -50, -25, 5/2; b 5/2
	t 25, -25; b 1/4
	t -25, -25; b 1/4
	t 37.5, -25; b 1/4
	t -12.5, -25; b 1/4
	t 25, -25; b 1/4
	t -25, -25; b 1/4

	t 50, -25; b 1/2
	t -37.5, -25; b 1/2
	t 37.5, -25; b 1/2
	h -12.5, -25, 3/2; b 5/2
end

tp_drop 0, -75, 1 do
	h 50, 25, 3; b 3
	h -50, 25, 1/2; b 1/2
	h 50, 25, 1/2; b 1/2

	h -25, 25, 7/4; b 7/4
	t 37.5, 25; b 1/4
	h -12.5, 25, 3/2; b 2

	h 50, 25, 3/2; b 3/2
	t -50, 25; b 1/2
	h -50, 25, 1/2; b 1/2
	t 25, 25; b 1/4
	t -37.5, 25; b 1/4
	t 37.5, 25; b 1/4
	t -12.5, 25; b 1/4
	t 50, 25; b 1/4
	t 0, 25; b 1/4

	f 50, 25, :right; b 3/4
	f -12.5, 25, :left; b 3/4
	f -50, 25, :left; f 12.5, 25, :right; b 1/2
end
b 1/2
notes = tp_drop -100, 0, 1 do
	t -25, 50; b 1/2
	t -25, 25; b 1/2
	t -25, 0; b 1/2
end
transform duplicate notes do
	horizontal_flip
	translate 0, -12.5
	beat_translate 1/4
end

=begin
notes = tp_chain 0, 100, 1 do
	t -50, -37.5; b 3/8
	t -25, -12.5; b 3/8
	t 0, 12.5; b 1/4
	h 25, 12.5, 1/2; b 5/4
	t 75, 50; b 1/4
	t 100, 50; b 1/2
	t 0, 37.5; b 1/4
	t 50, 0; b 1/4
	t -25, 12.5; b 1/4
	t 25, -25; b 1/4
end

transform duplicate notes do
	rotate PI
	beat_translate 4
end
b 4

transform duplicate notes do
	horizontal_flip
	translate 0, -12.5
	beat_translate 8
end
b 4

tp_chain 0, -100, 1 do
	t -100, 50; b 1/2
	t -75, 25; b 1/2
	t -50, 0; b 1/2
	t -25, 50; b 1/2
	t 100, 50; b 1/4
	t 25, 37.5; b 1/4
	t 87.5, 25; b 1/4
	t 12.5, 12.5; b 1/4
	t 75, 0; b 1/4
	t 0, -12.5; b 1/4
	t 62.5, -25; b 1/4
	t -12.5, -37.5; b 1/4
end

transform duplicate notes do
	rotate PI
	beat_translate 16
end
b 4

transform duplicate notes do
	beat_translate 20
end
b 4

notes = tp_chain 0, 100, 1 do
	t 50, 37.5; b 3/8
	t 25, 12.5; b 3/8
	t 0, -12.5; b 1/4
	h -25, -12.5, 1/2; b 1
	t 50, 0; b 3/8
	t 25, 25; b 3/8
	t 0, 50; b 1/4
	h -25, 50, 1/2; b 1

	t -25, -50; b 1/4
	t 25, -37.5; b 1/4
	t -25, -25; b 1/4
	t 25, -12.5; b 1/4
	t -25, 0; b 1/4
	t 25, 12.5; b 1/4
	t -25, 25; b 1/4
	t 25, 37.5; b 1/4
	t -25, 50; b 1/4
	t 75, 37.5; b 1/4
	t -75, 25; b 1/4
	t 25, 12.5; b 1/4
	t -25, 0; b 1/4
	t 75, -12.5; b 1/4
	t -75, -25; b 1/4
	t 25, -37.5; b 1/4
end
=end

tp_chain 0, 100, 1, preserve_beat: false do
	t 50, 37.5, ?建; b 1
	t 50, 0, ?一; b 1/2
	t 50, -25, ?座; b 1/2
	t 50, -50, ?鬼; b 1/2
	t 50, -50, ?鬼; b 1/4
	t 62.5, -50, ?屋; b 3/4
	t 75, 50, ?招; b 1/2

	t 75, 25, ?募; b 1/2
	t 75, 0, ?冒; b 1/2
	t 75, -25, ?险; b 1/2
	t 75, 50, ?者; b 1/2
	t 50, 12.5, ?散; b 1/2
	t 50, -12.5, ?步; b 1/4
	t 50, -12.5, ?步; b 5/4
end
tp_chain 0, 100, 1 do
	t -50, 37.5; b 1
	t -50, 0; b 1/2
	t -50, -25; b 1/2
	t -50, -50; b 1/2
	t -50, -50; b 1/4
	t -62.5, -50; b 3/4
	t -75, 50; b 1/2

	t -75, 25; b 1/2
	t -75, 0; b 1/2
	t -75, -25; b 1/2
	t -75, 50; b 1/2
	t -50, 12.5; b 1/2
	t -50, -12.5; b 1/4
	t -50, -12.5; b 5/4
end

tp_chain 0, 100, 1, preserve_beat: false do
	t 0, 12.5, ?老; b 1/2
	t 25, 25, ?套; b 1/2
	t 50, 37.5, ?手; b 1/2
	t 75, 50, ?法; b 1/2
	t 0, 12.5, ?都; b 1/2
	t -25, 25, ?淘; b 1/4
	t -37.5, 31.25, ?汰; b 3/4
end
tp_chain 0, -100, 1 do
	t 0, -12.5; b 1/2
	t -25, -25; b 1/2
	t -50, -37.5; b 1/2
	t -75, -50; b 1/2
	t -0, -12.5; b 1/2
	t 25, -25; b 1/4
	t 37.5, -31.25; b 3/4
end
tp_chain 100, 0, beat_speed: 75, preserve_beat: false do
	t 50, 25, ?要; b 1/2

	t 50/3, 25, ?吓; b 1/2
	t -50/3, 25, ?出; b 1/2
	t -50, 25, ?新; b 1/2
end
tp_chain 100, 0, beat_speed: 75 do
	t 50, -25; b 1/2

	t 50/3, -25; b 1/2
	t -50/3, -25; b 1/2
	t -50, -25; b 1/2
	bg_note -25, 50, 0, ?高
	f -75, -25, :up_right; b 1/8
	(1..3).each do |i|
		d -75+75*i/4, -25+75*i/4; b 1/8
	end
	f 0, 50, :right, ?度
	(1..8).each do |i|
		b 1/8
		d 100*i/8, 50
	end
	b 1/2
end
tp_chain -100, -100, beat_speed: 50*sqrt(2), preserve_beat: false do
	t -75, -25, ?乌; b 1/4
	t -62.5, -12.5, ?鸦; b 1/4

	t -50, 0, ?叫; b 1/2
	b 1/2
	f 50, -25, :up_left, ?嘎; b 1/8
	(1..3).each do |i|
		d 50-75*i/4, -25+75*i/4; b 1/8
	end
	b 1/2
	t -50, 0; b 1/2
	t -50, -37.5; b 1/4
	t -50, -37.5; b 3/4
end
tp_chain 0, 100, 1 do
	b 1/2

	t 50, 0; b 1/2
	f 50, -25, :up_left, ?嘎; b 1/8
	(1..3).each do |i|
		d 50-75*i/4, -25+75*i/4; b 1/8
	end
	b 1/2
	t 50, 37.5, ?太; b 1/2
	t 50, 0, ?儍; b 1/2
	t 50, -37.5, ?呼; b 1/4
	t 50, -37.5, ?呼; b 3/4
end
tp_chain 0, 100, 1, preserve_beat: false do
	t -75, -50, ?调; b 1/2

	h -50, 25, 1/2, ?出; b 3/4
	h 25, 50, 1/2, ?氛; b 3/4
	t 75, 50, ?围; b 1/2
	h 100, 25, 1, ?组
	(1..8).each do |i|
		b 1/8
		angle = PI/8*i
		d 100-25*sin(angle), -12.5+37.5*cos(angle)
	end
end
tp_chain 0, -100, 1 do
	b 1/2

	h -25, -50, 1/2; b 3/4
	h 50, -25, 1/2; b 3/4
	b 1/2
	h -100, -25, 1
	(1..8).each do |i|
		b 1/8
		angle = PI/8*i
		d -100+25*sin(angle), 12.5-37.5*cos(angle)
	end
end
b 1/2
grid 8+1/2
tp_chain 100, 0, beat_speed: 100, preserve_beat: false do
	b 1/2

	t -50, 50; b 1
	t -50, -50; b 1
	t 50, -50; b 1
	t 50, 50; b 1

	b 1/4
	t -50, -37.5; b 1/2
	t -50, -12.5; b 1/2
	t -50, 12.5; b 1/2
	t -50, 37.5; b 1/4
end
tp_chain -50, 0, beat_speed: 100, preserve_beat: false do
	t 0, -50, ?不; b 1/2
	
	t 50, -50, ?如; b 1/4
	t 50, -25, ?换; b 1/4
	t 50, 0, ?成; b 1/2
	t 50, 50, ?八; b 1/2
	t 0, 50, ?哥; b 1/2
	t -50, 50, ?大; b 1/4
	t -50, 25, ?骂; b 1/4
	t -50, 0, ?来; b 1/2
	t -50, -50, ?客; b 1/2
	t 0, -50, ?说; b 1/2

	t 50, -50; b 1/2
	t 50, -25; b 1/2
	t 50, 0; b 1/2
	t 50, 25; b 1/2
end
b 1/2

b 4

notes = group preserve_beat: false do
	b 2
	tp_chain -100, -100, beat_speed: 100*sqrt(2) do
		t 75, 50; b 1/2
	end
	tp_chain -100, -100, beat_speed: 100*sqrt(2) do
		t 25, 25; b 1/8; d 37.5, 37.5; b 3/8
	end
	tp_chain -100, -100, beat_speed: 100*sqrt(2) do
		t 75, 0; b 1/8; d 87.5, 12.5; b 3/8
	end
	tp_chain -100, -100, beat_speed: 100*sqrt(2) do
		t 25, -25; b 1/8; d 37.5, -12.5; b 3/8
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 1/4
	translate 0, -12.5
end
bg_note 0, 50, 0, ?他; b 1/2
bg_note 0, 25, 0, ?们; b 1/4
bg_note 0, 0, 0, ?是; b 1/4
bg_note 0, -25, 0, ?臭; b 1/2
bg_note 0, -50, 0, ?猪; b 1/2
bg_note 0, -50, 1, ?猪; b 3/2
bg_note 75, -25, 0, ?蹿; b 1/2

def f_drag x, y, text
	tp_chain 0, 100, beat_speed: 50, preserve_beat: false do
		f x, y, :up_right, text; b 1/8
		d x+12.5, y+12.5; b 1/8
		d x+25, y+25
	end
end
group preserve_beat: false do
	f_drag 75, -50, ?过; b 1
	bg_note 50, 50, 0, ?你; b 1/2
	bg_note 50, 25, 0, ?脚; b 1/2
	f_drag 50, 0, ?边; b 1
	bg_note 25, 25, 0, ?是; b 1/2
	bg_note 25, 0, 0, ?一; b 1/2

	f_drag 25, -25, ?群; b 1
	bg_note 50, -25, 0, ?仓; b 1/2
	bg_note 50, -50, 0, ?鼠; b 1/2
	f_drag 50, -50, ?鼠; b 2

	f_drag 50, 25, ?洗; b 3/4
	bg_note 50, 0, 0, ?劫; b 3/4
	bg_note 50, -25, 0, ?你; b 1/2
	f_drag 75, 0, ?的; b 3/4
	bg_note 75, -25, 0, ?零; b 3/4
	bg_note 75, -50, 0, ?食; b 1/2

	tp_chain 0, 100, beat_speed: 50 do
		h 100, -25, 1/2, ?把
	end
	b 3/4
	bg_note 100, -50, 0, ?脸; b 3/4
	bg_note 100, -50, 0, ?脸; b 1/2
	b 3/4
	bg_note 75, -25, 0, ?得; b 3/4
	bg_note -75, 50, 0, ?鼓; b 1/2
end
tp_drop 0, 100, 1 do
	b 1
	h -75, 25, 1/2; b 1
	b 1
	h -50, 0, 1/2; b 1

	b 1
	t -75, -25; b 1/2
	t 25, -25; b 1/4
	t 0, -37.5; b 1/4
	b 1
	h -100, 0, 1/2; b 1

	b 1
	t -75, 25; b 1/2
	t -50, 50; b 1/2
	b 1
	h -50, 0, 1/2; b 1

	b 3/4
	h 25, 0, 1/2; b 3/4
	t -50, 25; b 1/2
	b 2
end

tp_chain 0, 100, beat_speed: 50, preserve_beat: false do
	b -2
	h 75, 0, 5/4, ?塞; b 1/2
	(0...12).each do |i|
		d 75-150*i/12, 50*(1-(1-i/12)**2)
		b 1/8
	end

	f -75, 50, :down, ?鼓; b 1
	h -50, 25, 1/2; b 1
	h 75, 0, 1/2; b 1
	h -50, -25, 1/2; b 1

	h 75, 25, 1; b 3/2
	t 0, 0; b 1/4
	t 25, 25; b 1/4
	t 50, 50; b 1/2
	t 37.5, 50/3; b 1/2
	t 37.5, -50/3; b 1/2
	f 50, -50, :right; b 1/2

	f 25, 0, :right
end

b 1
bg_note 0, 25, 0, ?一; b 1/2
bg_note 0, 0, 0, ?开; b 1/2
bg_note 0, -25, 0, ?门; b 1
bg_note 25, 50, 0, ?谁; b 1/2
bg_note 25, 25, 0, ?能; b 1/2

bg_note 25, 0, 0, ?想; b 3/4
bg_note 25, -25, 0, ?到; b 1/4
bg_note 75, 25, 0, ?迎; b 1/2
bg_note 75, 0, 0, ?面; b 1/2
group preserve_beat: false do
	bg_note 75, -25, 0, ?飞; b 1/2
	bg_note 75, -50, 0, ?出; b 1
	bg_note 0, 25, 0, ?小; b 1/4
	bg_note 0, 0, 0, ?伙; b 1/4

	bg_note 0, -25, 0, ?伴; b 3/4
	bg_note 0, -50, 0, ?们; b 3/4
	bg_note 25, 25, 0, ?最; b 1/2
	bg_note 25, 0, 0, ?怕; b 3/4
	bg_note 25, 0, 0, ?怕; b 3/4
	bg_note 25, -25, 0, ?生; b 1/2

	bg_note 25, -50, 0, ?物; b 3/2
	bg_note -62.5, -25, 0, ?一; b 1/4
	bg_note -37.5, -25, 0, ?大; b 1/4
	bg_note -12.5, -25, 0, ?群; b 3/4
	bg_note 12.5, -25, 0, ?鸽; b 3/4
	bg_note 37.5, -25, 0, ?子; b 1/2

	bg_note 62.5, -25, 0, ?在; b 2
	bg_note 0, 25, 1/2, ?咕; b 1
	bg_note 0, 25, 1/2, ?咕; b 1
end
tp_chain -100, 0, 1 do
	t -50, -50; b 1/2
	t -37.5, -50/3; b 1/2
	t -37.5, 50/3; b 1/2
	f -50, 50, :left; b 1/2

	f -25, 0, :left; b 1/2
	t -75, 50; b 1/4
	t -50, 37.5; b 1/4
	t -62.5, 12.5; b 1/2
	t 75, 25; b 1/4
	t 50, 12.5; b 1/4
	t 62.5, -12.5; b 1/2
end
total_angle = 5.0
initial_angle = 1.5*PI - total_angle
tp_chain 0, 100, 1, preserve_beat: false do
	b 1/4
	(0...11).each do |i|
		angle = initial_angle + (1-(1-(i+0.5)/11)**2) * total_angle
		t 50+50*sin(angle), -50*cos(angle)
		b 1/2
	end
end
tp_chain 0, 100, 1 do
	(0...11).each do |i|
		angle = initial_angle + (1-(1-i/11)**2) * total_angle
		x, y = -50-50*sin(angle), -50*cos(angle)
		if [3, 5, 7, 9].include? i
			f x, y, :left
		else
			t x, y
		end
		b 1/2
	end
end
diamond_grid 3+1/2
tp_drop 0, -100, 1 do
	12.times do |i|
		f 0, 0, %i[left right][i%2]; b 1/4
	end
end
def out_f ux, uy
	tp_chain ux*100, uy*100, 1 do
		f ux*25, uy*25, atan2(uy, ux)
	end
end
out_f -1, 1; b 1/4
out_f 1, 1; b 1/4
out_f -1, -1; b 1/4
out_f 1, -1; b 1/4

big_text 3, ?咕
tp_chain 0, 0, 0 do
	h 0, 0, 3; b 3/4
	26.times do |i|
		next b 1/8 if i == 1
		r = (1-(1-i/26)**2)*50
		angle = i/26*PI*4
		d -(1+(i/26)**2)*r*cos(angle), r*sin(angle)
		b 1/8
	end
end

tp_chain 50, 100, beat_speed: 25*sqrt(5), preserve_beat: false do
	3.times do
		t -100, 0; b 1
		t -75, -50; b 1
		t -50, 0; b 1
		t -75, 50; b 1
	end
end
tp_chain 0, 100, 1 do
	t 0, 25, ?今; b 1/2
	t 0, -25, ?晚; b 1/4
	t 25, 0, ?的; b 1/4
	t 50, 25, ?客; b 1/2
	t 50, -25, ?人; b 1/4
	t 75, 0, ?都; b 1/4
	t 100, 25, ?超; b 1/2
	t 25, 12.5, ?有; b 1/2
	t 50, -50, ?病; b 1/2
	t 50, -50, ?病; b 1/2

	t 100, -25, ?全; b 3/4
	t 50, 25, ?都; b 3/4
	t 25, -50, ?疯; b 1/2
	t 37.5, -12.5, ?癫; b 3/4
	t 37.5, -12.5, ?癫; b 5/4

	t 100, -50, ?他; b 1/2
	t 100, 25, ?教; b 1/4
	t 75, 0, ?会; b 1/4
	t 50, -25, ?巴; b 1/2
	t 12.5, -50, ?哥; b 1/2
	t 25, 25, ?怪; b 1/2
	t 25, 25, ?怪; b 1/2
	t 75, -25, ?口; b 1/2
	t 0, -25, ?癖; b 1/2
end

def horizontal_stroke x, y, n, text
	tp_chain -100, 0, beat_speed: 75, preserve_beat: false do
		f x, y, :right, text
		(1...n).each do |i|
			b 1/8
			d x+75/8*i, y
		end
	end
end
horizontal_stroke -87.5, 0, 8, ?一; b 1
horizontal_stroke 12.5, 37.5, 8, ?键; b 1
horizontal_stroke 12.5, -37.5, 8, ?三; b 1
horizontal_stroke 37.5, 0, 4, ?连; b 1

tp_chain -50, 100, beat_speed: 25*sqrt(5), preserve_beat: false do
	2.times do
		t 100, 0; b 1
		t 75, -50; b 1
		t 50, 0; b 1
		t 75, 50; b 1
	end
	
	t 100, 0; b 1
	t 200/3, -50; b 1
	t 100/3, 0; b 1
	turntable 5
	t 0, 50; b 1/2
	f 25, 25*sqrt(3), :up_right; b 1/2

	f 25, -25*sqrt(3), :down_right; b 1/2
	f 25*sqrt(3), 25, :up_right; b 1/2
	f 25*sqrt(3), -25, :down_right; b 1/2
	f 50, 0, :right; b 1/2
	t 100, 0
end
tp_chain 0, 100, 1 do
	t 0, 25, ?她; b 1/2
	t 0, -25, ?主; b 1/4
	t -25, 0, ?动; b 1/4
	t -50, 25, ?把; b 1/2
	t -50, -25, ?仓; b 1/4
	t -75, 0, ?鼠; b 1/4
	t -100, 25, ?喂; b 1/2
	t -25, 50, ?到; b 1/2
	t -50, -50, ?想; b 1/2
	t -75, -12.5, ?吐; b 1/2

	t -100, 25, ?我; b 3/4
	t -25, 37.5, ?却; b 3/4
	t -50, -25, ?肚; b 1/2
	t -75, 12.5, ?子; b 3/4
	t -25, -37.5, ?扁; b 3/4
	t -25, -37.5, ?扁; b 1/2

	t 0, 50, ?一; b 1/2
	t -50, 50, ?整; b 1/4
	t -25, 25, ?晚; b 1/4
	t 0, 0, ?吓; b 1/2
	t -75, 0, ?人; b 1/2
	t -50, -37.5, ?大; b 1/2
	t -25, 12.5, ?作; b 1/2
	t 0, -50, ?战; b 1/2
	f -25, -25*sqrt(3), :down_left, ?离; b 1/2

	f -25, 25*sqrt(3), :up_left, ?成; b 1/2
	f -25*sqrt(3), -25, :down_left, ?功; b 1/2
	f -25*sqrt(3), 25, :up_left, ?还; b 1/2
	f -50, 0, :left, ?很; b 1/2
	t -100, 0, ?远; b 1/2
end
tp_chain 0, 100, 1, preserve_beat: false do
	t 0, 0; b 1/2
	4.times do
		h -50, 25, 1/2, ?嘤; b 1

		h -75, 0, 5/2, ?嘤; b 3
	end
	4.times do |i|
		h 50, 25, 1/2, ?嘤; b 1

		h 75, 0, (i==3?3/2:5/2), ?嘤; b(i==3?2:3)
	end
	t 0, 50; b 1/2
	t 50, 0; b 1/2
	f 0, 50, :left
end
b 3/2

tp_chain -100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 0, 25, ?万; b 1/2
	t 25, 0, ?圣; b 1/2
	t 50, -25, ?节; b 1/2
	t 75, -50, ?鬼; b 1/2
	t 75, -25, ?怪; b 1/4
	t 75, -12.5, ?大; b 1/2
	t 75, 12.5, ?狂; b 1/4
	t 75, 25, ?欢; b 1/2
end

tp_chain -100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 0, 25, ?嘤; b 1/2
	t 0, 25, ?嘤; b 1/2
	t 25, 0, ?怪; b 1/2
	t 50, -25, ?也; b 1/2
	t 50, 0, ?要; b 1/4
	t 50, 12.5, ?捣; b 1/2
	t 50, 37.5, ?蛋; b 1/4
	t 50, 37.5, ?蛋; b 1/2
end

tp_chain -100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 0, 25, ?宝; b 1/2
	t 0, 25, ?宝; b 1/2
	t 25, 0, ?的; b 1/2
	t 50, -25, ?超; b 1/2
	t 50, 0, ?恐; b 1/4
	t 50, 12.5, ?怖; b 1/2
	t 50, 37.5, ?作; b 1/4
	t 50, 50, ?战; b 1/2
end

tp_chain 100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 75, 25, ?一; b 1/2
	t 50, 0, ?定; b 1/2
	t 25, -25, ?能; b 1/2
	t 0, -50, ?吓; b 1/2
	t 0, -25, ?破; b 1/4
	t 0, -12.5, ?你; b 1/2
	t 0, 12.5, ?胆; b 1/4
	t 0, 12.5, ?胆; b 1/2
end

tp_chain 100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	bg_note 0, 25, 0, ?要; b 1/2
	f -25, 0, :left, ?是; b 1/2
	t -50, -25, ?不; b 1/2
	t -75, -50, ?吓; b 1/2
	t -75, -25, ?人; b 1/4
	t -75, -12.5, ?怎; b 1/2
	t -75, 12.5, ?么; b 1/4
	t -75, 25, ?办; b 1/2
end

tp_chain 100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 0, 25, ?才; b 1/2
	t -25, 0, ?不; b 1/2
	t -50, -25, ?会; b 1/2
	t -75, -50, ?哭; b 1/2
	t -75, -50, ?哭; b 1/4
	t -75, -37.5, ?给; b 1/2
	t -75, -12.5, ?你; b 1/4
	t -75, 0, ?看; b 1/2
end

tp_chain 100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t 0, 25, ?吃; b 1/2
	t -25, 0, ?饱; b 1/2
	t -25, 0, ?饱; b 1/2
	t -50, -25, ?再; b 1/2
	t -50, 0, ?解; b 1/4
	t -50, 12.5, ?决; b 1/2
	t -50, 37.5, ?困; b 1/4
	t -50, 50, ?难; b 1/2
end

tp_chain -100, 100, beat_speed: 50*sqrt(2) do
	b 1/2
	t -50, 0, ?先; b 1/2
	t -25, -25, ?干; b 1/2
	t 0, -50, ?饭; b 1/2
	turntable
	t 0, -50, ?饭; b 1/2
	turntable
	t -50, 0; b 1/2
	turntable
	f 0, -50, :right; b 1/2
end

group preserve_beat: false do
tp_chain 0, -100, 1 do
	t -12.5, 0; b 1/2

	h -37.5, 50, 1/2; b 1
	t -37.5, 0; b 1/2
	h -37.5, -25, 1/2; b 1
	t -25, -50; b 1/2
	t -12.5, -25; b 1/2
	t -50, 0; b 1/2

	h -50, 25, 1/2; b 1
	t -50, -25; b 1/2
	h -50, -50, 1/2; b 1
	b 1/4
	t -62.5, -12.5; b 1/2
	t -75, 12.5; b 1/2
	t -100, 37.5; b 1/4

	h -87.5, 50, 1/2; b 1
	t -87.5, 0; b 1/2
	h -87.5, -25, 1/2; b 1
	t -75, -50; b 1/2
	t -62.5, -25; b 1/2
	t -50, 12.5; b 1/2
	
	t -75, 50; b 1/2
	t -87.5, 25; b 1/2
	t -50, 12.5; b 1/2
	t -25, -12.5; b 1/2
	t -62.5, -25; b 1/2
	t 0, -37.5; b 1/2
	t 12.5, -12.5; b 1/2
	t -25, 25; b 1/2

	f -62.5, 37.5, :left; b 1/2
end
tp_chain -100, 0, 1 do
	t 75, 50; b 1
	h -12.5, 12.5, 1/2; b 1/2
	b 1/4
	t -37.5, -12.5; b 1/2
	t -50, -37.5; b 1/4
	b 1/2
	h -50, -50, 1/2; b 1/2

	b 3/4
	h -75, -25, 1/2; b 3/4
	b 1/2
end
tp_chain 100, 0, 1 do
	b 1/2
	t -75, 37.5; b 1/2
	b 1/2
	h 50, 25, 1/2; b 1/2

	b 1/4
	t 25, 12.5; b 1/2
	t 50, -12.5; b 1/2
	t 75, -37.5; b 1/2
	t 50, -37.5; b 1/2
	t 25, -12.5; b 1/2
	t 0, 12.5; b 1/2
	t 12.5, 37.5; b 1/2
	t -37.5, 37.5; b 1/4
end

tp_chain -100, 0, 1 do
	b 1/2
	t 75, 0; b 1
	t -75, 25; b 1/2
	f -75/sqrt(3), 25, :left; b 1/2
	f -75/sqrt(3), -25, :left; b 1/2
	f -100/sqrt(3), 0, :left; b 1
end
end
tp_chain 0, -100, 1 do
	b 1/4;
	t 12.5, 25; b 1/4

	h 37.5, 50, 1/2; b 1
	t 37.5, 0; b 1/2
	h 37.5, -25, 1/2; b 1
	b 1/4
	t 25, -37.5; b 1/2
	t 50, -12.5; b 1/2
	t 62.5, 12.5; b 1/4

	h 50, 25, 1/2; b 1
	t 50, -25; b 1/2
	h 50, -50, 1/2; b 1
	t 25, -25; b 1/2
	t 37.5, 0; b 1/2
	t 0, 25; b 1/2

	h 0, 50, 1/2; b 1
	t 0, 0; b 1/2
	h 0, -25, 1/2; b 1
	b 1/4
	t 25, -37.5; b 1/2
	t 12.5, 0; b 1/2
	t 37.5, 25; b 1/4

	b 1/4
	t 0, 37.5; b 1/2
	t 12.5, 12.5; b 1/2
	t -12.5, -12.5; b 1/2
	t 37.5, -25; b 1/2
	t 12.5, -50; b 1/2
	t 50, -12.5; b 1/2
	t 62.5, 25; b 1/2
	t 50, 50; b 1/4
end

tp_drop -100, 0, 1 do
	b 3/4
	t 75, 50; b 1/4
end
tp_chain -100, 0, 1 do
	t 75, 50; b 1/2
	b 1/2
	t 37.5, 25; b 1/2
	t 12.5, 0; b 1/2
	h 25, -25, 1/2; b 1/2
	b 1/2

	h 75, -50, 1/2; b 3/4
	b 3/4
	h 50, 25, 1; b 1/2
end
tp_drop 100, 0, 1 do
	b 3/4
	t -75, 37.5; b 1/4
end
tp_chain 100, 0, 1 do
	t -75, 37.5; b 1/2
	b 1/2

	t -37.5, 25; b 1/2
	t -12.5, 0; b 1/2
	t -25, -25; b 1/2
	t 12.5, -50; b 1/2
	t -50, -25; b 1/2
	t -62.5, 0; b 1/2
	t -75, 25; b 1/2
	t -50, 50; b 1/2

	t -25, 12.5; b 1/2
end
tp_drop 100, 0, 1 do
	b 1/4
	t 75, 0; b 1/4
end
tp_chain 100, 0, 1 do
	t 75, 0; b 1/2
	hexagon 1+1/2
	b 1/2
	f 75/sqrt(3), 25, :right; b 1/2
	f 75/sqrt(3), -25, :right; b 1/2
	f 100/sqrt(3), 0, :right; b 1/2
end
bg_note -87.5, -37.5, 0, ?生; b 1/4
bg_note -62.5, -37.5, 0, ?气; b 1/4

tp_chain 0, 100, 1 do
	f -62.5, -37.5, :up, ?气; b 2
end
tp_chain -100, 0, beat_speed: 50 do
	t 0, -37.5, ?狂; b 3/4
	t 37.5, -37.5, ?跺; b 3/4
	t 62.5, -37.5, 'Jio'; b 1/2
end

tp_chain 0, 100, 1 do
	h 62.5, -37.5, 2, 'Jio'; b 5/2
end
tp_chain -100, 0, beat_speed: 50 do
	t -75, -25, ?但; b 1/2
	t -50, -25, ?没; b 1/2
	t -25, -25, ?关; b 1/2

	h 0, -25, 1, ?系; b 2
end
tp_chain -100, 0, beat_speed: 50 do
	t -75, -12.5, ?还; b 3/4
	t -37.5, -12.5, ?有; b 3/4
	t 0, -12.5, ?最; b 1/2

	h 25, -12.5, 1/2, ?后; b 1
	h 25, 37.5, 1/2, ?的; b 1
	f 0, 25, :right, ?超; b 2
end
tp_drop 0, 100, 1 do
	b -2+1/4
	t 0, 0, ?绝; b 1/2
	t 0, 0, ?绝; b 1/4
	t 0, 0, ?绝; b 1/2
	t 0, 0, ?绝; b 1/2
end

tp_chain -100, 0, 1 do
	f 0, -25, :left, ?招
end
b 2
tp_chain 0, 100, 1 do
	t -50, 25, ?门; b 3/4
end
tp_chain -100, 0, beat_speed: 50 do
	t -50, 25, ?门; b 3/4
	t -12.5, 25, ?关; b 1/2

	h 12.5, 25, 2, ?牢; b 3+1/2
end
tp_chain -100, 0, beat_speed: 100 do
	t -75, 37.5, ?噩; b 1/4
	t -50, 37.5, ?梦; b 1/4

	h -25, 37.5, 1, ?才; b 2
	t 0, 37.5, ?刚; b 3/4
end
tp_chain 0, 100, 1 do
	t 0, 37.5, ?刚; b 3/4
	t 25, 37.5, ?开; b 1/2

	t 50, 37.5, ?始; b 1
	t 0, 50, ?别; b 1/2
	t 0, 12.5, ?想; b 1/4
	h 0, -12.5, 4, ?逃; b 1/4+2
end

tp_chain 0, 100, 1 do
	t -50, 25; b 1/2
	t -50, 0; b 1/4
	t -50, -12.5; b 1/4
	b 1
end
tp_chain 0, 100, beat_speed: 50, preserve_beat: false do
	t 25, 25; b 1/2
	t 25, 0; b 1/2
	t 25, -25; b 1/2
	t 25, -50; b 1/2
end
tp_chain 0, -100, beat_speed: 50 do
	b 3/4
	t -25, -25; b 1/2
	t -25, 0; b 1/2
	t -25, 25; b 1/4
end

tp_drop -100, 0, 1, preserve_beat: false do
	12.times do
		t 0, -50; b 1
	end
end

tp_chain 0, 100, 1 do
	t -50, 50, ?先; b 1/2
	t -62.5, 25, ?登; b 1/4
	t -37.5, 12.5, ?场; b 1/4
	t -12.5, 0, ?代; b 1/2
	t 0, 37.5, ?表; b 1/4
	t 25, 25, ?不; b 1/4
	t 50, 12.5, ?祥; b 1/2
	t 75, 37.5, ?征; b 1/2
	t 25, 50, ?兆; b 1/2
	t -25, 12.5, ?的; b 1/2

	t -75, 0, ?超; b 3/4
	t -37.5, 37.5, ?凶; b 3/4
	t 12.5, 25, ?黑; b 1/2
	t 50, 50, ?猫; b 3/4
	t 50, 50, ?猫; b 5/4

	t 100, 25, ?可; b 1/2
	t 75, 0, ?怎; b 1/4
	t 50, 25, ?么; b 1/4
	t 25, 50, ?被; b 1/2
	t -12.5, 12.5, ?挠; b 1/2
	t -12.5, 12.5, ?挠; b 1/2
	t -37.5, 50, ?下; b 1/2
	t -75, 37.5, ?巴; b 1/2
	t -100, -12.5, ?就; b 1/2
end

def tilde text
	tp_chain -100, -100, beat_speed: 50*sqrt(2) do
		f -75, 25, :up_right, text
		(1..12).each do |i|
			b 1/16
			d -75+200*i/16, 25+75/PI*sin(200*PI/75*i/16)
		end
	end
end
2.times { tilde ?呜; b 1/4 }
2.times { transform(tilde ?喵) { rotate PI }; b 1/4 }

tp_drop 100, 0, 1, preserve_beat: false do
	12.times do
		t 0, 50; b 1
	end
end

tp_chain 0, -100, 1 do
	t -100, 25, ?再; b 1/2
	t -87.5, -25, ?放; b 1/4
	t -62.5, -0, ?出; b 1/4
	t -37.5, 25, ?地; b 1/2
	t -25, -50, ?狱; b 1/4
	t 0, -25, ?三; b 1/4
	t 25, 0, ?头; b 1/2
	t 62.5, -12.5, ?小; b 1/2
	t 100, -37.5, ?柴; b 1/2
	t 100, -37.5, ?柴; b 1/2

	t 75, -12.5, ?一; b 3/4
	t 37.5, 0, ?声; b 3/4
	t 0, -37.5, ?吼; b 1/2
	f -37.5, -25, :up_right, ?嗷; b 3/4
	f -37.5, -25, :up, ?嗷; b 3/4
	f -37.5, -25, :up_left, ?嗷; b 1/2

	t -62.5, -50, ?被; b 1/2
	t -25, 0, ?他; b 1/4
	t 0, -25, ?们; b 1/4
	t 25, -50, ?一; b 1/2
	t 62.5, -37.5, ?拥; b 1/2
	t 100, -37.5, ?而; b 1/2
	t 75, 12.5, ?上; b 1/2
	t 25, 0, ?狂; b 1/2
	pentagon 7/2
	t -37.5, -25, ?撸; b 1/2
end

def f_drag i, text = ''
	angle = PI/2 - i*2*PI/5
	x = 50*cos(angle)
	y = 50*sin(angle)
	tp_chain -x, -y, beat_speed: 100, preserve_beat: false do
		f 0, 0, (angle/(PI/4)).round*PI/4, text; b 1/8
		d x/2, y/2; b 1/8
		d x, y; b 1/4
	end
end
f_drag 0; bg_note -37.5, 25, 0, ?薅; b 1/2
f_drag -1; bg_note -12.5, 25, 0, ?到; b 1/2
f_drag 1; bg_note 12.5, 25, 0, ?没; b 1/2
f_drag -2; bg_note 37.5, 25, 0, ?毛; b 1/2
f_drag 2; bg_note 37.5, 25, 0, ?毛; b 1/2
tp_chain 0, 100, beat_speed: 100, preserve_beat: false do
	t 0, 0; b 1/2
	4.times do
		h -25, -12.5, 1/2, ?嘤; b 1

		h 0, -37.5, 5/2, ?嘤; b 3
	end
	3.times do
		h 25, -12.5, 1/2, ?嘤; b 1

		h 0, -37.5, 5/2, ?嘤; b 3
	end
end
b 3/2

tp_chain -100, 0, beat_speed: 50 do
	b 1/2
	t -75, 25, ?万; b 1/2
	t -50, 25, ?圣; b 1/2
	t -25, 25, ?节; b 1/2
	t 0, 25, ?鬼; b 1/2
	t 25, 25, ?怪; b 1/4
	t 37.5, 25, ?大; b 1/2
	t 62.5, 25, ?狂; b 1/4
	t 75, 25, ?欢; b 1/2
end

tp_chain -100, 0, beat_speed: 50 do
	b 1/2
	t -50, 25, ?嘤; b 1/2
	t -50, 25, ?嘤; b 1/2
	t -25, 25, ?怪; b 1/2
	t 0, 25, ?也; b 1/2
	t 25, 25, ?要; b 1/4
	t 37.5, 25, ?捣; b 1/2
	t 62.5, 25, ?蛋; b 1/4
	t 62.5, 25, ?蛋; b 1/2
end

tp_chain -100, 0, beat_speed: 50 do
	b 1/2
	t -50, 25, ?宝; b 1/2
	t -50, 25, ?宝; b 1/2
	t -25, 25, ?的; b 1/2
	t 0, 25, ?超; b 1/2
	t 25, 25, ?恐; b 1/4
	t 37.5, 25, ?怖; b 1/2
	t 62.5, 25, ?作; b 1/4
	t 75, 25, ?战; b 1/2
end

tp_chain -100, 0, beat_speed: 50 do
	b 1/2
	t -75, 25, ?一; b 1/2
	t -50, 25, ?定; b 1/2
	t -25, 25, ?能; b 1/2
	t 0, 25, ?吓; b 1/2
	t 25, 25, ?破; b 1/4
	t 37.5, 25, ?你; b 1/2
	t 62.5, 25, ?胆; b 1/4
	t 62.5, 25, ?胆; b 1/2
end

tp_chain 100, 0, beat_speed: 50 do
	b 1/2
	bg_note 75, 25, 0, ?要; b 1/2
	f 50, 25, :up, ?是; b 1/2
	t 25, 25, ?不; b 1/2
	t 0, 25, ?吓; b 1/2
	t -25, 25, ?人; b 1/4
	t -37.5, 25, ?怎; b 1/2
	t -62.5, 25, ?么; b 1/4
	t -75, 25, ?办; b 1/2
end

tp_chain 100, 0, beat_speed: 50 do
	b 1/2
	t 62.5, 25, ?才; b 1/2
	t 37.5, 25, ?不; b 1/2
	t 12.5, 25, ?会; b 1/2
	t -12.5, 25, ?哭; b 1/2
	t -12.5, 25, ?哭; b 1/4
	t -25, 25, ?给; b 1/2
	t -50, 25, ?你; b 1/4
	t -62.5, 25, ?看; b 1/2
end

tp_chain 100, 0, beat_speed: 50 do
	b 1/2
	t 62.5, 25, ?讨; b 1/2
	t 37.5, 25, ?厌; b 1/2
	t 37.5, 25, ?厌; b 1/2
	t 12.5, 25, ?不; b 1/2
	t -12.5, 25, ?许; b 1/4
	t -25, 25, ?摸; b 1/2
	t -50, 25, ?头; b 1/2
	t -75, 25, ?头; b 1/4
end

b -1
tp_chain -100, 0, beat_speed: 50 do
	t -25, -12.5; b 1/2
	t 0, -12.5, ?大; b 1/2

	t 25, -12.5, ?坏; b 1
	t 75, -12.5, ?蛋; b 1
end
def f_drag x, y, angle
	unit_x = 50*cos(angle)
	unit_y = 50*sin(angle)
	tp_chain -unit_x*2, -unit_y*2, beat_speed: 100, preserve_beat: false do
		f x, y, (angle/(PI/4)).round*PI/4; b 1/8
		d x+unit_x/2, y+unit_y/2; b 1/8
		d x+unit_x, y+unit_y; b 1/4
	end
end
f_drag -50, 0, 0; f_drag 50, 0, -PI/6; big_text ?嚶; b 1/2
f_drag -50, 0, -2*PI/3; f_drag 50, 0, -5*PI/6; big_text ?嚶; b 1/2
f_drag -50, 0, 2*PI/3; f_drag 50, 0, PI/2; big_text 1/2, ?嚶; b 1

transform(lude) { horizontal_flip }

end
