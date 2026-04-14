require 'yaml'

include Math
Integer.alias_method :/, :quo
include Sunniesnow::Tools

Sunniesnow::Charter.open 'special' do

title 'Algebra'
artist 'Function Phantom'
charter 'UlyssesZhan'
difficulty_name 'Special'
difficulty_color :special
difficulty '?'

offset 0.060
bpm 177

$sizes = JSON.parse <<'JSON'
{
	"00.svg": [
		78.762576,
		30.229056
	],
	"00_0.svg": [
		25.975093,
		28.854295999999998
	],
	"00_1.svg": [
		26.134496,
		28.854295999999998
	],
	"00_2.svg": [
		26.273972999999998,
		28.953923
	],
	"00_3.svg": [
		26.134496,
		28.854295999999998
	],
	"01.svg": [
		98.767633,
		30.338645
	],
	"01_0.svg": [
		50.96149,
		28.854295999999998
	],
	"01_1.svg": [
		50.96149,
		28.854295999999998
	],
	"01_2.svg": [
		50.96149,
		28.854295999999998
	],
	"01_3.svg": [
		50.96149,
		28.963885
	],
	"02.svg": [
		151.45584,
		39.92279
	],
	"02_0.svg": [
		26.194271,
		28.854295999999998
	],
	"02_1.svg": [
		25.287671,
		28.635118
	],
	"02_2.svg": [
		25.975093,
		28.635118
	],
	"02_3.svg": [
		26.134496,
		28.854295999999998
	],
	"03.svg": [
		125.344545,
		46.56114
	],
	"03_0.svg": [
		28.036414999999998,
		39.867569
	],
	"03_1.svg": [
		28.036414999999998,
		39.977158
	],
	"03_2.svg": [
		26.981335,
		40.036934
	],
	"03_3.svg": [
		34.556288,
		31.96264
	],
	"04.svg": [
		200.567727,
		46.56114
	],
	"04_0.svg": [
		40.592703,
		31.96264
	],
	"04_1.svg": [
		32.132024,
		28.744707
	],
	"04_2.svg": [
		36.260595,
		30.85372
	],
	"04_3.svg": [
		40.801586,
		31.033048
	],
	"05.svg": [
		237.606072,
		42.572767
	],
	"05_0.svg": [
		25.975093,
		28.854295999999998
	],
	"05_1.svg": [
		26.134496,
		28.854295999999998
	],
	"05_2.svg": [
		26.273972999999998,
		28.953923
	],
	"05_3.svg": [
		26.134496,
		28.854295999999998
	],
	"06.svg": [
		237.104611,
		45.329482
	],
	"06_0.svg": [
		26.194271,
		28.854295999999998
	],
	"06_1.svg": [
		30.747334000000002,
		42.318379
	],
	"06_2.svg": [
		32.505785,
		43.81967
	],
	"06_3.svg": [
		40.967943000000005,
		28.744707
	],
	"07.svg": [
		237.426686,
		43.917808
	],
	"07_0.svg": [
		29.985236999999998,
		28.146934
	],
	"07_1.svg": [
		31.496408000000002,
		30.408453
	],
	"07_2.svg": [
		49.163161,
		31.96264
	],
	"07_3.svg": [
		54.888784,
		31.96264
	],
	"08.svg": [
		237.656956,
		43.021085
	],
	"08_0.svg": [
		54.797649,
		30.85372
	],
	"08_1.svg": [
		53.283327,
		30.85372
	],
	"08_2.svg": [
		53.283327,
		31.57103
	],
	"08_3.svg": [
		54.797649,
		31.57103
	],
	"09.svg": [
		237.378017,
		43.479451999999995
	],
	"09_0.svg": [
		26.273972999999998,
		28.953923
	],
	"09_1.svg": [
		26.134496,
		28.854295999999998
	],
	"09_2.svg": [
		30.26901,
		28.635118
	],
	"09_3.svg": [
		30.647591,
		28.854295999999998
	],
	"10.svg": [
		237.527557,
		54.757161
	],
	"10_0.svg": [
		39.846469,
		31.96264
	],
	"10_1.svg": [
		39.706992,
		31.96264
	],
	"10_2.svg": [
		39.846469,
		31.96264
	],
	"10_3.svg": [
		39.846469,
		31.96264
	],
	"11.svg": [
		237.721152,
		53.651308
	],
	"11_0.svg": [
		58.197557,
		42.318379
	],
	"11_1.svg": [
		41.925341,
		43.26483
	],
	"11_2.svg": [
		50.817519000000004,
		42.427968
	],
	"11_3.svg": [
		26.981335,
		42.427968
	],
	"12.svg": [
		225.939205,
		100.99803
	],
	"12_0.svg": [
		41.135112,
		42.527594
	],
	"12_1.svg": [
		41.135112,
		42.427968
	],
	"12_2.svg": [
		41.135112,
		42.427968
	],
	"12_3.svg": [
		40.080033,
		40.086747
	],
	"13.svg": [
		162.767642,
		51.368393
	],
	"13_0.svg": [
		30.897208,
		42.318379
	],
	"13_1.svg": [
		26.981335,
		42.318379
	],
	"13_2.svg": [
		30.617703,
		28.744707
	],
	"13_3.svg": [
		34.432852,
		30.85372
	]
}
JSON
$problems = YAML.load <<'YAML', symbolize_names: true
- name: '00'
  problem: |
    \[2+3=\blank.\]
  options: ['5', '6', '7', '8']
  answer: 0

- name: '01'
  problem: |
    \[8011\times42=\blank.\]
  options: ['330862', '331662', '333262', '336462']
  answer: 3

- name: '02'
  problem: |
    \[\floor{\sqrt{\fc\exp{-2\ln\cos2\pi\i}}}=\blank.\]
  options: ['0', '1', '2', '3']
  answer: 0

- name: '03'
  problem: |
    \[\int_{-\infty}^{+\infty}\fr{\cos x}{1+x^2}\d x=\blank.\]
  options: ['\fr\pi4', '\fr\pi\e', '\fr\e2', '\sqrt2']
  answer: 1

- name: '04'
  problem: |
    \[\int_{-\infty}^{+\infty}\int_{-\infty}^{+\infty}
    \fc\cos{x^2}\fc\cos{xy}\d x\d y=\blank.\]
  options: ['\sqrt{2\pi}', '2\pi', '4\pi^2', '16\pi^4']
  answer: 1

- name: '05'
  problem: |
    The chromatic number of a graph embedded on the Klein bottle is at most $\blank$.
  options: ['5', '6', '7', '8']
  answer: 1

- name: '06'
  problem: |
    Let $m\in\bZ^+$.
    The $z^0$ coefficient in the Laurent series of
    $\sum_{n=0}^{+\infty} n^{2m}\fc\sech{nz}$ at $z=0$ is $\blank$.
  options: ['0', '\fr1m', '\fr{\pi^2}{12}', '2\pi m']
  answer: 0

- name: '07'
  problem: |
    The smallest ordinal among $\veps_0$, $\Gma_0$,
    $\fc\vphi{2,0}$, and $\fc\psi{\fc\psi1}$ is $\blank$.
  options: ['\veps_0', '\Gma_0', '\fc\vphi{2,0}', '\fc\psi{\fc\psi1}']
  answer: 3

- name: '08'
  problem: |
    The dimension of $\opc{Sp}{n,\bR}$ as a real manifold is $\blank$.
  options: ['2n^2-n', '2n^2-1', '2n^2+1', '2n^2+n']
  answer: 3

- name: '09'
  problem: |
    A donut can be divided into (at most) $\blank$ pieces
    by $3$ straight cuts.
  options: ['7', '9', '11', '13']
  answer: 3

- name: '10'
  problem: |
    Let $a,b,c\in\bR$ such that there is exactly one square
    with all its vertices on the curve $y=x^3+ax^2+bx+c$.
    The area of the square is $\blank$.
  options: ['6\sqrt2', '7\sqrt2', '8\sqrt2', '9\sqrt2']
  answer: 0

- name: '11'
  problem: |
    Randomly pick a natural number $n<N$.
    The probability that $7$ is the leading digit of $2^n$
    is $\blank$ as $N\to+\infty$.
  options: ['\fr{\e-1}{\e^7-\e^{-2}}', '\fr{10/9}{56}', '\log_{10}\fr87', '\fr19']
  answer: 2

- name: '12'
  problem: |
    \[\begin{cases}x''+x=-ax^3,\\\fc x0=1,\quad\fc{x'}0=0.\end{cases}\]
    Let $T$ be the smallest positive zero of $x$. Then,
    \[\lim_{a\to0^+}\fr{T-\pi/2}a=\blank.\]
  options: ['-\fr{7\pi}{16}', '-\fr{5\pi}{16}', '-\fr{3\pi}{16}', '-\fr{\pi}{16}']
  answer: 2

- name: '13'
  problem: |
    \[\lim_{x\to1^-}\prod_{n=0}^{+\infty}\p{\fr{1+x^{n+1}}{1+x^n}}^{x^n}=\blank.\]
  options: ['\fr2{\e^2}', '\fr2\e', '2\e', '2\e^2']
  answer: 1
YAML
def math_image filename, x, y, duration_beats
	width, height = $sizes[filename]
	td image filename, x, y, duration_beats, width, height, mirrorable: false, above: :circles do
		opacity 0; b 1/2
		opacity 1; b duration_beats - 1
		opacity 1; b 1/2
		opacity 0
	end
end
def math_problem name, options_start = 0, answer_start = 8, delta_beats
	answer_duration = delta_beats.first.sum
	math_image "#{name}.svg", 0, 0, options_start + answer_start
	correct_answer = $problems.find { _1[:name] == name }[:answer]
	b options_start
	[correct_answer, *([0, 1, 2, 3] - [correct_answer])].each do |i|
		x = [-6, 6, 6, -6][i]
		y = [4, 4, -4, -4][i]
		math_image "#{name}_#{i}.svg", x, y, answer_start + answer_duration
		tp_drop 8*(x<=>0), 8*(y<=>0), 1, preserve_beat: false do
			b answer_start
			delta_beats[i].each do |delta|
				correct_answer == i ? t(0, 0) : d(0, 0)
				b delta
			end
		end
	end
	b -options_start
end

b 2
diamond_grid 2
b 2

def snare x0, y0
	4.times do |i|
		bg_note x0+cos(PI/2*i)/2, y0+sin(PI/2*i)/2
	end
end

def intro_pattern1; group do
tp_chain 0, 8, 1 do
	11.times do |i|
		t -5+i, 2-i/2+3/2*(-1)**i; b 3/4
	end
	b -1/4
end
end; end

def intro_pattern; group do
intro_pattern1

5.times do |i|
	tp_chain 0, 8, 1 do
		3.times do |j|
			t (-2-j*2-i/2)*(-1)**i, 2-i+j/2; b 1/2
		end
	end
end
b 1/2
end; end

tp_chain 8, 0, 1 do
	t 4, 4
end
intro_pattern

transform(intro_pattern) { horizontal_flip }
b -2
diamond_grid 2
b 2

def surrounding_pattern; group preserve_beat: false do
64.times do |i|
	bg_note -8*sin(PI*i/16), -4*sin(PI*i/8); b 1/4
end
end; end

surrounding_pattern
intro_pattern

transform(group(preserve_beat: false) { intro_pattern1 }) do
	horizontal_flip
end
tp_chain 0, -8, 1 do
	h -6, -3, 1/2; b 1
	t -5, 1; snare -5, 1; b 1/2
	h -4, -1, 1; b 3/2
	t -3, 2; snare -3, 2; b 1
end

tp_chain 0, -8, 1 do
	b 1/2
	t 5, -2; b 1/2
	t 6, 0; snare 6, 0; b 1/2
	h 7, -2, 1/2; b 1
	t 8, 1; b 1/2
	t 7, 3; snare 7, 3; b 1
end

tp_chain 0, -8, 1 do
	h -7, -3, 1/2; b 1
	t 5, 1; snare 5, 1; b 1/2
	h -3, 0, 1; b 3/2
	t 6, 3; snare 6, 3; b 1
end

3.times do |i|
	angle = PI/3 - i*PI/3
	r = 4/cos(PI/6)
	x, y = r*cos(angle), r*sin(angle)
	tp_drop(8, 0, 1) { t x, y }
	tp_drop(-8, 0, 1) { t -x, -y }
	hexagon 1/4
	b 1
end
tp_chain 0, 8, 1 do
	t -1, 1; b 1/4
	t 1, 0; b 1/4
	t -1, -1; b 1/2
end

def pattern1_verse1_part1; group do
grid 1/2
tp_chain 8, 0, 1 do
	path 'm 7,-2 c -1,3 -4,6 -5,6 C 1,4 1,-0 1,-0', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	path 'm -7,-3 c 0,0 1,7 7,6', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 0, 8, 1 do
	b -2
	t -7, -1; snare -7, -1; b 1
	t -2, 1; b 1/2
	t 1, 2; b 1/2
	f 4, 3, :r; snare 4, 3; b 1/2
end
tp_chain 0, 8, 1 do
	t -4, 3; b 1/2

	t -5, -1; b 1/2
	t -7, 2; b 1/8
end
3.times { d -7, 2; b 1/8 }
tp_chain 0, 8, 1 do
	t 6, 1; snare 6, 1; b 1/2
	t 5, -3; b 1/2
end
tp_chain 8, 0, 1 do
	path 'm 5,3 c -4,-2 -2,-4 -1,-4', 4 do |x, y, i|
		d x, -y; b 1/8
	end
end
tp_chain 0, 8, 1 do
	t -2, 2; b 1/8
	tp_none { 3.times { d -2, 2; b 1/8 } }
	t 4, 3; snare 4, 3; b 1
end
end; end

def pattern1_verse1_part2; group do
tp_chain -8, 0, 1 do
	path 'm 7,-2 c -1,3 -4,6 -5,6 C 1,4 1,-0 1,-0', 12 do |x, y, i|
		i.zero? ? t(-x, -y) : d(-x, -y); b 1/8
	end
end
tp_chain 0, 8, 1 do
	b -1/2
	t 7, -1; snare 7, -1; b 1/2
end
tp_chain 8, 0, 1 do
	path 'M 7,-3 C 6,3 -1,3 -7,3', 20 do |x, y, i|
		case i
		when 0
			t x, -y
		when 8
			t 0, 0
		when 10
			t 2, -1.5
		when 9, 11
		when 12
			t x, -y; snare x, -y
		else
			d x, -y
		end
		b 1/8
	end
end
end; end

def pattern1_end1 no_last_snare = false; group do
tp_chain 8, 0, 1 do
	path 'M 1,-3 C -1,-1 -5,2 8,-2', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
	t -6, 3; snare -6, 3; b 1/4
	t -3, 3/2; b 1/4
	t -7, 0; b 1/4
	t -4, -3/2; b 1/4
end
tp_chain -8, 0, 1 do
	t -8, -3; b 1/4
	t -2, -2; b 1/4
	t -5, 0; b 1/4
	t 1, 1; b 1/4
	t -2, 3; snare -2, 3 unless no_last_snare; b 1/4
	t -5/2, 3/2; snare -5/2, 3/2 unless no_last_snare; b 1/4
	t 3, -1/2; b 1/4
	t 5/2, -2; b 1/4
end
end; end

def pattern1_verse2_part1; group do
grid 1/2
tp_chain 8, 0, 1 do
	path 'm 7,-2 c -1,3 -4,6 -5,6 C 1,4 1,-0 1,-0', 12 do |x, y, i|
		i.zero? ? t(-x, -y) : d(-x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	path 'M 7,-3 C 4,4 2,5 -0,1 -2,-3 -7,-3 -8,-0', 0..12 do |x, y, i|
		case i
		when 0
			t x, -y; b 1/8
		when 1..6
			d x, -y; b 1/8
		when 7
			d x, -y; b 1/2
		when 12
			t x, -y; b 1/2
		when 9..11
			d x, -y; b -1/8
		when 8
		end
	end
end
tp_chain 0, 8, 1 do
	b -2
	t 7, -1; snare 7, -1; b 1
	t -5, 0; b 1
	f 2, 3, :r; snare 2, 3; b 1/2
end
tp_chain 0, 8, 1 do
	t -1, -3; b 1/2
end

tp_chain -8, 0, 1 do
	path 'M -4,4 C -8,-0 -4,-4 -1,-4', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	snare 3, 3
	path 'M 3,-3 C 7,-2 5,2 1,3', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 0, 8, 1 do
	t 1, -1; b 1/8
	tp_none { 3.times { d 1, -1; b 1/8 } }
	b 1/2
	t -5, -2; b 1/8
	tp_none { 3.times { d -5, -2; b 1/8 } }
	t 2, 3; snare 2, 3; b 1
end
end; end

def pattern1_verse2_part2; group do
tp_chain 8, 0, 1 do
	path 'm 3,-1 c -1,3 -4,3 -4,3', 4 do |x, y, i|
		i.zero? ? t(x, -y-1) : d(x, -y-1); b 1/8
	end
end
tp_chain 0, 8, 1 do
	t -6, -2; b 1/4
	t -2, -1; b 1/4
	t -5, 0; snare -5, 0; b 1/2
end
tp_chain -8, 0, 1 do
	path 'M -3,-3 C -2,-0 1,-0 1,-0', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 0, 8, 1 do
	t 5, 2; b 1/4
	t 2, 1; b 1/4
	t 6, 0; b 1/4
	t 3, -1; b 1/4
	t 7, -2; snare 7, -2; b 1
end
end; end

def pattern1_end2; group do
notes = tp_chain 0, 8, 1 do
	tp_chain(8, 0, 1) { t 5, 3 }
	t -7, -3; b 1/2
	t -5, -1; b 1/4
	t 1, 0; b 1/4
	t -3, 1; b 1/2
end
transform duplicate notes do
	horizontal_flip
	beat_translate 3/2
end
b 3/2
tp_chain 0, 8, 1 do
	tp_chain(8, 0, 1) { t 6, 4 }
	t -7, -3; b 1/4
	t -6, -2; b 1/4
	t 7, 1; b 1/2
end
end; end

group preserve_beat: false do
	b 12

	grid 1/4; b 2
	grid 1/4; b 2

	b 12

	grid 1/4; b 3/2
	grid 1/4; b 3/2
	grid 1/4; b 1

	b 28

	grid 1/4; b 3/2
	grid 1/4; b 3/2
	grid 1/4; b 1

	grid 1/2
end

group do
	pattern1_verse1_part1
	pattern1_verse1_part2
	pattern1_end1
	pattern1_verse2_part1
	pattern1_verse2_part2
end
pattern1_end2

math_problem '00', 16, 12, [
	[1/2, 1/4, 1/4, 1/2, 1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4],
	[3/4, 3/4, 1/2, 1/4, 3/4, 1/4, 1/4, 1/4, 1/4],
	[1/2, 1/4, 3/4, 1/2, 1/4, 3/4, 1/4, 1/4, 1/4, 1/4],
	[1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4]
]

notes = group do
	pattern1_verse1_part1
	pattern1_verse1_part2
	pattern1_end1 true
	pattern1_verse2_part1
	pattern1_verse2_part2
end
transform notes do
	horizontal_flip
end
b 4

def rest_bg_notes
group preserve_beat: false do
	2.times do |j|
		b 1/2
		%w[I've been wa   tching you  for  a    long time].zip(
			[1/2, 1/2, 1/2, 1/2,   1/2, 1/2, 1/2, 5/4, 11/4]
		).each_with_index do |(text, delta), i|
			bg_note -8+2*i, 3*j, text; b delta
		end

		b 7/4
		%w[You  can  not  last and  drift a    way].zip(
			[1/2, 1/2, 1/2, 1/2, 1/4, 1,    1/2, 5/2]
		).each_with_index do |(text, delta), i|
			bg_note -7+2*i, -3*j, text; b delta
		end

		b 2
		%w[Won't re mem ber  me   the  next day].zip(
			[1,    1, 1,  1/2, 3/2, 1/2, 2, 5/2]
		).each_with_index do |(text, delta), i|
			bg_note -7+2*i, 3*j, text; b delta
		end

		b 4
	end
end
end
rest_bg_notes

def rest_pattern_part s = 1
notes = group do
	tp_drop 8, 0, 1, preserve_beat: false do
		t 5, 2; b 3/2
		t 6, -2; b 5/2

		t 3, 4; b 3/4
		t 2, 1; b 3/4
		t 3, -2; b 1
		t 6, -4; b 3/2
	end

	tp_drop -8, 0, 1 do
		b 1
		f -5, 2, :l; b 2
		f -4, -2, :l; b 1

		b 1
		f -8, 2, :l; b 2
		f -7, -2, :l; b 1
	end
end
transform(notes) { scale s }
end

tp_chain 0, 8, 1 do
	t 2, 4
end
transform(rest_pattern_part) { horizontal_flip }

rest_pattern_part

transform(rest_pattern_part) { horizontal_flip }

rest_pattern_part

surrounding_pattern
transform(rest_pattern_part 0.9) { horizontal_flip }

rest_pattern_part 0.7

transform(rest_pattern_part 0.5) { horizontal_flip }

remove *(rest_pattern_part 0.3).filter { _1.beat >= b - 4 }

def pre_problem_pattern; group do
(-8..8).step 2 do |x|
	(-4..4).step 2 do |y|
		next if (x+y)%4 != 0
		delta = (x**2+y**2) / 32
		b delta
		bg_note x, y; b -delta
	end
end
end; end
b -4; pre_problem_pattern; b 4

def usual_pattern; group do
tp_chain 8, 0, 1, preserve_beat: false do
	path 'M 8,-4 C 6,4 -0,4 -4,4', 16 do |x, y, i|
		i.zero? ? h(x, -y, 3/2) : d(x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	path 'm 3,-3 c -1,3 -5,4 -5,4', 8 do |x, y, i|
		i.zero? ? h(x, -y, 1/2) : d(x, -y); b 1/8
	end
end
b 1/2
tp_chain -8, 0, 1 do
	t -5, 0; b 1/2
	f -6, 3, :l; snare -6, 3; b 1/2
end
tp_chain 8, 0, 1 do
	path 'M 1,-1 C 1,-4 5,-4 5,-4', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	path 'M -1,-0 C -1,-3 -5,-3 -5,-3', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	path 'm 2,1 c 0,-3 4,-3 4,-3', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end

tp_chain -8, 0, 1 do
	path 'M -7,-3 C -4,1 -0,-0 -0,-0', 6 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	path 'm 6,-3 c -3,4 -8,1 -8,1', 6 do |x, y, i|
		i.zero? ? t(x+2, -y) : d(x+2, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	path 'm -3,1 c 3,2 5,0 5,0', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	snare 7, -3
	path 'M 7,3 C 4,-3 1,-5 -2,-3 c -3,2 -1,5 1,6 2,1 9,-2 9,-3', 16 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
b -5/4
tp_chain 0, 8, 1 do
	t -8, -1; b 1/4
end
tp_chain -8, 0, 1 do
	path 'M -7,3 C -3,-4 6,-1 6,-1', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end

b 8
end; end

math_problem '01', [[
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1, 1/2, 1/2
]]
usual_pattern

math_problem '02', [[
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
]]
transform(usual_pattern) { horizontal_flip }

math_problem '03', [[
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1, 1/2, 1/2
], [
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
]]
usual_pattern

math_problem '04', [[
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/2, 1/4, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/2, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
]]
transform(usual_pattern) { horizontal_flip }

b -4
2.times { grid 1/4; b 2 }

def pattern2; group do
tp_chain 8, 0, 1, preserve_beat: false do
	path 'M 3,-3 C 1,-4 -2,-2 -2,-1 c 0,1 2,5 10,5', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 0, 8, 1 do
	t -6, 2; b 3/4
	t -8, -1; b 1/4
	t -7, -2; snare -7, -2; b 1/2
	t -3, -3; b 1
	t -1, 1; b 1/2
	t 5, 3; snare 5, 3; b 1/2
	t 7, 1; b 1/2
	mark :m
end
b -1
tp_chain -8, 0, 1 do
	path 'M -2,-4 C -5,-4 -8,-3 -4,1', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end

at :m, preserve_beat: true do
	t 3, -1; b 1/4
	t 2, -3; b 1/4
end
tp_chain 8, 0, 1 do
	path 'm 4,4 c 3,-1 3,-3 3,-3', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	snare 1, 1
	path 'M 1,-1 C -0.4,3.2 -5.1,4 -8,4', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
b -1/2
tp_chain 8, 0, 1 do
	path 'M -0,-4 C -4,-1 -0.9,4 3,3 7,2 8,-2 8,-2', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
b -1/2
tp_chain 0, 8, 1 do
	t -6, -1; b 1/2
	f -7, 2, :l; snare -7, 2; b 1
end

tp_chain 0, 8, 1, preserve_beat: false do
	t -3, 4; b 3/4
	t 3, 1; b 1/4
	tp_chain 0, 8, 1 do
		t 4, -1/2; snare 4, -1/2; b 1/2
	end
	t -2, -3; b 1
	t 8, 0; b 1/2
end
tp_chain 0, 8, 1 do
	t 8, -3; b 3/4
	t -5, 0; b 3/4
	t 6, 4; b 1
	t 0, 1; b 1/2
end
tp_chain -8, 0, 1 do
	snare -2, -1
	path 'M -2,1 C -4,-1 -4,-3 -4,-3', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	path 'm 3,-2 c 1,3 0,5 0,5', 4 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
end; end

def pattern2_end1; group do
tp_chain 0, 8, 1 do
	t -1, -4; b 1/2
	t 1, -1
	tp_chain -8, 0, 1 do
		path 'M -1,4 C -2,2 -5,2 -5,2', 4 do |x, y, i|
			d x, -y; b 1/8
		end
	end
	t 6, 0; snare 6, 0; b 1/2
	t 4, 4
end
tp_chain 0, 8, 1 do
	t -7, 0; b 1/2
	t -1, 1; b 1/4
	t 0, -1/2; b 1/4
	b 1; t 2, 3; snare 2, 3; b -1
end
tp_chain -8, 0, 1 do
	f -7, 3, :l; snare -7, 3
end
tp_chain 8, 0, 1 do
	f 1, -2, :r; snare 1, -2; b 3/2
end
end; end

def pattern2_full; group do
grid 1/2
pattern2

pattern2_end1

transform pattern2 do
	horizontal_flip
end

grid 1/4
tp_chain 8, 0, 1 do
	path 'M 6,1 C 2,-3 -4,-3 -4,-3', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
	b -1/2
end
tp_chain 0, 8, 1 do
	t 0, 0; snare 0, 0; b 3/4
	t 5, 3; snare 5, 3; b 1/4
	t 6, 3/2; b 1/2
	t -4, -2; snare -4, -2; b 1/2
	t -8, 0
end
tp_chain 0, 8, 1 do
	t 5, -4; b 1/2
	t 2, -2; snare 2, -2; b 1/2
	t 0, 1; snare 0, 1; b 1/4
	t -3/2, 2; snare -3/2, 2; b 1/4
end

grid 1/2
transform pattern2 do
	horizontal_flip
end

transform pattern2_end1 do
	horizontal_flip
end

pattern2

tp_chain 8, 0, 1 do
	path 'M 6,1 C 2,-3 -4,-3 -4,-3', 8 do |x, y, i|
		i.zero? ? t(-x, -y) : d(-x, -y); b 1/8
	end
	b -1/2
end
tp_chain 0, 8, 1 do
	t 0, 0; snare 0, 0; b 3/4
	t -5, 3; snare -5, 3; b 1/4
	t -6, 3/2; b 1/2
	t 4, -2; snare 4, -2; b 1/4
	t 11/2, -1; snare 11/2, -1; b 1/4
	t -2, -1; snare -2, -1; b 1/4
	t -7/2, 0; snare -7/2, 0; b 1/4
	t 0, 1; snare 0, 1; b 1/4
	t 3/2, 2; snare 3/2, 2; b 1/4
	t -5, -3; snare -5, -3; b 1/4
	t -13/2, -2; snare -13/2, -2; b 1/4
end
end; end

pattern2_full

rest_bg_notes
rest_pattern_part

transform(rest_pattern_part 0.9) { horizontal_flip }

rest_pattern_part 0.8

transform(rest_pattern_part 0.7) { horizontal_flip }

surrounding_pattern
rest_pattern_part 0.6

transform(rest_pattern_part 0.5) { horizontal_flip }

rest_pattern_part 0.4

notes = transform(rest_pattern_part 0.3) { horizontal_flip }
remove *notes.filter { _1.beat >= b - 4 }
b -2
diamond_grid 2
b 2

[8, 8, 4, 4, 8, 8, 8, 4, 12].each_with_index do |delta, i|
	tp_chain 8*(-1)**i, 0, 1 do
		h (2+i/2)*(-1)**i, i/2*(-1)**(i%4/2+1).floor, delta; b delta
	end
end
b -4
diamond_grid 4
pre_problem_pattern; b 4

math_problem '05', [[
	1, 1/2, 1/2, 1/2, 3/2,
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2
], [
	1, 1, 1/2, 1/2, 1/2, 1/2,
	1, 1/2, 1/2, 3/4, 5/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	3/4, 3/4, 1/2, 3/4, 3/4, 1/2
], [
	1/2, 2, 1/2, 1/2, 1/2,
	3/4, 3/4, 1/2, 3/4, 5/4
]]

tp_chain 0, 8, 1 do
	t 0, -2
end
8.times do |i|
	bg_note -8*(-1)**i, 0
	bg_note -7*(-1)**i, 1
	bg_note -7*(-1)**i, -1
	b 2
end

math_problem '06', [[
	1, 1/2, 1/2, 1/2, 3/2,
	1/2, 2, 1/4, 1/4, 1/2, 1/2
], [
	1, 1, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1, 1/4, 1/4, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	3/4, 5/4, 1/2, 1/4, 1/4, 1/2, 1/2
], [
	1/2, 2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2
]]

grid 1/4
tp_chain 0, 8, 1 do
	t 0, -2
end
4.times do |i|
	tp_chain 8*(-1)**i, 0, 1 do
		b 1/2
		3.times do |j|
			t [4,6,8][j]*(-1)**i, [3,2,3][j]*(-1)**(i%4/2+1).floor; b 1/2
		end
	end
end

b 8

math_problem '07', [[
	1, 1/2, 1/2, 1/2, 3/2,
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2
], [
	1, 1, 1/2, 1/2, 1/2, 1/2,
	1, 1/2, 1/2, 3/4, 5/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	3/4, 3/4, 1/2, 3/4, 3/4, 1/2
], [
	1/2, 2, 1/2, 1/2, 1/2,
	3/4, 3/4, 1/2, 3/4, 5/4
]]

grid 1/4
notes = tp_chain 0, 8, 1 do
	8.times do |i|
		t 2+(i/2).floor, 2*(-1)**i; b 1
	end
end
transform duplicate notes do
	horizontal_flip
end

grid 1/4; b 8

math_problem '08', [[
	*([1/4]*16),
	1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4
], [
	*([1/4]*16),
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	*([1/4]*16),
	1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	*([1/4]*16),
	1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4
]]

4.times do |i|
	grid 1/4
	tp_chain 0, 8*(-1)**i, 1 do
		t 2+2*(i/2).floor, 2*(-1)**i; b 1/2
		t 6+2*(i/2).floor, 2*(-1)**i; b 1/2
		t -2-2*(i/2).floor, -2*(-1)**i; b 1/2
		t -6-2*(i/2).floor, -2*(-1)**i; b 1/2
	end
end

5.times { grid 1/4; b 1 }
b 3

grid 1/2
transform(pattern2_full) { horizontal_flip }

group preserve_beat: false do
	notes = group do
		b 3
		tp_chain -8, 8, 1 do
			t 0, -3; b 1
		end

		b 3
		tp_chain -8, -8, 1 do
			t 4, 4; b 1/2
			t -6, 2; b 1/2
		end

		b 3
		tp_chain 8, 8, 1 do
			t -3, 1; b 1/2
			t -7, 3; b 1/2
		end

		b 3
		tp_chain 8, -8, 1 do
			t -3, 3; b 1
		end
	end

	b 3
	tp_chain -8, 8, 1 do
		t 2, 1; b 1/2
		t -6, 2; b 1/2
	end

	b 3
	tp_chain -8, -8, 1 do
		t 1, 0; b 1/2
		t 4, 3; b 1/2
		t 8, 4
	end

	b 3
	tp_chain 8, 8, 1 do
		t -2, -2; b 1/2
		t 2, -4; b 1/2
	end

	b 4
	tp_chain -8, 8, 1 do
		t 1, 3
	end

	transform(duplicate notes) do
		horizontal_flip
		beat_translate 32
	end
end

notes = group do
	pattern1_verse1_part1
	pattern1_verse1_part2
	pattern1_end1
	pattern1_verse2_part1
	pattern1_verse2_part2
	pattern1_end2
end
transform(notes) { horizontal_flip }

pattern1_verse1_part1
pattern1_verse1_part2
pattern1_end1

grid 1/4
tp_chain 0, 8, 1, preserve_beat: false do
	b 1/2
	t 0, 4; b 1/2
	t 4, 1; snare 4, 1; b 1
	t 1, -2; b 1/2
	t -4, 0; b 1/2
	t -8, 2; b 1/2
	t -3, 4; b 1/2
end
tp_chain -8, 0, 1 do
	path 'M -7,-2 C -5,3 5,4 5,4', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 8, 0, 1 do
	path 'M 8,-2 C 4,-5 -0,-2 -2,3', 12 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain 0, 8, 1, preserve_beat: false do
	t -2, -3; snare -2, -3; b 1/2
	t 3, -4; b 1/2
	t 8, -2; b 1/2
	t 6, 3; b 1
	t -6, 3; b 1/2
	t -8, -2; b 1/2
	t -3, -4; b 1/2
	t 2, -3; snare 2, -3; b 1/2
	t 8, -2; b 1/2
end
b 1
tp_chain 8, 0, 1 do
	path 'M 1,-1 C -2,-2 -3,-0.2 -4,1 -5,2 -7,-0 -8,-0', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
tp_chain -8, 0, 1 do
	snare -1, 2
	path 'M -1,-2 C 2,3 5,1 6,-0 7,-1 8,-1 8,-1', 8 do |x, y, i|
		i.zero? ? t(x, -y) : d(x, -y); b 1/8
	end
end
b 1/2
tp_chain 0, 8, 1 do
	t 4, 3; b 1/2
	t -2, 4; b 1/2
	t -5, 0; b 1/2

	path 'M 8,-2 C 2,-5 2,-2 -1,-1 -4,0 -6,-4 -8,-4', 8 do |x, y, i|
		t x, -y; snare x, -y if i%4 == 2; b 1/2
	end
	b -4
	path 'm -8,-2 c 0,5 2,7 7,4 4,-3 6,4 8,-3', 16 do |x, y, i|
		t x, -y if i.odd?; b 1/4
	end
end

diamond_grid 4
notes = tp_chain 8, 0, 1 do
	t 3, 4; b 1/4
	t 0, 3; b 1/4
	t 3, 2; b 1/2
end
tp_drop 0, 8, 1 do
	t -6, -2
	t 8, 3; b 1/2
end
transform(duplicate notes) do
	rotate PI
	beat_translate 3/2
end
b 1
tp_drop 0, 8, 1 do
	t 6, -3
	t -8, 2; b 1/2
end
tp_chain 0, -8, 1 do
	t 2, 1; b 1/4
	t -2, 0; b 1/4
	t 2, -1; b 1/2
end

math_problem '09', [[
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
]]
transform(usual_pattern) { horizontal_flip }

math_problem '10', [[
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
]]
usual_pattern

math_problem '11', [[
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1, 1/2, 1/2
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2
]]
transform(usual_pattern) { horizontal_flip }

math_problem '12', [[
	1, 1/2, 1/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/2, 1/4, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/4, 1/4, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
], [
	1, 3/4, 1/4, 1/2, 1/2, 1/2, 1/2,
	1/2, 1/4, 1/4, 1/4, 1/2, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4
]]
usual_pattern

b -4
2.times { grid 1/4; b 2 }

math_problem '13', 32, 24, [[
	1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2,
	1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2,
], [
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2,
	1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4,
], [
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/2,
	1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2,
], [
	1/4, 1/4, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4, 1/2, 1/4, 1/4, 1/2,
	1/4, 1/4, 1/2, 1/4, 1/4, 1/2, 1/2, 1/4, 1/4, 1/4, 1/4, 1/4, 1/4,
]]

tp_chain 8, 0, 1 do
	t -4, 4
end
transform(intro_pattern) { horizontal_flip }

intro_pattern

surrounding_pattern
transform(intro_pattern) { horizontal_flip }

intro_pattern1

b 6
diamond_grid 2
b 2

transform @events do
	scale 12.5
end

check

end
