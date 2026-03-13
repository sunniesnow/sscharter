# frozen_string_literal: true

include Math
Integer.alias_method :/, :quo
srand 1108

Sunniesnow::Charter.open 'master' do

title '经过'
artist '张杰/HOYO-MiX'
charter 'UlyssesZhan'
difficulty_name 'Master'
difficulty_color :master
difficulty '12'
difficulty_sup ?+

offset 1.793
bpm 77.338

#===========
# Intro
#===========

def tri x0, y0
	group do
		3.times do |i|
			angle = PI/2 + 2*PI*i/3
			x, y = x0 + cos(angle), y0 + sin(angle)
			bg_note x, y; b 1/3
		end
	end
end

def atri x0, y0
	transform(tri x0, y0) do
		horizontal_flip
		translate 2*x0, 0
	end
end

group preserve_beat: false do
	tri 4, 3
	tri -1, 1
	tri 3, -3
	tri -7, 1

	atri 2, 3
	atri 7, 1
	atri 3, -3
	atri -6, -1

	tri -4, 3
	tri 2, -2
	tri -7, 2
	tri 7, 1

	atri -2, 3
	atri -7, 1
	atri 2, 3
	atri 6, -1

	tri -7, 3
	tri 4, -2
	tri -7, -3
	tri 0, 2

	atri -6, 3
	atri 2, 3
	atri 6, -2
	atri -1, -3

	tri 6, 2
	tri 5, -3
	tri 0, 1
	tri -6, -2

	atri -7, 3
	atri 5, 0
end

tp_drop -8, 0, 1 do
	h -4, 3, 3; b 3
	h 4, 0, 1; b 1

	h -2, -2, 3; b 4
end

tp_drop 8, 0, 1 do
	h 4, 2, 2; b 3
	h -4, -1, 1; b 1

	h 2, -3, 2; b 3
	h -3, 0, 1; b 1
end

tp_drop -8, 0, 1 do
	h 4, 3, 2; b 2
	h -4, 0, 1; b 1
	h 5, -1, 1; b 1

	h -2, -2, 2; b 3
	h 2, 3, 1; b 1
end

tp_drop 8, 0, 1 do
	h -5, 1, 2; b 3
	h 4, -2, 1; b 1

	h 0, 3, 2; b 2
	t 0, -3; b 2
end

#===========
# Verse 1.1
#===========

group preserve_beat: false do
	b 16

	b 2
	tp_drop -8, 0, 1 do
		t -6, 0; b 1
	end
	tp_drop 8, 0, 1 do
		t 6, 2; b 1

		t 5, -2; b 2
	end
	tp_drop -8, 0, 1 do
		t -6, 0; b 1
	end
	tp_drop 8, 0, 1 do
		t 6, 2; b 1

		t 5, -2; b 2
		t 7, 0; b 2
	end
	tp_chain -8, 0, 1 do
		7.times do |i|
			x, y = -16*(i/6-1/3)**2, -4+16*(i/6-2/3)**2
			i==0||i==6 ? t(x, y) : d(x, y); b 1/3
		end
	end
end

tp_drop 0, -8, 1 do
	b -1/6
	h -4, 2, 2, ?用; b 3+1/6
end
tp_drop 8, 0, 1 do
	t 2, -4, ?情; b 1/3
	t 3, -2, ?绪; b 1/3
	t 4, 0, ?的; b 1/3

	b 1/12
	h 3, 2, 1, ?一; b 1
end
tp_drop 0, -8, 1 do
	h -3, 1, 4/3, ?种; b 2-1/12
end
tp_drop 8, 0, 1 do
	t 3, -3, ?云; b 1/3
	t 4, -1, ?层; b 1/3
	t 5, 1, ?的; b 1/3

	h 4, 3, 1, ?变; b 1+1/12
end
tp_drop 0, -8, 1 do
	h -4, 4, 4/3, ?动; b 2-1/12
end
tp_drop 8, 0, 1 do
	t 4, -2, ?以; b 1/3
	t 5, 0, ?诉; b 1/3
	t 6, 2, ?说; b 1/3

	h 5, 4, 1, ?不; b 1-1/12
end
tp_drop 0, -8, 1 do
	h -5, 2, 1, ?同; b 2+1/12
end
tp_drop 0, 8, 1 do
	h -1, -2, 1, ?无; b 1

	h 3, 0, 2, ?用; b 3
end
tp_drop -8, 0, 1 do
	t -2, -4, ?模; b 1/3
	t -3, -2, ?糊; b 1/3
	t -4, 0, ?在; b 1/3

	h -3, 2, 2/3, ?视; b 1
end
tp_drop 0, 8, 1 do
	h 0, 0, 2/3, ?线; b 1
	t 3, 2, ?中; b 1
end
tp_drop -8, 0, 1 do
	t -3, -3, ?去; b 1/3
	t -4, -1, ?追; b 1/3
	t -5, 1, ?寻; b 1/3

	h -4, 3, 5/3, ?一; b 2
end
tp_drop 0, 8, 1 do
	h 0, 1, 1, ?个; b 2

	h 4, 3, 7/3, ?梦
end
24.times do |i|
	angle = atan(3/2) - 2*PI * i/24
	x, y = hypot(4,6)*cos(angle), hypot(4,6)/2*sin(angle)
	bg_note x, y, 2-i/12; b 1/12
end
b 2

#===========
# Verse 2.1
#===========

def hex x0, y0
	group do
		6.times do |i|
			angle = 2*PI*i/6
			x, y = x0 + sqrt(3)*cos(angle), y0 + sqrt(3)*sin(angle)
			bg_note x, y; b 1/6
		end
	end
end
def ahex x0, y0
	transform(hex x0, y0) do
		horizontal_flip
		translate 2*x0, 0
	end
end
group preserve_beat: false do
	hex 3, 2
	hex -6, 2
	hex -1, -2
	hex 1, 2

	ahex -3, 2
	ahex 6, 2
	ahex 1, -2
	ahex -1, 2

	hex 5, 1
	hex -4, -2
	hex 6, -1
	hex -6, 2

	ahex 6, 1
	ahex -6, -1
	ahex -2, 2
	ahex 4, -1

	hex 3, 2
	hex -6, 2
	hex -1, -2
	hex 1, 2

	ahex -3, 2
	ahex 6, 2
	ahex 3, -2
	ahex -1, 2

	hex -5, -2
	hex 6, -2
	hex -6, 2
	hex 6, 2
end

tp_chain 0, 8, 1 do
	t -1, 3, ?跨; b 1/6
	t -5, 2, ?过; b 1/6
	t -3, 1, ?炎; b 1/6
	t -5, 0, ?热; b 1/6
	t -3, -1, ?寒; b 1/6
	t -5, -2, ?冷; b 1/6
	h -1, -3, 1/3, ?的; b 1/2
end
tp_chain 0, 8, 1 do
	t 3, 2, ?高; b 1/6
	t 5, 1, ?山; b 1/6
	t 3, 0, ?巨; b 1/6
	h 5, -1, 5/3, ?河; b 1
end
tp_chain -8, 0, 1 do
	h -5, -1, 2/3; b 1
end

tp_chain 0, 8, 1 do
	t 1, 3, ?穿; b 1/6
	t 5, 2, ?上; b 1/6
	t 3, 1, ?坚; b 1/6
	t 5, 0, ?硬; b 1/6
	t 3, -1, ?的; b 1/6
	t 5, -2, ?外; b 1/6
	h 1, -3, 1/3, ?壳; b 1/2
end
tp_chain 0, 8, 1 do
	t -3, 2, ?和; b 1/6
	t -5, 1, ?最; b 1/6
	t -3, 0, ?深; b 1/6
	t -5, -1, ?的; b 1/6
	t -3, -2, ?执; b 1/6
	h -5, -3, 1, ?着; b 2/3
end
tp_drop 8, 0, 1 do
	t 5, 2; b 1/3
	t 6, 0; b 1/3
	t 7, -2, ?我; b 1/3
end

tp_chain 0, -8, 1 do
	h -5, 2, 1, ?听; b 1
	h 2, 2, 1, ?说; b 1
	h -2, 1, 1, ?你; b 1
	h 3, -2, 1, ?来; b 1

	h -4, -4, 1, ?过; b 1
end
tp_drop -8, 0, 1 do
	t 5, 3; b 1
end
tp_drop 0, -8, 1 do
	h 2, 3, 5/3; b 1
end
tp_drop 0, 8, 1 do
	h -2, -3, 2/3; b 1
end

tp_chain 0, 8, 1 do
	t -1, 3, ?蓝; b 1/6
	t -3, 2, ?的; b 1/6
	t -5, 1, ?粉; b 1/6
	t -3, 0, ?的; b 1/6
	t -5, -1, ?很; b 1/6
	t -3, -2, ?多; b 1/6
	h -1, -3, 1/3, ?爱; b 1/2
end
tp_chain 0, 8, 1 do
	t 3, 2, ?无; b 1/6
	t 1, 1, ?垠; b 1/6
	t 3, 0, ?深; b 1/6
	h 5, -1, 5/3, ?海; b 1
end
tp_chain -8, 0, 1 do
	h -5, -1, 2/3; b 1
end

tp_chain 0, 8, 1 do
	t 1, 3, ?尝; b 1/6
	t 3, 2, ?过; b 1/6
	t 5, 1, ?反; b 1/6
	t 3, 0, ?复; b 1/6
	t 5, -1, ?的; b 1/6
	t 3, -2, ?失; b 1/6
	h 1, -3, 1/3, ?败; b 1/2
end
tp_chain 0, 8, 1 do
	t -3, 2, ?和; b 1/6
	t -5, 1, ?漫; b 1/6
	t -3, 0, ?长; b 1/6
	t -1, -1, ?的; b 1/6
	t -3, -2, ?忍; b 1/6
	h -5, -3, 1, ?耐; b 2/3
end
tp_drop 8, 0, 1 do
	t 5, 2; b 1/3
	t 6, 0; b 1/3
	t 7, -2, ?伤; b 1/3
end

tp_chain 0, -8, 1 do
	h -5, 2, 1, ?痛; b 1
	h 2, 2, 1, ?终; b 1
	h -2, -1, 1/3, ?将; b 1
	h 3, -2, 2/3, ?被; b 2/3
	t -3, 3, ?覆; b 1/3

	h 0, 2, 2, ?盖; b 1
end
9.times do |i|
	y = 4 - i
	8.times do |j|
		x = 8-j
		bg_note x, y; bg_note -x, y; b 2/72
	end
	bg_note 0, y
end
b 1

#===========
# Verse 3.1
#===========

def curve1 text = ''
	tp_chain -8, 0, 1, preserve_beat: false do
		12.times do |i|
			x, y = 8-16*i/12, -4+8*(1-i/12)**2
			i==0 ? h(x, y, 5/3, text) : d(x, y); b 1/6
		end
	end
end
def curve2 text = '', second_half = false
	tp_chain 0, 8, 1, preserve_beat: false do
		12.times do |i|
			break if i==6 && !second_half
			x, y = 2-8*(i/12-sin(2*PI*i/12)/4), -4+7*4*(i/12-1/2)**2
			i==0 ? h(x, y, 2/3, text) : d(x, y); b 1/6
		end
	end
end
def curve3 text = ''
	tp_chain 0, 8, 1, preserve_beat: false do
		6.times do |i|
			x, y = -6+8*((i/6)*1/3+(i/6)**2*2/3), -3+6*9/4*(i/6-2/3)**2
			i==0 ? h(x, y, 2/3, text) : d(x, y); b 1/6
		end
	end
end
def curve6 text = ''
	tp_chain -8, 0, 1, preserve_beat: false do
		12.times do |i|
			x, y = 8 - 14*(i/12-sin(2*PI*i/12)/8), -4 + (15-8*i/12) * 9/4*(i/12-1/3)**2
			i==0 ? h(x, y, 5/3, text) : d(x, y); b 1/6
		end
	end
end
def curve7 text = ''
	tp_chain 0, 8, 1, preserve_beat: false do
		6.times do |i|
			angle = PI/2 + (2*PI-PI/2) * i/6
			x, y = 6 + 2*cos(angle), 3*sin(angle)
			i==0 ? h(x, y, 2/3, text) : d(x, y); b 1/6
		end
	end
end

b -1
tp_chain 0, 8, 1 do
	h -4, 2, 2/3, ?越; b 1
end
curve6
transform(curve1 ?坠) { scale 5/8, 7/8; translate -3, -1/2 }; b 2
tp_chain 0, 8, 1 do
	h -8, -4, 5/3
end
curve3 ?落; b 1
tp_chain 8, 0, 1 do
	t 2, -3/2, ?巨; b 1/3
	t 4, 0, ?大; b 1/3
	t 5, 2, ?沉; b 1/3
end

tp_chain 0, -8, 1 do
	h -8, 4, 5/3
end
curve2 ?默, false; b 1
tp_chain -8, 0, 1 do
	t -2, -4, ?难; b 1/3
	t 0, -1, ?解; b 1/3
	t 3, 1, ?的; b 1/3
end
tp_chain 0, -8, 1 do
	h 0, 4, 2/3
end
curve7 ?困; b 1
tp_chain 0, -8, 1 do
	h 8, 0, 2/3
end
tp_chain -8, 0, 1 do
	t -2, -3/2, ?惑; b 2/3
end
tp_chain 0, 8, 1 do
	t -4, 3, ?越; b 1/3
end

tp_chain 0, 8, 1 do
	h -8, -4, 5/3
end
transform(curve1 ?挣) { horizontal_flip }; b 2
tp_chain 0, 8, 1 do
	h 8, -4, 5/3
end
transform(curve3 ?脱) { horizontal_flip }; b 1
tp_chain 8, 0, 1 do
	t -2, -3/2, ?回; b 1/3
	t -4, 0, ?忆; b 1/3
	t -5, 2, ?的; b 1/3
end

tp_chain 0, -8, 1 do
	h 8, 4, 5/3
end
transform(curve2 ?脆, false) { horizontal_flip }; b 1
transform(curve3 ?弱) { rotate PI; translate -4, -1 }; b 1
tp_chain 0, -8, 1 do
	h -6, 1/2, 5/3; b 1
end
transform(curve2 ?自) do
	scale 1, 6/7
	translate 0, 4 - 3*6/7
end; b 1

def curve4 text = ''
	tp_chain 0, -8, 1, preserve_beat: false do
		12.times do |i|
			x, y = 8 - 10 * 9/4*(i/12-2/3)**2, -4 + 8 * 9/4*(i/12-1/3)**2
			i==0 ? h(x, y, 5/3, text) : d(x, y); b 1/6
		end
	end
end
def curve5 text = ''
	tp_chain 0, 8, 1, preserve_beat: false do
		6.times do |i|
			x, y = -8 * i/6, 3 - 2 * 4*(i/6-1/2)**2
			i==0 ? h(x, y, 2/3, text) : d(x, y); b 1/6
		end
	end
end

curve4
curve5 ?由; b 1
tp_chain 0, -8, 1 do
	h -8, 1, 1/3, ?走; b 2/3
	t -2, 2, ?向; b 1/3
	h 1, 0, 1/3, ?我
end
tp_chain 0, -8, 1 do
	h 11/2, 4, 5/3; b 1
end
tp_chain 0, 8, 1 do
	%w[伴 随 着].each_with_index do |text, i|
		angle = PI + PI/2 * i/3
		x, y = 6*cos(angle), 1 + 5*sin(angle)
		t x, y, text; b 1/3
	end
end

def curve8 text = ''
	tp_chain -8, 0, 1, preserve_beat: false do
		4.times do |i|
			angle = -PI/2 + PI * i/4
			x, y = 4*cos(angle), 4*sin(angle)
			i==0 ? h(x, y, 1/3, text) : d(x, y); b 1/6
		end
	end
end

curve8 ?风
tp_chain 0, -8, 1 do
	h -5, 4, 2/3; b 2/3
	t 0, 4, ?花; b 1/3
end
transform(curve8 ?的) { horizontal_flip }
tp_chain 0, -8, 1 do
	h 5, 4, 2/3; b 2/3
	t 0, 4, ?抚; b 1/3
end
tp_chain 0, 8, 1 do
	h -2, 0, 2/3
end
tp_chain 0, 8, 1 do
	h 2, 0, 2/3, ?摸; b 1
	tp_chain 0, 8, 1 do
		h -7, 1, 2/3
	end
	t 7, 1, ?一; b 1/3
	t 6, -2, ?定; b 1/3
	t 3, -3, ?会; b 1/3
end

def archimedes x_start, y_start, x_end, y_end, x_center, y_center, n
	angle1 = atan2 y_start-y_center, x_start-x_center
	r1 = hypot x_start-x_center, y_start-y_center
	angle2 = atan2 y_end-y_center, x_end-x_center
	r2 = hypot x_end-x_center, y_end-y_center
	n.times do |i|
		angle = angle1 + (angle2-angle1) * i/n
		r = r1 + (r2-r1) * i/n
		yield x_center + r*cos(angle), y_center + r*sin(angle), i
	end
end
def curve9 text = ''
	tp_chain 0, 8, 1, preserve_beat: false do
		archimedes 2, 2, 1, -1, 4.5, 0.2, 10 do |x, y, i|
			i==0 ? h(x, y, 4/3, text) : d(x, y); b 1/6
		end
	end
end

curve9 ?有
transform(curve9) { rotate PI }; b 5/3
tp_chain 8, 0, 1 do
	t 1, -1, ?那; b 1/6
	t -1, 0, ?天; b 1/6
	mark :m
end
tp_chain 0, -8, 1 do
	10.times do |i|
		angle = (PI - atan(8/15)) * (5-i)/5
		x, y = 15/4 + 17/4*cos(angle), 4*sin(angle)
		if i == 0
			h -x, y, 4/3, ?吧
		else
			d -x, y
			at(:m) { d x, y }
		end
		b 1/6
		at(:m, update_mark: true) { b 1/6 }
	end
end
tp_chain 0, 8, 1 do
	t 0, -2, ?请; b 1/3
end

def curve10 text = ''
	tp_chain 8, 0, 1, preserve_beat: false do
		12.times do |i|
			angle = -PI + 2*PI * i/12
			x, y = 4 + 4*(1-3/4*exp(-10*i/12))*cos(angle), 4*sin(angle)
			i==0 ? h(x, y, 5/3, text) : d(x, y); b 1/6
		end
	end
end
def curve11 text = '', has_head = true
	tp_chain -8, 0, 1, preserve_beat: false do
		10.times do |i|
			angle1 = -PI + PI*2 * i/10
			angle2 = -PI + PI*3/2 * i/10
			x, y = 4+4*cos(angle1), 4*sin(angle2)
			i==0 ? (h(x, y, 4/3, text) unless text.empty?) : d(x, y); b 1/6
		end
	end
end

curve10
transform(curve10 ?回) { horizontal_flip }; b 2
curve11 ?答
transform(curve11) { horizontal_flip }; b 5/3
tp_chain 0, -8, 1 do
	t 0, 4, ?回; b 1/3
end

def curve12 text = ''
	tp_chain 0, 8, 1, preserve_beat: false do
		24.times do |i|
			t = 1 - (1-i/24)**2
			upper = 4 + 8*t**2
			lower = -4 + 8*t
			x, y = 8 - (lower + (upper-lower)*(1+sin(2*PI*t))/2), 4-8*t+7*t*sin(3*PI*t)
			i==0 ? h(x, y, 4-1/3, text) : d(x, y); b 1/6
		end
	end
end

curve12 ?答
transform(curve12) { horizontal_flip }; b 4

#===========
# Interlude
#===========

tp_chain 0, 8, 1 do
	t 0, -4; b 4
end

notes = tp_chain -8, 8, 1 do
	t -4, 4; b 1/3
	d -4-4/3, 8/3; b 1/3
	d -4-8/3, 4/3; b 1/3
	d -8, 0; b 1/3
	d -8+4/3, -4/3; b 1/3
	d -8+8/3, -8/3; b 1/3
end
transform(duplicate notes) do
	horizontal_flip
	beat_translate 2
end
b 2

tp_chain -8, -8, 1 do
	t -4, 0; b 1/3
	d -8/3, -4/3; b 1/3
	d -4/3, -8/3; b 1/3
	d 0, -4; b 1/3
	d 4/3, -8/3; b 1/3
	d 8/3, -4/3; b 1/3
end
tp_chain 8, 8, 1 do
	t 4, 0; b 1/3
	d 8/3, 4/3; b 1/3
	d 4/3, 8/3; b 1/3
	t 0, 4; b 1/3
	d -4/3, 8/3; b 1/3
	d -8/3, 4/3; b 1/3
end

tp_chain 0, 8, 1 do
	f -4, 0, :l
end
tp_chain -8, 0, 1 do
	t 3, 2; b 1/2
end
tp_drop 8, 0, 1 do
	t 7, 4; b 1/6
	t 7, 2; b 1/6
	t 7, 0; b 1/6
	t 7, -2
end
tp_chain -8, 0, 1 do
	t -2, -4; b 1/3
	t 1, -2; b 1/6
	t 3, -1; b 1/6
	t 1, 0; b 1/6
	t -1, 1; b 1/6
	t 1, 2
end
tp_chain -8, 0, 1 do
	t 7, 3; b 1/3
end
tp_drop -8, 0, 1 do
	5.times do |i|
		t -6, 4-2*i; b 1/6 unless i==4
	end
end
tp_chain 8, 0, 1 do
	7.times do |i|
		t 1+2*(-1)**i, 4-i; b 1/6 unless i==6
	end
end

tp_chain 8, 0, 1 do
	t -6, 2; b 1/3
end
tp_drop 8, 0, 1 do
	5.times do |i|
		t 6, 4-2*i; b 1/6 unless i==4
	end
end
tp_chain -8, 0, 1, preserve_beat: false do
	t -7, 2; b 1/3
	t -4, 3; b 1/3
	t -1, 3; b 1/3
	t 2, 2
end
tp_drop 0, 8, 1 do
	3.times { b 1/6; t 1, -2; b 1/6 }
	t -1, -2; b 1/3
end
tp_drop -8, 0, 1 do
	5.times do |i|
		t -7, 4-2*i; b 1/6 unless i==4
	end
end
tp_chain 0, 8, 1 do
	t 4, 2; b 1/6
	t 0, 3; b 1/6
	t 4, 0; b 1/6
	t -2, 1; b 1/6
	f 4, -2, :r; b 1/6
	f 0, -1, :l; b 1/6

	f 6, 0, :ur; b 1/6
end
tp_drop 8, 0, 1, preserve_beat: false do
	t 1, -3; b 1/3
	t 1, -1; b 1/3
	t 1, 1; b 1/6
	t -1, 2
end
tp_chain 0, -8, 1 do
	b 1/6
	t 3, -2; b 1/3
	t 3, 0; b 1/3
	f 3, 2, :r; b 1/3
end
tp_drop 0, -8, 1 do
	t -4, 4
	t 8, 3; b 1/3
end
tp_chain 0, 8, 1 do
	t -2, 1; b 1/6
	t -4, 0; b 1/6
	t -6, -1
	tp_drop 0, 8, 1 do
		f 0, -1, :r; b 1/6
	end
	t -4, -2; b 1/6
	t -2, -3; b 1/6
	t 0, -4; b 1/6
	t 2, -3; b 1/6
	t 0, -2; b 1/6
	t 2, -1
end
tp_chain 0, 8, 1 do
	f -2, -1, :l; b 1/3
end
tp_drop 0, -8, 1 do
	t 5, 3; b 1/6
	t 3, 3; b 1/6
	t 1, 3; b 1/6
	t -1, 3; b 1/6

	t -3, 3
end
tp_drop 0, 8, 1 do
	f 2, 0, :r; b 1/2
end
tp_drop 0, -8, 1 do
	f -6, 3, :ul
	f 6, 2, :dr; b 1/3
	t -3, 2; b 1/6
	f -4, 1, :dl
	f 3, 0, :ur; b 1/3
	f -2, -1, :dl
	f 1, 2, :ur; b 1/3
	f 0, -3, :dl
	f -1, 4, :ur; b 1/3
	h 2, -1, 5/3
	h -3, 2, 5/3; b 2
end

#==========
# Verse 2.2
#==========

notes = group preserve_beat: false do
	hex 3, 2
	hex -6, 2
	hex -1, -2
	hex 1, 0

	ahex -3, 2
	ahex 6, 2
	ahex 1, -2
	ahex -1, 2

	hex 5, 1
	hex -4, -2
	hex 6, -1
	hex -6, 2

	ahex 6, 1
	ahex -6, -1
	ahex -5, 2
	ahex 6, -1

	hex 3, 2
	hex -6, 2
	hex -1, -2
	hex 1, 2

	ahex -3, 2
	ahex 6, 2
	ahex 3, -2
	ahex -1, 2

	hex -6, -1
	hex 6, -2
	hex -2, -2
	hex 6, 2
end
transform(notes) do
	horizontal_flip
end

tp_chain 0, 8, 1 do
	tp_chain 8, 0, 1 do
		t 7, 3
	end
	f 1, 3, :l, ?越; b 1/6
	t 5, 2, ?过; b 1/6
	t 3, 1, ?黄; b 1/6
	f 6, 0, :r, ?昏; b 1/6
	t 3, -1, ?黎; b 1/6
	t 5, -2, ?明; b 1/6
	f 1, -3, :l, ?的; b 1/3
end
tp_chain -8, 0, 1 do
	t -1, 3; b 1/6
end
tp_chain 0, 8, 1 do
	t -3, 2, ?无; b 1/6
	t -5, 1, ?数; b 1/6
	t -3, 0, ?阻; b 1/6
	h -5, -1, 1, ?拦; b 1/6
end
tp_chain 0, -8, 1 do
	t -3, -2; b 1/3
	t 0, 0; b 1/2
end
tp_chain -8, 0, 1 do
	h 5, -1, 2/3; b 1/3
end
tp_chain 8, 0, 1 do
	t 1, -2; b 2/3
end

tp_chain 0, 8, 1 do
	f -1, 3, :r, ?翻; b 1/6
	t -5, 2, ?过; b 1/6
	t -3, 1, ?古; b 1/6
	f -6, 0, :l, ?老; b 1/6
	t -3, -1, ?的; b 1/6
	f -5, -2, :l, ?群; b 1/6
	f -1, -3, :r, ?山; b 1/3
end
tp_chain 8, 0, 1 do
	t 1, 3; b 1/6
end
tp_chain 0, 8, 1 do
	t 3, 2, ?到; b 1/6
	t 5, 1, ?另; b 1/6
	t 3, 0, ?一; b 1/6
	t 5, -1, ?个; b 1/6
	t 3, -2, ?对; b 1/6
	h 5, -3, 1, ?岸; b 1/6
end
tp_chain 8, 0, 1 do
	t 3, -4; b 1/2
end
tp_drop -8, 0, 1 do
	t -5, 2; b 1/3
	t -6, 0; b 1/3
	t -7, -2, ?我; b 1/3
end

tp_chain 0, -8, 1 do
	f 5, 2, :r, ?听; b 1/2
	tp_drop 0, -8, 1 do
		f 2, 0, :r; b 1/2
	end
	f -2, 2, :l, ?说; b 1/3
	tp_chain -8, 0, 1 do
		t -5, 3; b 2/3
	end
	h 2, 1, 1, ?你; b 1/6
	tp_chain 8, 0, 1 do
		t 0, 2; b 1/3
		t -3, 1; b 1/2
	end
	h -3, -2, 1, ?来; b 1/3
	tp_chain -8, 0, 1 do
		t 1, -3; b 2/3
	end

	f 4, -4, :r, ?过; b 1/2
end
tp_drop 0, -8, 1 do
	f 4, 0, :r; b 1/3
	f -3, 2, :r; b 1/6
end
tp_drop 8, 0, 1 do
	f -5, 3, :l; b 1/3
end
tp_chain 8, 0, 1 do
	t 3, 4; b 2/3
end
tp_drop 0, -8, 1 do
	h -2, 3, 1; b 1/6
end
tp_chain -8, 0, 1 do
	t 0, 2; b 1/3
	t 3, 0; b 1/2
end
tp_drop 0, 8, 1 do
	h 2, -3, 2/3; b 1/3
end
tp_chain 8, 0, 1 do
	t -2, -2; b 2/3
end

tp_chain 0, 8, 1 do
	f 1, 3, :l, ?轻; b 1/6
	t 3, 2, ?的; b 1/6
	t 5, 1, ?重; b 1/6
	f 2, 0, :l, ?的; b 1/6
	t 5, -1, ?很; b 1/6
	t 3, -2, ?多; b 1/6
	f 1, -3, :l, ?话; b 1/6
end
tp_chain 8, 0, 1 do
	t 3, -4; b 1/6
end
tp_chain -8, 0, 1 do
	t -5, 3; b 1/6
end
tp_chain 0, 8, 1 do
	t -3, 2, ?说; b 1/6
	t -1, 1, ?不; b 1/6
	t -3, 0, ?出; b 1/6
	h -5, -1, 1, ?来; b 1/2
end
tp_drop 0, 8, 1 do
	t -1, -1; b 1/3
	t 3, -2; b 1/6
	tp_chain 8, 0, 1 do
		h 5, -1, 2/3; b 1/2
	end
	t 2, 1; b 1/6
	t 1, -1; b 1/3
end

tp_chain 0, 8, 1 do
	f -1, 3, :r, ?轨; b 1/6
	t -3, 2, ?迹; b 1/6
	t -5, 1, ?刚; b 1/6
	f -2, 0, :r, ?刚; b 1/6
	t -5, -1, ?好; b 1/6
	f -3, -2, :l, ?错; b 1/6
	f -1, -3, :r, ?开; b 1/6
end
tp_chain -8, 0, 1 do
	t -3, -4; b 1/6
end
tp_chain 8, 0, 1 do
	t 5, 3; b 1/6
end
tp_chain 0, 8, 1 do
	t 3, 2, ?我; b 1/6
	t 5, 1, ?越; b 1/6
	t 3, 0, ?渐; b 1/6
	t 1, -1, ?渐; b 1/6
	t 3, -2, ?明; b 1/6
	t 5, -3, ?白; b 1/6
end
tp_chain 8, 0, 1 do
	t 3, -4; b 1/6
end
tp_chain 0, -8, 1 do
	t 0, -3; b 1/9
	t 1, -2; b 1/9
	t 0, -1; b 1/9
	t 1, 0; b 1/3
end
tp_drop 0, -8, 1 do
	t -6, 2; b 1/6
	t -5, 0; b 1/6
	t -3, -1, ?重; b 1/6
	t -1, 0; b 1/6

	t 0, 2
end
tp_chain 0, -8, 1 do
	t 5, 2, ?逢; b 1/3
	tp_drop 8, 0, 1 do
		t 4, -2; b 1/6
		t 5, -4
	end
	tp_drop -8, 0, 1 do
		t -5, -3; b 1/3
		t -4, 1; b 1/6
	end
	t -2, 2, ?那
	tp_drop 0, 8, 1 do
		t 0, -3; b 1/3
		f 4, -2, :ur; b 1/3
	end
	tp_drop -8, 0, 1 do
		t -6, -2; b 1/6
		t -5, 0; b 1/6
		t -6, 2
	end
	t 2, -1, ?天; b 1/3
	tp_drop -8, 0, 1 do
		f 1, 3, :ul; b 1/2
		tp_drop 8, 0, 1, preserve_beat: false do
			t 5, -2; b 1/6
			t 7, -3
		end
		t -4, 0; b 1/6
	end
	t -3, -2, ?会; b 1/3
	tp_chain 0, 8, 1 do
		f 6, 1, :ur; b 1/3
	end
	t 3, 3, ?到; b 1/6
	tp_chain 8, 0, 1 do
		t 2, 1; b 1/6
	end

	t 0, 2, ?来
end
group preserve_beat: false do
	24.times do |i|
		angle = PI/2-(PI/2-atan(3/2)+4*PI)*i/24
		r = 2+(hypot(2,3)-2)*i/24
		x, y = r*cos(angle), r*sin(angle)
		bg_note x, y; b 1/12
	end
end
tp_drop -8, 0, 1 do
	t -7, 3; b 1/6
	t -6, 1; b 1/6
	t -5, -1; b 1/6
	f -4, -3, :ul
end
tp_drop 8, 0, 1 do
	t 4, 0; b 1/3
	t 2, -3
	tp_drop 0, -8, 1 do
		t -1, 3; b 1/6
		t -3, 4
	end
	f 1, -1, :ur; b 1/3
end
tp_drop 0, -8, 1, preserve_beat: false do
	b 1/6
	t 5, 0; b 1/3
	t 2, -2
end
tp_drop 0, 8, 1 do
	f -4, -1, :ul; b 1/3
	f -1, 1, :ul; b 1/3
	f 2, 3, :ur; b 2
end

#===========
# Verse 3.2
#===========

b -1
tp_chain -8, 0, 1 do
	12.times do |i|
		x, y = -4+11*(i/12)**2, -3+7*(1-(1-i/12)**2)
		i==0 ? h(x, y, 2/3, ?去) : d(x, y); b 1/12
	end
end

fun = ->t { 20*(t-1/2) - 100*(t-1/2)**3 - 5*t**2 + 6*(t-1/48)**10 }
tp_chain 0, 8, 1, preserve_beat: false do
	20.times do |i|
		t = i/20
		x = 15*4*(t-1/2)**2 - 8 + t
		y = fun[t] - fun[0] + 4
		i==0 ? h(x, y, 4/3, ?触) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f 5, -3, :ul; b 1/3
	t 1, -4; b 1/3
	t -4, -4; b 1/3
end
tp_drop 8, 0, 1 do
	f -8, -2, :ul; b 1/3
	t -8, 3; b 1/3
end
tp_drop 0, -8, 1 do
	t -4, 4; b 1/6
end
tp_drop 0, 8, 1 do
	t 3, -1; b 1/6
end
tp_chain 0, -8, 1, preserve_beat: false do
	12.times do |i|
		x, y = -2 + 12*9/4*(i/12-1/3)**2 - 2*i/12, 4 - 7*(1-(1-i/12)**2)
		i==0 ? h(x, y, 2/3, ?摸) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f 1, 0, :ur; b 1/3
	t 4, 3; b 1/3
end
tp_drop -8, 0, 1 do
	t 8, 1; b 1/6
	t 7, -1; b 1/6
	f 8, -3, :ul, ?最; b 1/3
end
tp_drop 8, 0, 1 do
	t -5, 3, ?亮; b 1/6
	t -5, 1; b 1/6
end
tp_drop -8, 0, 1 do
	t 2, 0, ?的; b 1/6
	t 2, -2; b 1/6
end

tp_chain 0, 8, 1, preserve_beat: false do
	12.times do |i|
		x, y = 6 - 12*9/4*(i/12-1/3)**2 + 2*i/12, -4 + 8*(1-(1-i/12)**2)
		i==0 ? h(x, y, 2/3, ?光) : d(x, y); b 1/12
	end
end
tp_drop 8, 0, 1 do
	f -3, -3, :ul; b 1/3
	t -1, 0; b 1/3
end
tp_drop -8, 0, 1 do
	t 3, 1; b 1/3
	f 7, 4, :ur
end
tp_chain 0, -8, 1 do
	4.times do |i|
		angle = PI/2 + 2*PI/3*i/4
		x, y = -4+4*cos(angle), 4*sin(angle)
		i==0 ? t(x, y, ?最) : d(x, y); b 1/12
	end
end
tp_chain 8, 0, 1 do
	4.times do |i|
		angle = PI/2 + 2*PI/3*(1+i/4)
		x, y = -4+4*cos(angle), 4*sin(angle)
		i==0 ? t(x, y, ?美) : d(x, y); b 1/12
	end
end
tp_chain 0, 8, 1 do
	t -1, -2, ?的; b 1/6
	t 1, -1; b 1/6
end
tp_chain -8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = 3+20*(i/12)**2-28*(i/12)**4, 4*sin(-PI + 3*PI/2*i/12)
		i==0 ? h(x, y, 2/3, ?焰) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1 do
	f 0, 1, :ul; b 1/3
	t -4, 2; b 1/3
	t -8, 1; b 1/3
end
tp_drop 0, -8, 1 do
	f 4, 4, :ur
end
tp_chain 0, -8, 1 do
	4.times do |i|
		x, y = -5+2*(1-(1-i/4)**2), 4-5*i/4
		i==0 ? t(x, y, ?火) : d(x, y); b 1/12
	end
end
b 1/3
tp_drop 8, 0, 1 do
	t -8, 1, ?是; b 1/6
	t -6, 2; b 1/6
end

tp_chain 0, 8, 1, preserve_beat: false do
	20.times do |i|
		t = i/20
		x = -15*4*(t-1/2)**2 + 8 - t
		y = fun[t] - fun[0] + 4
		i==0 ? h(x, y, 4/3, ?岁) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f -5, -3, :ur; b 1/3
	t -1, -4; b 1/3
	t 4, -4; b 1/3
end
tp_drop 8, 0, 1 do
	f 8, -2, :ur; b 1/3
	t 8, 3; b 1/3
end
tp_drop 0, -8, 1 do
	t 4, 4; b 1/3
end
tp_chain 0, -8, 1, preserve_beat: false do
	12.times do |i|
		x, y = 2 - 12*9/4*(i/12-1/3)**2 + 2*i/12, 4 - 7*(1-(1-i/12)**2)
		i==0 ? h(x, y, 2/3, ?月) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	t -8, fun[1]-fun[0]+4; b 1/3
	f -5, 2, :l; b 1/3
end
tp_drop -8, 0, 1 do
	f -3, -1, :l; b 1/3
	f -8, -3, :ul, ?温; b 1/3
end
tp_drop 8, 0, 1 do
	t 5, 3, ?柔; b 1/6
	t 5, 1; b 1/6
end
tp_drop -8, 0, 1 do
	t -2, 0, ?地; b 1/6
	t -2, -2; b 1/6
end

tp_chain -8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = 8-16*i/12, 4-4*4*(i/12-1/2)**2
		i==0 ? h(x, y, 2/3, ?经) : d(x, y); b 1/12
	end
end
tp_drop 8, 0, 1 do
	f 3, -3, :ul; b 1/3
	t 1, 0; b 1/3
end
tp_drop -8, 0, 1 do
	t -3, 1; b 1/3
	f -7, 4, :ur
end
tp_chain -8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = -8+16*i/12, -4+4*4*(i/12-1/2)**2
		i==0 ? h(x, y, 2/3, ?过) : d(x, y); b 1/12
	end
end
b 5/6
tp_drop 0, 8, 1 do
	t 6, 0; b 1/6
	h 8, 0, 2/3
	f 4, 1, :ul; b 1/3
	t -1, 2; b 1/3
	t -6, 1; b 1/3
end
tp_chain -8, 0, 1, preserve_beat: false do
	8.times do |i|
		x, y = -8+8*i/8, 4-6*(i/8)**2
		i==0 ? h(x, y, 2/3, ?自) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1 do
	f -3, 4, :ur; b 1/3
	f 1, 2, :r; b 1/3
end
tp_drop 0, 8, 1 do
	t 0, -2; b 1/6
	t 2, -3; b 1/6
end

tp_chain 0, 8, 1, preserve_beat: false do
	12.times do |i|
		x, y = 12*9/4*(i/12-1/3)**2 + 1-5*i/12, 4 - 8*9/4*(i/12-2/3)**2
		i==0 ? h(x, y, 2/3, ?由) : d(x, y); b 1/12
	end
end
tp_drop -8, 0, 1 do
	f 0, -4, :ul; b 1/3
	t -4, -2; b 1/3
	t -6, 2; b 1/3
end
tp_chain 0, -8, 1, preserve_beat: false do
	8.times do |i|
		x, y = -4 + 8*9/4*(i/8-1/3)**2 - 3*i/8, 4-6*(i/8)**2
		i==0 ? h(x, y, 1/3, ?托) : d(x, y); b 1/12
	end
	t 1, -2, ?住
end
tp_drop 0, 8, 1 do
	f 8, 2, :ur; b 1/3
	t 4, 0; b 1/3
	f 2, 4, :r; b 1/3
end
tp_chain 0, -8, 1, preserve_beat: false do
	4.times do |i|
		x, y = 6-2*(1-(1-i/4)**2), 2-5*i/4
		i==0 ? t(x, y, ?我) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f -2, 1, :ul; b 1/3
end
tp_drop 8, 0, 1 do
	t -6, 0; b 1/3
	t -8, 4; b 1/3
end
tp_drop -8, 0, 1, preserve_beat: false do
	t -3, 3, ?我; b 1/3
	f -1, 0, :l; b 1/2
	t 3, -3; b 1/6
end
tp_drop 8, 0, 1 do
	f 5, 4, :ur; b 1/3
	t 3, 1, ?去; b 1/3
	f 5, -2, :r, ?往; b 1/3
end

tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		x, y = 8-12*9/4*(i/8-1/3)**2, -4+7*i/8
		i==0 ? h(x, y, 1/3, ?未) : d(x, y); b 1/12
	end
	f -4, 3, :l
end
tp_drop 8, 0, 1 do
	f 1, -4, :ul; b 1/3
	t -1, 0; b 1/3
	t 1, 4, ?知; b 1/3
end
tp_chain 0, 8, 1, preserve_beat: false do
	8.times do |i|
		x, y = -8+12*9/4*(i/8-1/3)**2, -4+7*i/8
		i==0 ? h(x, y, 1/3, ?的) : d(x, y); b 1/12
	end
	f 4, 3, :r
end
tp_drop -8, 0, 1 do
	f -1, -4, :ur; b 1/3
	t 1, 0; b 1/3
	t -1, 4, ?辽; b 1/3
end
tp_chain 0, -8, 1, preserve_beat: false do
	4.times do |i|
		x, y = 8-2*(i/4)**2, 4-5*i/4
		i==0 ? t(x, y, ?阔) : d(x, y); b 1/12
	end
end
tp_drop 0, 8, 1 do
	f -6, 3, :ul; b 1/3
	t -3, 0; b 1/3
	t 2, -1; b 1/3
	f 6, -3, :ur
end
tp_drop -8, 0, 1 do
	t -2, -4, ?在; b 1/3
	t 0, 0, ?旅; b 1/3
end
tp_drop 0, -8, 1 do
	t -1, 4, ?途; b 1/6
	t -3, 3; b 1/6

	f -5, 2, :ul
end
tp_chain 0, -8, 1, preserve_beat: false do
	20.times do |i|
		angle = PI/2 - (7/2*PI)*i/20
		x, y = 3*cos(angle) + 5 - 8*i/20, 3*sin(angle) + 1 - 2*i/20
		i==0 ? h(x, y, 4/3, ?的) : d(x, y); b 1/12
	end
	t -6, -1, ?最
end
tp_drop 0, 8, 1 do
	b 1/3
	t -2, -2; b 1/6
	t -4, -3; b 1/3
end
tp_drop 8, 0, 1 do
	t -7, 1; b 1/6
	t -6, 3; b 1/3
	f -2, 1, :ul; b 1/2
	t -7, 1, ?终; b 1/6
end
tp_chain -8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = 5 - 11*4*(i/12-1/2)**2, 3 - 7*(i/12-sin(2*PI*i/12)/7)
		i==0 ? h(x, y, 2/3, ?点) : d(x, y); b 1/12
	end
	h -6, -4, 1/3
end
tp_drop 8, 0, 1 do
	f 1, 4, :ur; b 1/3
	f 6, 2, :ur; b 1/2
	f 8, -2, :ur; b 1/2
	f 4, -4, :ur; b 1/3
end
tp_drop 0, -8, 1 do
	f -2, 0, :l, ?再; b 1/6
	t 0, 1; b 1/6
end

group preserve_beat: false do
	24.times do |i|
		angle = -PI - 7/2*PI*i/24
		x, y = (2+2*i/24)*cos(angle) + 4 - 8*i/24, (2+i/24)*sin(angle) + 2 - 2*i/24
		bg_note x, y; b 1/12
	end
end
tp_drop -8, 0, 1 do
	f -2, 2, :ul
end
tp_drop 0, 8, 1 do
	t 2, 2, ?见; b 1/6
	t 4, 1; b 1/6
	t -6, 3; b 1/6
	t -8, 2; b 1/6
	t 5, 4; b 1/6
	t 7, 3; b 1/6
	t -3, 0; b 1/6
	t -5, -1; b 1/6
	f 6, -1, :ur; b 1/6
	t 8, -2; b 1/6
	t 0, -3; b 1/6
	t -2, -4; b 1/6
	t -4, -3, ?会
end
group preserve_beat: false do
	20.times do |i|
		angle = -PI/2 - 9/2*PI*i/20
		x, y = (2+2*i/20)*cos(angle) - 4 + i/20, (2+2*i/20)*sin(angle) - 1 + i/20
		bg_note x, y; b 1/12
	end
end
tp_drop 0, -8, 1 do
	t 4, -4; b 1/6
	t 3, -2; b 1/6
	t -8, -2; b 1/6
	t -7, 0; b 1/6
	t 6, -1; b 1/6
	t 5, 1; b 1/6
	t 6, 3, ?去
	t -3, -2; b 1/6
	t -2, 0; b 1/6
	t 2, 1; b 1/6
	t 1, 3; b 1/6
	t -7, 0, ?再; b 1/6
	t -6, 2; b 1/6

#==========
# Verse 3.3
#==========

	t -7, 4, ?见
	f 7, 4, :d, ?触
end
group preserve_beat: false do
	24.times do |i|
		x, y = -4+12*4*(i/24-1/2)**2, 4*cos(3*PI*i/24)
		bg_note x, y; b 1/12
	end
end
group preserve_beat: false do
	24.times do |i|
		angle = PI+5*PI*i/24
		x, y = (5-3*i/24)*cos(angle)-2+6*i/24, (3-2*i/24)*sin(angle)+4-6*(1-(1-i/24)**2)
		bg_note x, y; b 1/12
	end
end
b 1/3
tp_chain 0, 8, 1 do
	11.times do |i|
		x, y = (-1)**i * (2+6*(i/10)**2), 4-8*i/10
		case i
		when 4 then f x, y, :ur; b 1/6
		when 8 then f x, y, :r; b 1/6
		when 10 then t x, y, ?摸
		else t x, y; b 1/6
		end
	end
end
tp_chain 0, 8, 1 do
	f -8, -4, :l; b 1/3
	f -4, -2, :dl; b 1/6
	tp_chain 8, 0, 1 do
		t 2, 0; b 1/6
	end
	f -3, 2, :dl; b 1/3
end
tp_drop 0, -8, 1 do
	t -8, 4, ?最
end
tp_chain 0, -8, 1 do
	t 8, 4; b 1/3
	t 3, 2, ?亮; b 1/6
	tp_chain -8, 0, 1 do
		t -2, 0; b 1/6
	end
	f 4, -2, :r, ?的; b 1/3
end

tp_chain 8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = 8-16*i/12, -sin(3*PI*i/12)
		i==0 ? h(x, y, 2/3, ?光) : d(x, y); b 1/12
	end
end
tp_chain 8, 0, 1 do
	f 6, 4, :l; b 1/3
	t 0, -4; b 1/3
	t -6, 4; b 1/3
end
tp_drop 0, -8, 1, preserve_beat: false do
	f -8, 0, :ur; b 1/3
	t 0, 2; b 1/3
	f 8, 4, :r; b 1/3
end
tp_drop 0, 8, 1 do
	t -8, -4, ?最; b 1/3
	t -4, -4, ?美; b 1/3
	t 0, -4, ?的; b 1/3
end
tp_chain 8, 0, 1, preserve_beat: false do
	12.times do |i|
		x, y = 8-16*i/12, sin(3*PI*i/12)
		i==0 ? h(x, y, 2/3, ?焰) : d(x, y); b 1/12
	end
	t -8, 0, ?火
end
tp_chain 8, 0, 1 do
	f 6, -4, :l; b 1/3
	t 0, 4; b 1/3
	t -6, -4; b 1/3
	f -8, 4, :ur; b 2/3
end
tp_drop 0, -8, 1 do
	t 4, 4
	t -5, 4, ?因; b 1/3
end

tp_drop 8, 8, 1 do
	23.times do |i|
		t = i/23
		x, y = -8 + 4*t + (2+4*t)*(2-i%3), (1+cos((0.1+3.8*t)*PI))/2*(6+2*t) - 4
		case i
		when 0 then f x, y, :r, ?为
		when 6 then f x, y, :ur
		when 12 then f x, y, :r, ?你
		when 18 then f x, y, :ur, ?温
		when 20 then t x, y, ?柔
		when 22 then f x, y, :l, ?地; b 1/6
		else t x, y
		end
		b 1/6
	end
end

tp_chain -8, 0, 1, preserve_beat: false do
	12.times do |i|
		angle = PI/2 - PI * i/12
		x, y = -4 + 8*i/12 + 4*cos(angle), 4*sin(angle)
		i==0 ? h(x, y, 2/3, ?经) : d(x, y); b 1/12
	end
end
tp_drop 8, 0, 1 do
	f 5, 4, :r; b 1/3
	t 1, 0; b 1/3
	t 8, 2; b 1/3
end
tp_chain 8, 0, 1, preserve_beat: false do
	12.times do |i|
		angle = -PI/2 - PI * i/12
		x, y = 4 - 8*i/12 + 4*cos(angle), 4*sin(angle)
		i==0 ? h(x, y, 2/3, ?过) : d(x, y); b 1/12
	end
end
tp_drop 8, 0, 1 do
	f -5, -4, :ul; b 1/3
	t -1, 0; b 1/3
	t -8, 3; b 1/3
end
tp_chain -8, 0, 1 do
	h -4, 4, 2/3
end
tp_chain 8, 0, 1 do
	f 4, 4, :r; b 1/3
	t 5, 0; b 1/3
	f 1, -2, :ur; b 1/3
	t -8, -3
end
tp_chain 0, 8, 1 do
	t -1, 2, ?这; b 1/3
end
tp_chain 0, -8, 1 do
	t -3, -4; b 1/6
	t -4, -2; b 1/6
	f -3, 0, :r, ?一; b 1/6
	f -5, 1, :ul; b 1/6
end

tp_drop -8, 8, 1 do
	24.times do |i|
		t = i/24
		x, y = -8 + 4*t + (1.5+4.5*t)*(2-i%3), (1+cos(4*t*PI))/2*(7+t) - 4
		case i
		when 0 then f x, y, :r, ?路
		when 6 then f x, y, :ur, ?的
		when 10 then f x, y, :r, ?冒
		when 12 then f x, y, :r, ?险
		when 18 then f x, y, :ur, ?感
		when 20 then t x, y, ?谢
		when 22 then f x, y, :r, ?你
		when 23 then f x, y, :l
		else t x, y
		end
		b 1/6
	end
end

tp_chain 0, -8, 1 do
	8.times do |i|
		x, y = 8-16*i/8, 4-8*(i/8)**2
		i==0 ? f(x, y, :l, ?和) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1 do
	t 6, 4, ?我; b 1/6
	t -1, 4; b 1/6
end
tp_chain 0, -8, 1 do
	8.times do |i|
		x, y = -8+16*i/8, -4+8*(1-i/8)**2
		i==0 ? f(x, y, :dr, ?的) : d(x, y); b 1/12
	end
end
tp_drop 0, -8, 1, preserve_beat: false do
	f -6, 4, :r; b 1/3
	f 6, 4, :l
end
tp_drop 8, 0, 1 do
	t 8, -4, ?遇; b 1/3
	t -8, -4, ?见; b 1/3
end
tp_chain 0, 8, 1 do
	t 0, 2; b 1/3
	t 0, -2; b 1/3
end
tp_drop 0, 8, 1 do
	f 5, 0, :ur
	t -5, 0, ?在; b 1/3
end
tp_chain 0, -8, 1 do
	t -2, -2, ?旅; b 1/6
	t 2, -2; b 1/6
	f -2, 2, :l, ?途; b 1/6
	f 2, 2, :r; b 1/6
end

group preserve_beat: false do
	20.times do |i|
		x, y = 8-16*9/4*(i/20-1/3)**2-4*(1-i/20), -4+8*cos((i/20)**2*3/2*PI)**2*(1-(i/20)**2)
		bg_note x, y; b 1/12
	end
end
tp_drop 0, 8, 1 do
	f 0, 4, :d, ?的; b 1/3
end
notes = group do
	3.times do |i|
		angle = -2*PI/3 - PI/3*i
		x, y = 6*cos(angle), 4*sin(angle)
		tp_chain -8*cos(angle), -8*sin(angle), 1 do
			t(x, y); b 1/6
		end
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1/2
tp_drop 0, 8, 1 do
	f 2, 1, :ur
end
tp_chain 0, 8, 1 do
	t -2, 1; b 1/6
	t 0, 0; b 1/6
	f 2, -1, :r, ?最; b 1/6
	f -2, -2, :l, ?终; b 1/6
	f 3, -3, :u, ?点
end
group preserve_beat: false do
	12.times do |i|
		x, y = 7-16*9/4*(i/12-1/3)**2, -3*cos(2*PI*i/12)
		bg_note x, y; b 1/12
	end
end
b 1/3
notes = group do
	3.times do |i|
		angle = 2*PI/3 + PI/3*i
		x, y = 6*cos(angle), 4*sin(angle)
		tp_chain -8*cos(angle), -8*sin(angle), 1 do
			t(x, y); b 1/6
		end
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1/2
tp_drop 0, 8, 1 do
	f -2, -1, :ul
end
tp_chain 0, 8, 1 do
	t 2, -1; b 1/6
	t 0, 0; b 1/6
	f -2, 1, :l, ?会; b 1/6
	f 2, 2, :r; b 1/6

	f -3, 3, :d, ?再
end
group preserve_beat: false do
	24.times do |i|
		angle = PI/2 + 6*PI*i/24
		x, y = (3+i/24)*cos(angle)-3+7*i/24, (3+i/24)*sin(angle)
		bg_note x, y; b 1/12
	end
end
b 1/3
notes = group do
	tp_chain 0, -8, 1 do
		t 2, 0
	end
	3.times do |i|
		angle = -2*PI/3 - PI/3*i
		x, y = 8*cos(angle), 4*sin(angle)
		tp_chain -8*cos(angle), -8*sin(angle), 1 do
			t x, y; b 1/6
		end
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1/2
tp_drop 0, -8, 1 do
	f 2, 0, :ur; b 1/6
	t -1, -1; b 1/6
	f 0, 3, :r; b 1/6
	f -3, 2, :l; b 1/6
	f 4, 4, :d, ?见
end
group preserve_beat: false do
	24.times do |i|
		x, y = -2+6*cos(3*PI*i/24), 4*cos(4*PI*i/24)
		bg_note x, y; b 1/12
	end
end
b 1/3
notes = group do
	tp_chain 0, -8, 1 do
		t 2, 0
	end
	3.times do |i|
		angle = -2*PI/3 - PI/3*i
		x, y = 8*cos(angle), 4*sin(angle)
		tp_chain -8*cos(angle), -8*sin(angle), 1 do
			t x, y; b 1/6
		end
	end
end
transform(duplicate notes) { horizontal_flip; beat_translate 1/2 }
b 1/2
tp_chain 0, -8, 1 do
	t 2, 0; b 1/6
	t -1, -2; b 1/6
end
tp_drop 0, 8, 1 do
	t -4, -4
	f 4, -4, :ur; b 1/3
end

group preserve_beat: false do
	24.times do |i|
		x, y = -8*cos(3*PI*i/24), 4*cos(4*PI*i/24)
		bg_note x, y; b 1/12
	end
end
tp_drop 0, -8, 1 do
	f -8, 4, :d, ?会
end
tp_chain 0, -8, 1 do
	12.times do |i|
		x = (4 + 4*4*(i/12-1/2)**2)*cos(PI/2*i) + 2*sin(2*PI*i/12)
		y = -4+8*2*(i/12-1/2).abs
		t x, y; b 1/6
	end
	group preserve_beat: false do
		24.times do |i|
			x, y = 8*cos(5*PI*i/24), 4*cos(4*PI*i/24)
			bg_note x, y; b 1/12
		end
	end
	tp_drop 0, 8, 1 do
		t -8, 4
	end
	12.times do |i|
		x = (4 + 4*4*(i/12-1/2)**2)*cos(PI/2*i) + 2*sin(2*PI*i/12)
		y = -4+8*2*(i/12-1/2).abs
		if i%2 == 0 && i != 0
			f x, y, x>0 ? :ur : :ul, i==10 ? ?再 : ""
		else
			t x, y, i==0 ? ?再 : ""
		end
		b 1/6
	end

	h 8, 4, 7/2, ?见
end
tp_drop 0, -8, 1 do
	h -8, 4, 3, ?见
end

transform @events do
	scale 12.5
end

check

end
