# frozen_string_literal: true

=begin
I'm here to show you who I am<br>
Throw off the veil, it's finally time<br>
There's more to me than glitz and glam, oh-whoa<br>
And now I feel my stars align<br>
For I had believed what I was sold<br>
I did all the things that I was told<br>
But all that has changed, and now I'm bold<br>
'Cause I know<br>
That I am just a pony<br>
I make mistakes from time to time<br>
But now I know the real me<br>
And put my heart out on the line<br>
And let the magic in my heart stay true<br>
Whoa-whoa-whoa-whoa<br>
And let the magic in my heart stay true<br>
Whoa-whoa-whoa-whoa<br>
Just like the magic inside of you<br>
And now I see those colors<br>
Right before my eyes<br>
I hear my voice so clearly<br>
And I know that it is right<br>
They thought I was weak, but I am strong<br>
They sold me the world, but they were wrong<br>
And now that I'm back, I still belong<br>
'Cause I know<br>
That I am just a pony<br>
I make mistakes from time to time<br>
But now I know the real me<br>
And put my heart out on the line<br>
And let the magic in my heart stay true<br>
Whoa-whoa-whoa-whoa<br>
And let the magic in my heart stay true<br>
Whoa-whoa-whoa-whoa<br>
Just like the magic inside of you<br>
Just like the magic inside of you
=end

Integer.alias_method :/, :quo
include Math

Sunniesnow::Charter.open 'master' do

title 'The Magic Inside'
artist 'Daniel Ingram feat. Lena Hall'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'

offset 0.159
bpm 150

repeated = group do
	4.times do |i|
		tp_chain -100, 0, 1 do
			t -75 + 12.5*i, 25 - 25*i; b 1/2
			t -50 + 12.5*i, 37.5 - 25*i; b 1
		end
	end
	tp_chain 0, 100, 1 do
		t 25, 25; b 1/2
		t 50, 37.5; b 1/2
		t 75, 25; b 1/2
		t 100, 12.5; b 1/2
	end
end

4.times do |i|
	tp_chain 100, 0, 1 do
		t 25 + 12.5*i, -37.5 + 25*i; b 1/2
		t 12.5*i, -25 + 25*i; b 1
	end
end
tp_chain 0, 100, 1 do
	t -100, 12.5; b 1/2
	t -75, 0; b 1/2
	t -50, -12.5; b 1/2
	t -25, -25; b 1/2
end

transform duplicate repeated do
	horizontal_flip
	beat_translate 16
end
b 8

2.times do |i|
	tp_chain -100, 0, 1 do
		t -25 - 12.5*i, -37.5 + 25*i; b 1/2
		t -12.5*i, -25 + 25*i; b 1
	end
end
tp_chain -100, 0, 1 do
	t -25, 50; b 1/2
	t 0, 37.5; b 5/2
	t 50, 0; b 2
end

#-----

group preserve_beat: false do
	b 1
	bg_note -75, 50, "I'm"; b 1/2
	bg_note -50, 50, 'here'; b 1
	bg_note -25, 50, 'to'; b 1
	bg_note 0, 50, 'show'; b 1
	bg_note 25, 50, 'you'; b 1/2

	b 1/2
	bg_note 50, 50, 'who'; b 1
	bg_note 75, 50, 'I'; b 1
	bg_note 100, 50, 1, 'am'; b 3/2
end

tp_drop 0, 100, 1, preserve_beat: false do
	h -100, -50, 3; b 4
	h -75, -50, 3; b 4
	h -50, -50, 3; b 4
	h -25, -50, 3; b 4
end

tp_chain -100, 0, 1 do
	b 1/2
	t -25, 25; b 1/2
	t 0, 37.5; b 1/2
	t 25, 50; b 1
	t 12.5, 0; b 1/2
	t 37.5, 12.5; b 1/2
	t 62.5, 25; b 1/2

	b 1/2
	t 25, -25; b 1/2
	t 50, -12.5; b 1/2
	t 75, 0; b 1
	t 37.5, -37.5; b 1/2
	t 62.5, -25; b 1

	b 1/2
	t 100, 12.5; b 1/2
	t 75, 25; b 1/2
	t 50, 37.5; b 3/2
	t 12.5, 25; b 1/2
	t -12.5, 12.5; b 1/2

	t 12.5, 0; b 1/2
	t 37.5, -12.5; b 1/2
	t 62.5, -25; b 1/2
	t 87.5, -12.5; b 1/2
end
b 3/2
t 75, 25; b 1/4
t 62.5, 37.5; b 1/4

group preserve_beat: false do
	b 1
	bg_note -75, -50, 'Throw'; b 1/2
	bg_note -50, -50, 'off'; b 1
	bg_note -25, -50, 'the'; b 1/2
	bg_note 0, -50, 'veil,'; b 1

	b 1
	bg_note 25, -50, "it's"; b 1/2
	bg_note 50, -50, 'fi-'; b 1
	bg_note 75, -50, 'nally'; b 1/2
	bg_note 100, -50, 5/2, 'time'; b 2
end

tp_drop 0, -100, 1, preserve_beat: false do
	h 75, 50, 3; b 4
	h 50, 50, 3; b 4
	h 25, 50, 3; b 4
	h 0, 50, 3; b 4
end

tp_chain -100, 0, 1 do
	b 1/2
	t -100, 0; b 1/2
	t -75, 12.5; b 1/2
	t -50, 25; b 3/2
	t -12.5, 12.5; b 1

	b 1/2
	t -25, -25; b 1/2
	t -50, -12.5; b 1/2
	f -75, 0, :up_left; b 5/2

	t 25, -12.5; b 3/2
	t 0, 0; b 3/2
	t -25, 12.5; b 1

	t -75, 0; b 3/2
	t -50, -12.5; b 3/2
	t -25, -25; b 1
end

group preserve_beat: false do
	b 1
	bg_note -75, 50, "There's"; b 1/2
	bg_note -50, 50, 'more'; b 1
	bg_note -25, 50, 'to'; b 1
	bg_note 0, 50, 'me'; b 1/2

	b 1/2
	bg_note 25, 50, 'than'; b 1
	bg_note 50, 50, 'glitz'; b 1
	bg_note 75, 50, 'and'; b 1
	bg_note 100, 50, 2, 'glam'; b 3/2
end

tp_drop 0, 100, 1, preserve_beat: false do
	h 100, -50, 3; b 4
	h 75, -50, 3; b 4
	h 50, -50, 3; b 4
	h 25, -50, 3; b 4
end

tp_chain 0, -100, 1 do
	t -100, 37.5; b 1/2
	t -75, 25; b 1/2
	t -50, 12.5; b 1/2
	t -25, 37.5; b 1
	t -12.5, 0; b 1/2
	t -37.5, 12.5; b 1/2
	t -62.5, 25; b 1/2

	t -100, -12.5; b 1/2
	t -75, -37.5; b 1/2
	t -50, -25; b 1/2
	t -25, -25; b 1
	t 0, 12.5; b 1/2
	t -25, 25; b 1/2
	t -50, 50; b 1/2

	t -75, 50; b 1/2
	t -100, 25; b 1/2
	t -75, 12.5; b 1/2
	t -50, 25; b 1
	t -50, -12.5; b 1/2
	t -25, 0; b 1/2
	t 0, 37.5; b 1/2

	t 0, 37.5; b 1/2
	t -25, 25; b 1/2
	t -50, 12.5; b 1/2
	t -75, 25
end
b 2
t 75, 25; b 1/4
t 62.5, 37.5; b 1/4

grid 15
group preserve_beat: false do
	b 1
	bg_note -87.5, 37.5, 'And'; b 1/2
	bg_note -87.5, 12.5, 'now'; b 1
	bg_note -87.5, -12.5, 'I'; b 1
	bg_note -87.5, -37.5, 'feel'; b 1/2

	b 1/2
	bg_note 87.5, 37.5, 'my'; b 1
	bg_note 87.5, 12.5, 'stars'; b 1
	bg_note 87.5, -12.5, 'a-'; b 1/2
	bg_note 87.5, -37.5, 4, 'lign'; b 1
end

notes = group do
	group preserve_beat: false do
		tp_chain -100, 0, 1 do
			t -50, -50; b 3/2
		end
		tp_chain 100, 0, 1 do
			h 50, -50, 3/2; b 5/2
		end
	end

	tp_chain 0, 100, 1 do
		t 50, 50; b 1/2
		t 0, 0; b 1/2
		t -25, 25; b 1/2
		t -50, 50; b 3/2
		t -50, 0; b 1
	end
end
transform duplicate notes do
	horizontal_flip
	beat_translate 4
end
b 4

group preserve_beat: false do
	tp_chain 100, 0, 1 do
		t 50, -50; b 3/2
	end
	tp_chain -100, 0, 1 do
		t -50, -50; b 2
	end
	tp_chain 100, 0, 1 do
		t 50, -50; b 1/2
	end
end
tp_chain -100, 0, 1 do
	t -50, 50; b 1/2
	t 0, 0; b 1/2
	t 25, 25; b 1/2
	t 50, 50; b 1
	t 0, 0; b 1/2
	t -25, 25; b 1/2
	t -50, 50; b 1/2
end

notes = tp_chain 100, 0, 1 do
	t -50, 50; b 1/2
	t -62.5, 37.5; b 1/2
	t -75, 25; b 1/2
	t -87.5, 12.5; b 1/2
	t -100, 0; b 1/2
	t -87.5, -12.5; b 1/2
	t -75, -25; b 1/2
	t -62.5, -37.5; b 1/2
end
transform(duplicate notes) { rotate PI }

#-----

group preserve_beat: false do
	b -1/2
	bg_note 0, 50, 'For'; b 1/2
	bg_note -12.5, 25, 'I'; b 1/2
	bg_note 12.5, 25, 'had'; b 1
	bg_note -12.5, 0, 'be-'; b 1/2
	bg_note 12.5, 0, 'lieved'; b 1
	bg_note -12.5, -25, 'what'; b 1/2
	bg_note 12.5, -25, 'I'; b 1/2

	b 1/2
	bg_note -12.5, -50, 'was'; b 1/2
	bg_note 12.5, -50, 2, 'sold'; b 3
end

tp_drop 0, 0, 1, relative: false do
	turntable 1/2
	f -50, -50, :left; f 50, 50, :right; b 3/2
	turntable 1/2
	f -75, 0, :left; f 75, 0, :right; b 3/2
	turntable 2
	h -50, 50, 3/2; h 50, -50, 3/2; b 1
end

b 2
tp_chain 0, 100, 1, preserve_beat: false do
	b -1/2
	t -25, 0; b 1/2
	t 0, 12.5; b 1/2
	t 25, 25; b 1/2
	t 50, 12.5; b 1/2
	t 75, 0; b 1/2
end
tp_chain 100, 0, 1 do
	h 0, -50, 1; b 2
end

group preserve_beat: false do
	b -1/2
	bg_note 0, 50, 'I'; b 1/2
	bg_note -12.5, 25, 'did'; b 1/2
	bg_note 12.5, 25, 'all'; b 1
	bg_note -12.5, 0, 'the'; b 1/2
	bg_note 12.5, 0, 'things'; b 1
	bg_note -12.5, -25, 'that'; b 1/2
	bg_note 12.5, -25, 'I'; b 1/2

	b 1/2
	bg_note -12.5, -50, 'was'; b 1/2
	bg_note 12.5, -50, 2, 'told'; b 3
end

hexagon 5
notes = tp_chain 100, 0, 1 do
	t 100, 12.5; b 3/2
	t 37.5, 37.5; b 3/2
	h 25, 0, 2; b 1
end
transform(duplicate notes) { horizontal_flip }

b 2
tp_chain 0, 100, 1 do
	h 0, 50, 3/2
end
tp_chain 0, 100, 1 do
	t -25, 37.5; b 1/2
	t -12.5, 12.5; b 1/2
	t 0, -12.5; b 1/2
	t 12.5, -37.5; b 1/2
end

group preserve_beat: false do
	b -1/2
	bg_note -50, 50, 'But'; b 1/2
	bg_note -25, 50, 'all'; b 1/2
	bg_note 0, 50, 'that'; b 1
	bg_note 25, 50, 'has'; b 1/2
	bg_note 50, 50, 'changed,'; b 1
	bg_note -37.5, -50, 'and'; b 1/2
	bg_note -12.5, -50, 'now'; b 1/2

	b 1/2
	bg_note 12.5, -50, "I'm"; b 1/2
	bg_note 37.5, -50, 'bold'; b 3/2
	bg_note -25, 0, "'Cause"; b 1/2
	bg_note 0, 0, 'I'; b 1/2
	bg_note 25, 0, 3, 'know'; b 1/2
end

checkerboard 2
tp_chain 100, 0, 1, preserve_beat: false do
	t 37.5, 37.5; b 1/2
	t 12.5, 37.5; b 1/2
	t -12.5, 37.5; b 1/2
	t -37.5, 37.5; b 3/2
	h -62.5, 0, 2; b 1
end

tp_chain -100, 0, 1 do
	t -37.5, -37.5; b 3/2
	t 37.5, -37.5; b 3/2
	h 62.5, 0, 3/2; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	b 3/2
	t 25, 0; b 1/2
	t 0, 12.5; b 1/2
	t -25, 25; b 1/2
	t -50, 12.5; b 1/2
	t -75, 0; b 1/2
end

tp_drop 0, 100, 1 do
	b 2
	h 0, 50, 3/2; b 2

	t 50, -25
	h -100, -25, 3/2; b 4/3
	t 0, 25; b 2/3
	h 50, 25, 3/2; b 1
	t 0, 50; b 1
end

tp_drop 0, 0, 0.75, relative: false do
	f -75, -12.5, :up
	f 75, -12.5, :up
end

#-----

b -1/2
bg_note -100, 37.5, 2, 'That'; b 1/2
big_text 6, 'I am just a pony'; b 4

group preserve_beat: false do
	b 5/2
	bg_note -100, 0, 'I'; b 1/2
	bg_note -75, 12.5, 'make'; b 1/2
	bg_note -50, 25, 'mis-'; b 1/2

	bg_note -25, 37.5, 'takes'; b 1
	bg_note -87.5, -25, 'from'; b 1/2
	bg_note -62.5, -12.5, 'time'; b 1
	bg_note -37.5, 0, 'to'; b 1
	bg_note -12.5, 12.5, 3, 'time'; b 1/2

	b 7/2
	bg_note 25, 25, 'But'; b 1/2

	bg_note 50, 12.5, 'now'; b 1/2
	bg_note 75, 0, 'I'; b 1
	bg_note 100, -12.5, 'know'; b 3/2
	bg_note 37.5, 0, 'the'; b 1/2
	bg_note 62.5, -12.5, 'real'; b 1/2

	b 1/2
	bg_note 87.5, -25, 'me'; b 2
	bg_note 25, -37.5, 'And'; b 1/2
	bg_note 50, -25, 'put'; b 1/2
	bg_note 75, -12.5, 'my'; b 1/2

	bg_note 100, 0, 'heart'; b 1/2
	bg_note 12.5, -12.5, 'out'; b 1
	bg_note 37.5, 0, 'on'; b 3/2
	bg_note 62.5, 12.5, 'the'; b 1/2
	bg_note 87.5, 25, 5/2, 'line'; b 1/2

	b 5/2
	bg_note -100, 50, 'And'; b 1/2
	bg_note -75, 50, 'let'; b 1/2
	bg_note -50, 50, 'the'; b 1/2

	bg_note -25, 50, 'ma-'; b 1/2
	bg_note 0, 50, 'gic'; b 1/2
	bg_note 25, 50, 'in'; b 1/2
	bg_note 50, 50, 'my'; b 1/2
	bg_note 75, 50, 'heart'; b 1
	bg_note 100, 50, 'stay'; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	notes = group do
		h 75, 25, 1; b 3/2
		h 50, 12.5, 2; b 5/2

		h 0, 37.5, 7/2; b 4

		h -50, 50, 7/2; b 4
	end

	h -87.5, 37.5, 1; b 3/2
	h -62.5, 25, 2; b 5/2

	transform duplicate notes, new_tip_points: false do
		rotate PI
		beat_translate 16
	end
end

tp_chain -100, 0, 1 do
	notes = group do
		f -100, 0, :up_right; b 1/2
		t -75, -25; b 1/2
		t -50, -12.5; b 1/2
		t -25, 0; b 1/2
		t 0, -37.5; b 1/2
		t 25, -25; b 1/2
		t 50, -12.5; b 1/2
		t 75, -50; b 1/2

		f 100, 12.5, :up_left; b 1
		t 50, -12.5; b 1/2
		t 25, 0; b 1
		t 37.5, -37.5; b 1/2
		t 12.5, -25; b 1

		f 0, 0, :up_right; b 1
		t 25, -12.5; b 1/2
		t 50, 0; b 1
		t 0, -25; b 1/2
		t 25, -12.5; b 1
	end

	f 75, 25, :up_left; b 1
	t 50, 25; b 1/2
	t 25, 37.5; b 1
	t 0, 0; b 1/2
	t -25, 12.5; b 1

	transform duplicate notes, new_tip_points: false do
		rotate PI
		beat_translate 16
	end
	b 12-1/2
	t -12.5, -12.5; b 1/2

	t 0, -37.5; b 1/2
	t 12.5, -12.5; b 1/2
	t 25, 12.5; b 1/2
	t 37.5, 37.5; b 1
	t 50, 12.5; b 1/2
	t 62.5, -12.5; b 1/2
	t 75, -37.5; b 1/2
end

tp_chain -100, 0, 1, preserve_beat: false do
	b -4
	t -75, -37.5; b 1/2
	t -62.5, -12.5; b 1/2
	t -50, 12.5; b 1/2
	t -37.5, 37.5; b 1/2
	t -25, 12.5; b 1/2
	t -12.5, -12.5; b 1/2
	t 0, -37.5; b 1
end

#-----

big_text 9, 'true'
def triplet x, y, angle
	unit_x = 18.75*cos(angle)
	unit_y = 18.75*sin(angle)
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: 18.75*3 do
		t x, y; b 1/3
		t x + unit_x, y + unit_y; b 1/3
		t x + 2*unit_x, y + 2*unit_y; b 1/3
	end
end
triplets = group do
	triplet -100, 0, -PI/4
	triplet -75, 50/3, -PI/4
	triplet -50, 100/3, -PI/4
	triplet -25, 50, -PI/4

	triplet 50, 25, -PI/4
	triplet 25, 0, -PI/4
	triplet -50, 25, -3*PI/4
	triplet -25, 0, -3*PI/4

	triplet 100, 0, -3*PI/4
	triplet 75, 50/3, -3*PI/4
	triplet 50, 100/3, -3*PI/4
	triplet 25, 50, -3*PI/4
end

grid 3
group preserve_beat: false do
	b -3/2
	bg_note -62.5, 37.5, 'And'; b 1/2
	bg_note -37.5, 37.5, 'let'; b 1/2
	bg_note -12.5, 37.5, 'the'; b 1/2

	bg_note 12.5, 37.5, 'ma-'; b 1/2
	bg_note 37.5, 37.5, 'gic'; b 1/2
	bg_note -12.5, 12.5, 'in'; b 1/2
	bg_note 12.5, 12.5, 'my'; b 1/2
	bg_note 37.5, 12.5, 'heart'; b 1
	bg_note 62.5, 12.5, 'stay'; b 1
end

tp_drop 0, 100, 1, preserve_beat: false do
	f -25, 0, :left; f 25, 0, :right; b 3/2
	f -50, -25, :left; f 50, -25, :right; b 3/2
	f -75, -50, :left; f 75, -50, :right; b 1
end

tp_drop 0, -100, 1 do
	b 1/2
	t -25, -25; b 1/2
	t 25, -25; b 1
	t -50, -50; b 1/2
	t 50, -50; b 3/2
end

big_text 9, 'true'
transform duplicate triplets do
	vertical_flip
	beat_translate 16
end
b 12

group preserve_beat: false do
	b -3/2
	bg_note -100, -37.5, 'Just'; b 1/2
	bg_note -75, -37.5, 'like'; b 1/2
	bg_note -50, -37.5, 'the'; b 1/2

	bg_note -25, -37.5, 'ma-'; b 1/2
	bg_note 0, -37.5, 'gic'; b 1/2
	bg_note 25, -37.5, 'in-'; b 1/2
	bg_note 50, -37.5, 'side'; b 1
	bg_note 75, -37.5, 'of'; b 1/2
	bg_note 100, -37.5, 'you'; b 1
end

tp_drop 0, 100, 1 do
	h -25, 0, 1; h 25, 0, 1; b 3/2
	h -50, 25, 3/2; h 50, 25, 3/2; b 5/2
end

#-----

tp_drop 0, 100, 1, preserve_beat: false do
	4.times do |i|
		8.times { t -87.5 + i*25, -50; b 1/2 }
	end
	4.times do |i|
		8.times { t 87.5 - i*25, -50; b 1/2 }
	end
end

group preserve_beat: false do
	b 1
	bg_note -100, 50, 'And'; b 1/2
	bg_note -75, 50, 'now'; b 1
	bg_note -50, 50, 'I'; b 1
	bg_note -100, 25, 'see'; b 1/2

	b 1/2
	bg_note -75, 25, 'those'; b 1
	bg_note -50, 25, 'co-'; b 1
	bg_note -25, 25, 'lors'; b 3/2

	bg_note -100, 50, 'right'; b 1
	bg_note -75, 50, 'be-'; b 1/2
	bg_note -50, 50, 'fore'; b 1
	bg_note -25, 50, 'my'; b 1
	bg_note 0, 50, 4, 'eyes'; b 1/2
end

tp_chain 100, 0, 1 do
	b -1/3
	t -87.5, -12.5; b 1/6
	t -75, 0; b 1/6

	f -62.5, 12.5, :up_right; b 1
	t -25, 12.5; b 1/2
	f 0, 37.5, :up_right; b 1
	t 12.5, 0; b 1/2
	t 37.5, 12.5; b 1/2
	t 62.5, 25; b 1/2

	f 87.5, 12.5, :up_left; b 3/2
	f 100, 50, :up_left; b 1
	f 62.5, 37.5, :up_left; b 3/2

	f 25, 25, :up_right; b 1
	t 37.5, 12.5; b 1/2
	h 62.5, 37.5, 2; b 5/2

	f 87.5, -25, :up_left; b 1/2
	t 62.5, -12.5; b 1/2
	t 37.5, 0; b 1/2
	t 0, 25; b 1/2
	t 25, 37.5; b 1/2
	t 50, 25; b 1/2
	t 75, 12.5; b 1/2
	t 100, 25; b 1/2
end

group preserve_beat: false do
	b 1
	bg_note 25, 50, 'I'; b 1/2
	bg_note 50, 50, 'hear'; b 1
	bg_note 75, 50, 'my'; b 1
	bg_note 100, 50, 'voice'; b 1/2

	b 1/2
	bg_note 50, 25, 'so'; b 1
	bg_note 75, 25, 'clear-'; b 1
	bg_note 100, 25, 'ly'; b 1/2
	bg_note 25, 50, 'And'; b 1/2
	bg_note 50, 50, 'I'; b 1/2

	bg_note 75, 50, 'know'; b 1
	bg_note 100, 50, 'that'; b 1/2
	bg_note 25, 25, 'it'; b 1
	bg_note 50, 25, 'is'; b 1
	bg_note 75, 25, 4, 'right'; b 1/2
end

tp_chain -100, 0, 1 do
	f 0, 0, :up_left; b 3/2
	t -37.5, 0; b 1/2
	f -62.5, 25, :up_left; b 3/2
	t -87.5, 37.5; b 1/2

	h -62.5, 50, 7/2; b 4

	f 0, -12.5, :up_left; b 3/2
	t -37.5, -12.5; b 1/2
	f -62.5, 12.5, :up_left; b 3/2
	t -87.5, 25; b 1/2

	h -62.5, 37.5, 1/2; b 1
	h -37.5, 25, 1/2; b 1
	h -12.5, 37.5, 1/2; b 1
	h 12.5, 50, 1/2; b 1
end

#-----

group preserve_beat: false do
	4.times { checkerboard 1/4; b 3/2 }
	b 2

	4.times { hexagon 1/4; b 3/2 }
	b 2

	4.times { pentagon 1/4; b 3/2 }
	b 2
end

group preserve_beat: false do
	b -1/2
	bg_note -100, 50, 'They'; b 1/2

	bg_note -100, 25, 'thought'; b 1/2
	bg_note -100, 0, 'I'; b 1
	bg_note -100, -25, 'was'; b 1/2
	bg_note -100, -50, 'weak,'; b 1
	bg_note 100, 37.5, 'but'; b 1/2
	bg_note 100, 12.5, 'I'; b 1
	bg_note 100, -12.5, 'am'; b 1/2
	bg_note 100, -37.5, 1, 'strong'; b 1
	b 2
end

pattern = tp_chain 0, 100, 1 do
	notes = group do
		f -50, 50, :left; b 1/2
		t -12.5, 12.5; b 1/2
		t -12.5, -12.5; b 1/2
		f -50, -50, :left; b 1/2
		t -25, 0; b 1
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		beat_translate 3
	end
end
transform duplicate pattern do
	rotate PI
end
b 3

pattern = tp_chain -100, 0, 1 do
	t -25, 37.5; b 1/2
	t -50, 12.5; b 1/2
	t -75, -12.5; b 1/2
	t -100, -37.5; b 1/2
end
transform duplicate pattern do
	rotate PI
end

group preserve_beat: false do
	b -1/2
	bg_note -100, 50, 'They'; b 1/2

	bg_note -100, 25, 'sold'; b 1/2
	bg_note -100, 0, 'me'; b 1
	bg_note -100, -25, 'the'; b 1/2
	bg_note -100, -50, 'world,'; b 1
	bg_note 100, 37.5, 'but'; b 1/2
	bg_note 100, 12.5, 'they'; b 1
	bg_note 100, -12.5, 'were'; b 1/2
	bg_note 100, -37.5, 1, 'wrong'; b 1
end

pattern = tp_chain 0, 100, 1 do
	notes = group do
		f 100/sqrt(3), 50, :right; b 1/2
		t 25/sqrt(3), 12.5; b 1/2
		t 25/sqrt(3), -12.5; b 1/2
		f 100/sqrt(3), -50, :right; b 1/2
		t -50/sqrt(3), 0; b 1
	end
	transform duplicate notes, new_tip_points: false do
		horizontal_flip
		beat_translate 3
	end
end
transform duplicate pattern do
	rotate PI
end
b 3

pattern = tp_chain 100, 0, 1 do
	t -75, 37.5; b 1/2
	t -75, 12.5; b 1/2
	t -75, -12.5; b 1/2
	t -75, -37.5; b 1/2
end
transform duplicate pattern do
	rotate PI
end

group preserve_beat: false do
	b -1/2
	bg_note -100, 50, 'And'; b 1/2

	bg_note -100, 25, 'now'; b 1/2
	bg_note -100, 0, 'that'; b 1
	bg_note -100, -25, "I'm"; b 1/2
	bg_note -100, -50, 'back'; b 1
	bg_note 100, 37.5, 'I'; b 1/2
	bg_note 100, 12.5, 'still'; b 1
	bg_note 100, -12.5, 'be-'; b 1/2
	bg_note 100, -37.5, 1, 'long'; b 1
end

def pattern1; group do
	f -50*cos(PI/10), 50*sin(PI/10), :left; b 1/2
	t 0, 12.5; b 1/2
	t 12.5*sin(PI/5), -12.5*cos(PI/5); b 1/2
	f -50*sin(PI/5), -50*cos(PI/5), :left; b 1/2
	t 0, 0; b 1
end; end
def pattern2; group do
	f 50*sin(PI/5), -50*cos(PI/5), :right; b 1/2
	t -12.5*sin(PI/5), -12.5*cos(PI/5); b 1/2
	t 0, 12.5; b 1/2
	f 50*cos(PI/10), 50*sin(PI/10), :right; b 1/2
	b 1/2; t 0, 0; b 1/2
end; end
tp_chain 0, 100, 1, preserve_beat: false do
	pattern1
	transform(pattern2) { horizontal_flip }
end
tp_chain 100, 0, 1 do
	pattern2
	transform(pattern1) { horizontal_flip }
end

pattern = tp_chain 0, 100, 1 do
	t 25, 50; b 1/2
	t 37.5, 50/3; b 1/2
	t 37.5, -50/3; b 1/2
	t 25, -50; b 1/2
end
transform duplicate pattern do
	rotate PI
end

group preserve_beat: false do
	b -3/2
	bg_note -12.5, 25, "'Cause"; b 1/2
	bg_note 12.5, 25, 'I'; b 1/2
	bg_note 0, 0, 7/2, 'know'; b 1/2
end

([1/4]*14+[1/6]*3).each_with_index.reduce 0 do |current, (delta, i)|
	x = 50+50*sin(3*PI/8*current)
	y = -50*cos(3*PI/8*current)
	if i % 2 == 1
		x *= -1
		y *= -1
	end
	u = hypot x, y
	tp_chain x/u*100, y/u*100, 1 do
		t x, y; b delta
	end
	current + delta
end

tp_chain 0, 100, 1 do
	f 0, 0, :up
end

#-----

b -1/2
bg_note -100, 37.5, 2, 'That'; b 1/2
big_text 6, 'I am just a pony'; b 4

group preserve_beat: false do
	b 5/2
	bg_note -87.5, -50, 'I'; b 1/2
	bg_note -62.5, -50, 'make'; b 1/2
	bg_note -37.5, -50, 'mis-'; b 1/2

	bg_note -12.5, -50, 'takes'; b 1
	bg_note 12.5, -50, 'from'; b 1/2
	bg_note 37.5, -50, 'time'; b 1
	bg_note 62.5, -50, 'to'; b 1
	bg_note 87.5, -50, 3, 'time'; b 1/2

	b 7/2
	bg_note -87.5, 50, 'But'; b 1/2

	bg_note -62.5, 50, 'now'; b 1/2
	bg_note -37.5, 50, 'I'; b 1
	bg_note -12.5, 50, 'know'; b 3/2
	bg_note 12.5, 50, 'the'; b 1/2
	bg_note 37.5, 50, 'real'; b 1/2

	b 1/2
	bg_note 62.5, 50, 'me'; b 2
	bg_note -87.5, -50, 'And'; b 1/2
	bg_note -62.5, -50, 'put'; b 1/2
	bg_note -37.5, -50, 'my'; b 1/2

	bg_note -12.5, -50, 'heart'; b 1/2
	bg_note 12.5, -50, 'out'; b 1
	bg_note 37.5, -50, 'on'; b 3/2
	bg_note 62.5, -50, 'the'; b 1/2
	bg_note 87.5, -50, 5/2, 'line'; b 1/2

	b 5/2
	bg_note -12.5, 50, 'And'; b 1/2
	bg_note 12.5, 50, 'let'; b 1/2
	bg_note 37.5, 50, 'the'; b 1/2

	bg_note 62.5, 50, 'ma-'; b 1/2
	bg_note 87.5, 50, 'gic'; b 1/2
	bg_note -62.5, -50, 'in'; b 1/2
	bg_note -37.5, -50, 'my'; b 1/2
	bg_note -12.5, -50, 'heart'; b 1
	bg_note 12.5, -50, 'stay'; b 1
end

tp_chain 0, 100, 1, preserve_beat: false do
	h 100, -25, 1; b 3/2
	h 75, -37.5, 2; b 5/2

	h 37.5, -25, 3; b 7/2
	t 50, 0; b 1/2

	h 62.5, 25, 7/2; b 4

	h 100, 12.5, 1; b 3/2
	h 75, 0, 3/2; b 2
	t 0, -50; b 1/2

	h -25, -37.5, 1; b 3/2
	h -37.5, 0, 2; b 5/2

	h -75, -12.5, 7/2; b 4

	h -50, 25, 1; b 3/2
	h -62.5, 50, 2; b 5/2

	t -100, 50; b 1/2
	t -75, 37.5; b 1/2
	t -50, 25; b 1/2
	t -25, 12.5; b 1/2
	t 0, 0; b 1/2
	t 25, 12.5; b 1/2
	t 50, 25; b 1/2
	t 75, 37.5; b 1/2
end

grid 31
tp_chain 0, 100, 1 do
	f -100, 0, :up_left; b 1/2
	t -87.5, -25; b 1/2
	t -62.5, -12.5; b 1/2
	f -37.5, 0, :up_left; b 1/2
	t -25, -25; b 1/2
	t 0, -12.5; b 1/2
	f 25, 0, :up_right; b 1/2
	t 12.5, 25; b 1/2

	f -12.5, 12.5, :up_right; b 1/2
	t -25, -12.5; b 1/2
	t -50, 0; b 1/2
	f -75, 12.5, :up_right; b 1/2
	t -87.5, -12.5; b 1/2
	t -100, 12.5; b 1/2
	f -75, 25, :up_left; b 1/2
	t -62.5, 0; b 1/2

	t -37.5, 12.5; b 1/2
	t -25, -12.5; b 1/2
	t -12.5, -37.5; b 1/2
	t -25, 25; b 1/2
	t -12.5, 0; b 1/2
	t 0, -25; b 1/2
	f -12.5, 37.5, :up_right; b 1/2
	t 0, 12.5; b 1/2

	f -25, 25, :up_right; b 1/2
	t -50, 12.5; b 1/2
	t -75, 0; b 1/2
	f -62.5, -25, :up_left; b 1/2
	t -37.5, -12.5; b 1/2
	t -12.5, 0; b 1/2
	f 0, 25, :up_left; b 1/2
	t 25, 12.5; b 1/2

	f 50, 25, :up_right; b 1/2
	t 62.5, 0; b 1/2
	t 87.5, 12.5; b 1/2
	f 100, 37.5, :up_right; b 1/2
	t 75, 50; b 1/2
	t 50, 37.5; b 1/2
	f 25, 25, :up_left; b 1/2
	t 37.5, 0; b 1/2

	f 25, -25, :left; b 1/2
	t 12.5, 0; b 1/2
	t 0, 25; b 1/2
	f 37.5, -12.5, :left; b 1/2
	t 25, 12.5; b 1/2
	t 12.5, 37.5; b 1/2
	f 50, 0, :left; b 1/2
	t 37.5, 25; b 1/2

	f 25, 50, :right; b 1/2
	t 12.5, 25; b 1/2
	t 0, 0; b 1/2
	f 37.5, 37.5, :right; b 1/2
	t 50, 12.5; b 1/2
	t 62.5, -12.5; b 1/2
	f 50, -37.5, :left; b 1/2
	t 75, -25; b 1/2

	t 100, -50; b 1/2
	t 75, -37.5; b 1/2
	t 50, -25; b 1/2
	t 25, -12.5; b 1/2
	b 1/2
	t -25, -12.5; b 1/2
	t -50, -25; b 1/2
	t -75, -37.5; b 1/2
end

#-----

big_text 9, 'true'
def triplet x, y, angle
	r = 12.5
	unit_x = r*cos(angle)
	unit_y = r*sin(angle)
	tp_chain -100*cos(angle), -100*sin(angle), beat_speed: r*3 do
		t x, y; b 1/3
		t x + unit_x, y + unit_y; b 1/3
		t x + 2*unit_x, y + 2*unit_y; b 1/3
	end
end
triplets = group preserve_beat: false do
	triplet -100, 37.5, -PI/2
	triplet -75, 25, -PI/2
	triplet -50, 12.5, -PI/2
	triplet -25, 0, -PI/2

	triplet 100, 25, -PI/2
	triplet 75, 12.5, -PI/2
	triplet 50, 0, -PI/2
	triplet 25, -12.5, -PI/2

	triplet -100, 12.5, -PI/2
	triplet -75, 0, -PI/2
	triplet -50, -12.5, -PI/2
	triplet -25, -25, -PI/2
end

tp_drop -100, 0, 1 do
	h 100, -50, 1/2; b 1
	h 87.5, -25, 1/2; b 1
	h 62.5, -12.5, 3/2; b 2
end

tp_drop 100, 0, 1 do
	h -75, 0, 7/2; b 4
end

tp_drop -100, 0, 1 do
	h 87.5, 12.5, 3/2; b 2
	h 62.5, -12.5, 3/2; b 2
end

diamond_grid 3
group preserve_beat: false do
	b -3/2
	bg_note 0, -25, 'And'; b 1/2
	bg_note 25, -25, 'let'; b 1/2
	bg_note 50, -25, 'the'; b 1/2

	bg_note 75, -25, 'ma-'; b 1/2
	bg_note 100, -25, 'gic'; b 1/2
	bg_note 25, -50, 'in'; b 1/2
	bg_note 50, -50, 'my'; b 1/2
	bg_note 75, -50, 'heart'; b 1
	bg_note 100, -50, 'stay'; b 1
end

tp_drop 100, 100, sqrt(2), preserve_beat: false do
	f -25, 0, :left; b 3/2
	f -50, 25, :left; b 3/2
	f -75, 50, :left; b 1
end
tp_drop -100, 100, sqrt(2), preserve_beat: false do
	f 25, 0, :right; b 3/2
	f 50, 25, :right; b 3/2
	f 75, 50, :right; b 1
end

tp_drop 0, -100, 1 do
	b 1/2
	t -25, 25; b 1/2
	t 25, 25; b 1
	t -50, 50; b 1/2
	t 50, 50; b 3/2
end

big_text 9, 'true'
transform duplicate triplets do
	horizontal_flip
	beat_translate 16
end

tp_drop -100, 0, 1 do
	h -100, -25, 1/2; b 1
	h -75, -12.5, 1/2; b 1
	h -50, 0, 1/2; b 1
	h -25, -12.5, 1/2; b 1
end

tp_drop 100, 0, 1 do
	h 75, 25, 7/2; b 4
end

tp_drop -100, 0, 1 do
	h -100, 12.5, 3/2; b 2
	h -75, -12.5, 3/2; b 2
end

group preserve_beat: false do
	b -3/2
	bg_note -100, 50, 'Just'; b 1/2
	bg_note -75, 50, 'like'; b 1/2
	bg_note -50, 50, 'the'; b 1/2

	bg_note -25, 50, 'ma-'; b 1/2
	bg_note 0, 50, 'gic'; b 1/2
	bg_note 25, 50, 'in-'; b 1/2
	bg_note 50, 50, 'side'; b 1
	bg_note 75, 50, 'of'; b 1
end

tp_drop 0, 100, 1 do
	h -25, 25, 1; h 25, 25, 1; b 3/2
	h -50, 0, 3/2; h 50, 0, 3/2; b 5/2
end

#-----

big_text 10, 'you'
tp_drop 0, 100, 1 do
	t 37.5, -50; b 3/8
	t 12.5, -50; b 3/8
	t -12.5, -50; b 1/4
	t -37.5, -50; b 1/2
	t -12.5, -50; b 1/4
	t 12.5, -50; b 1/4

	t 37.5, -50; b 3/8
	t 12.5, -50; b 3/8
	t -12.5, -50; b 1/4
	t -37.5, -50; b 1/2
	t -12.5, -50; b 1/4
	t 12.5, -50; b 1/4

	b 1/6
	t 37.5, -50; b 1/3
	t 12.5, -50; b 1/3
	t -12.5, -50; b 1/3+1/4-1/6
	t -37.5, -50; b 1/4
	t -12.5, -50; b 1/4
	t 12.5, -50; b 1/4

	t 37.5, -50; b 1/3
	t 12.5, -50; b 1/3
	t -12.5, -50; b 1/3
	t -37.5, -50; b 1/3
	t -12.5, -50; b 1/3
	t 12.5, -50; b 1/3

	t 37.5, -50; b 1/4
	t 12.5, -50; b 1/4
	t -12.5, -50; b 1/2
	t -37.5, -50; b 1/3
	t -12.5, -50; b 1/4
	t 12.5, -50; b 1-1/3-1/4

	b -1/12
	t 37.5, -50; b 1/3+1/12
	t 12.5, -50; b 1/3
	t -12.5, -50; b 1/3
	t -37.5, -50; b 1/3
	t -12.5, -50; b 1/3
	t 12.5, -50; b 1/3
	t 37.5, -50; b 1/3
end

bpm 130
tp_chain -100, 0, 1 do
	b -3/2
	bg_note -100, 0, 'Just'; b 1/2
	bg_note -75, 0, 'like'; b 1/2
	bg_note -50, 0, 'the'; b 1/2
	t -25, 0, 'ma-'; b 1/2
	bg_note 0, 0, 'gic'; b 1/2
	bg_note 25, 0, 'in-'; b 1/2
	t 50, 0, 'side'; b 3/2
	bg_note 75, 0, 'of'; b 1
	h 100, 0, 9, 'you'
end
#bg_note 0, 0, 12
5.times do |i|
	group preserve_beat: false do
		angle = -PI/2 + i*2*PI/5
		(1..4).each do |j|
			bg_note 12.5*j*cos(angle), 12.5*j*sin(angle), 8
			b 1/12
		end
		angle -= PI/9
		bg_note 50*cos(angle), 50*sin(angle), 8
	end
end

end
