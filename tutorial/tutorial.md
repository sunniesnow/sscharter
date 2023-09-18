# Tutorial for sscharter

## Introduction

Sscharter is a Ruby DSL serving as a charting tool for
[Sunniesnow](https://sunniesnow.github.io).
Different from other charting tools, sscharter does not have a GUI.

By using a programming language, charters can write charts more creatively.
If the chart has many patterns, it can be much more efficient than using a GUI charting tool.
However, programming languages can be difficult to learn.

## Prerequisites

Here are some prerequisites for using sscharter.
Check all of them before continuing this tutorial:

- You need to have a basic knowledge of how to use a command line interface (CLI).
If you do not, you may find [this introduction](https://tutorial.djangogirls.org/en/intro_to_command_line/) helpful.
- You need to [install Ruby](https://www.ruby-lang.org/en/documentation/installation/).
- You need to has a basic understanding of how to program.
If you have programmed before, you will be fine because Ruby is a easy-to-begin language.
If you have not, [this](https://pine.fm/LearnToProgram/)
is a good place to start.
- You need a basic audio editing software and a basic text editing software.
If you do not have any, you can use
[Audacity](https://www.audacityteam.org/) and
[Visual Studio Code](https://code.visualstudio.com/).
- You need to be familiar with the game Sunniesnow
(which I assume you do because otherwise you would not be reading this now).
Better, you should be familiar with how a level file of Sunniesnow is structured
by reading [the documentation](https://sunniesnow.github.io/doc/).

## Install sscharter

Assume you have installed Ruby.
Then, run

```shell
gem install sscharter
```

You are now good to go!

## Step 0: decide the music

You need to decide the music you want to chart for!
Because you are assumed to be familiar with rhythm games,
I do not need to tell you what kinds of music are suitable for rhythm games.
However, I need to remind you that before you start charting, either

- you make sure the artist announced publicly that anyone can chart for the music
or permitted some sorts of usage that covers charting, or
- you got contact with the artist,
explained to them that you want to chart for the music and how you would distribute your chart,
and got their permission.

If you did not do any of the above, you need to keep in mind that you are a bad boy
and may face some sort of consequences
(I do not know. I am not a lawyer).

For this tutorial, I will use
[*Big-D* by Shaolin Dub](https://freemusicarchive.org/music/Shaolin_Dub/joint-force/big-d/).
It is licensed under [CC-BY-NC-ND-4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/).
You can download it from the link or use the following command
(if you have installed [cURL](https://curl.se/)).
By downloading it, you accept its license.

```shell
curl https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/MQ8JO0BqKl2UADzKg74rwoY7mapqBT4uWpQYciTJ.mp3 -o 'Shaolin Dub - Big-D.mp3'
```

## Step 1: create a project

If you have already [installed sscharter](#install-sscharter)
and downloaded the audio file for your music using the command above,
you can now create a project for your chart by running the following command:

```shell
sscharter init big-d 'Shaolin Dub - Big-D.mp3'
```

The parameter `big-d` is the path to the project directory,
and its basename will be set as the name of the project
(but you are free to change it later).
The parameter `Shaolin Dub - Big-D.mp3` is the path to the audio file.
You can continue to add more parameters to the command
to include more files that you want t o include in the final level file.
See [the documentation](https://sunniesnow.github.io/doc/)
for what you may want to include.
If you forget to include some of the files that you want to include
at this step, you can add them later whenever you want.

After running the command, the audio file will be copied into the project directory,
and it is no longer needed for the rest of the tutorial.
You may delete it if you want.

Open the directory `big-d`, and you will see this directory structure:

```plain
big-d
├── files
│   └── Shaolin Dub - Big-D.mp3
├── Gemfile
├── .gitignore
├── Rakefile
├── README.md
├── src
│   └── master.rb
└── .sscharter.yml
```

Here are some explanation for each of them.

- `Gemfile` specifies the gem dependencies of this project.
By default your project depends on sscharter, bundler, and rake.
You can add more dependencies if you want.
For more information about it,
see [the official documentation](https://bundler.io/man/gemfile.5.html).
- `.gitignore` specifies the files that should not be tracked by Git.
If you do not use Git as the version manager for your project, it does nothing.
- `Rakefile` contains some tasks that can be run by [Rake](https://ruby.github.io/rake/).
- `README.md` is the README file of your project.
- `.sscharter.yml` is the sscharter configuration for your project.
- `files` is the directory whose files will be included in the final level file.
You can change the directory in `.sscharter.yml`.
- `src` is the directory that contains the source codes of your project.
You can change the directory in `.sscharter.yml`.

Open `.sscharter.yml` using your text editor.
Here are the contents that you should see:

```yaml
---
project_name: big-d
build_dir: build
files_dir: files
sources_dir: src
include:
  - README.md
```

Here are some explanation for each of them.

- `project_name` is the name of your project.
It will be the filename without extension of the generated level file.
- `build_dir` is the directory that will contain the generated level file.
- `files_dir` is the directory whose files will be included in the final level file.
- `sources_dir` is the directory that contains the source codes of your project.
- `include` is the list of files outside `files_dir` that will be included in the final level file.
You can use wildcard characters in the filenames.

You can also use your text editor to open the file `src/master.rb` for what a source codes file look like:

```ruby
# frozen_string_literal: true

Sunniesnow::Charter.open 'master' do

title 'The title of the music'
artist 'The artist of the music'
charter 'Your name'
difficulty_name 'Master'
difficulty_color '#8c68f3'
difficulty '12'

offset 0
bpm 120

tp_chain 0, 0, 1 do
  t -50, 0, 'hello'
  b 1 # proceed by 1 beat
  t 50, 0, 'world'
end

end
```

You will learn what these codes mean soon later!

## Step 2: set up workflow

Now, in the project directory, run

```shell
bundle install
```

It should be done quickly if your network is good.
Change the gem source in `Gemfile` if you have trouble retrieving from the default source.

After that, run

```shell
rake
```

Then, you should see a file `build/big-d.ssc` generated.
This file is a level file of Sunniesnow.
You can upload it on the webpage of Sunniesnow to play it.

However, it is kind of inconvenient if you have to run `rake`
and reupload the level file every time you make a change to the source codes.
You can use the following command to make it more convenient:

```shell
rake serve
```

This command will open the Sunniesnow webpage in your browser for you.
The `online` field of Sunniesnow is already filled with the address to the generated level file.
Every time you save changes to the source codes,
the program will automatically rebuild the level file.
You just need to hit "load" again to reload the level file.

The port of the local server is 8011 by default.
If you need to change the port to 1314 for example, you need to run

```shell
bundle exec sscharter serve 1314
```

## What does each line in `src/master.rb` mean?

Now, you are ready to write the chart!
Open `src/master.rb` using your text editor.
Here I explain what does each line mean.

```ruby
Sunniesnow::Charter.open 'master' do
  # ...
end
```

This means that you are opening a chart called "master".
This will lead to a chart file called `master.json` in the generated level file.
You can open multiple charts in a single source codes file,
and you can also open the same chart in multiple source codes files
(but in that case the loading order matters).

The contents inside the `do`...`end` block are the contents of the chart.
You can write anything you like there.

```ruby
title 'The title of the music'
artist 'The artist of the music'
charter 'Your name'
difficulty_name 'Master'
difficulty_color '#8c68f3'
difficulty '12'
```

These lines are the metadata of the chart.
They already explains pretty much themselves.
Just fill them in!

By the way, there is a trick about the `difficulty_color` for your convenience.
If you want default difficulty colors from Lyrica, you can use one of these:

```ruby
difficulty_color :easy
difficulty_color :normal
difficulty_color :hard
difficulty_color :master
difficulty_color :special
```

Then, here comes the offset and BPM part:

```ruby
offset 0
bpm 120
```

This means:

- The zeroth beat of the music starts at time equaling to 0 seconds.
- The BPM of the music starting at the zeroth beat is 120.

You can change the BPM later at any beat by using `bpm`.
You can also use `offset` multiple times, but every time you run `offset`,
the beat is reset to zero, and you have to set the BPM over again.

Now here comes the main part:

```ruby
tp_chain 0, 0, 1 do
  t -50, 0, 'hello'
  b 1 # proceed by 1 beat
  t 50, 0, 'world'
end
```

This means:

- Start a tip point chain.
The tip point spawns at:
  - coordinates $(0,0)$ relative to the first tip-pointable event in the chain, and
  - time 1 second before the first tip-pointable event in the chain.
- Add a tap note at coordinates $(-50,0)$ to the tip point chain.
The tap note has text "hello" on it.
- Proceed by 1 beat.
Now the current beat is 1 instead of 0.
- Add a tap note at coordinates $(50,0)$ to the tip point chain.
The tap note has text "world" on it.
- End the tip point chain.

They are actually very straightforward!

Now, you are ready to write your own chart.

## Step 3: write the chart metadata

Delete all contents inside the outmost `do`...`end` block.
Then, write the metadata of the chart:

```ruby
title 'Big-D'
artist 'Shaolin Dub'
charter 'UlyssesZhan' # replace this with your name
difficulty_name 'Master'
difficulty_color :master
difficulty '10'
```

You are then writing the chart for the master difficulty,
with difficulty being 10.

Now, the whole source codes file should look like this:

```ruby
# frozen_string_literal: true

Sunniesnow::Charter.open 'master' do

title 'Big-D'
artist 'Shaolin Dub'
charter 'UlyssesZhan' # replace this with your name
difficulty_name 'Master'
difficulty_color :master
difficulty '10'

end
```

## Step 4: determine the offset and BPM

Now, you need to determine the offset and BPM of the music
and write the information into the source codes file.
Use your favorite audio editing software to open the music
(I use Audacity here).

To determine them, inside a section of the music with consistent BPM,
find a beat that is clear to recognize (up to milliseconds precision for the best).

![First clear beat](https://i.imgur.com/rI5UXgm.png)

Then, find the time of the beat.
You can read off the time at the "Audio Position" field in Audacity,
which says 7.023 seconds here.

Then, find the last beat that is clear to recognize.

![Last clear beat](https://i.imgur.com/eJw6ZaJ.png)

Then, find the time of the beat.
It is 180.071 seconds.

You now need to know how many beats are there between the two beats.
You can first approximately measure the length of, say, 8 beats,
and then divide the length between the two beats by the length of 8 beats
to estimate how many "8 beats" are there.
Because we can easily hear that number of beats modulo 4 is 2,
we can use the fact to check our result of calculation
(the result of the division should be close to something point 25 or something point 75).
The result should be approximately $49.75$.
Then, we can calculate the BPM now:

```math
60\,\mathrm{s/min}\cdot
\frac{49.75\times8\,\mathrm{beats}}{180.071\,\mathrm s-7.023\,\mathrm s}
\approx137.996\,\mathrm{beats/min}.
```

So the BPM is approximately 138.

To get the offset, we just need to extrapolate the time of the zeroth beat.
We can count that the first clear beat we chose is the 16th beat,
so we can use the BPM and the time of the 16th beat to extrapolate the time of the zeroth beat:

```math
7.023\,\mathrm s-16\,\mathrm{beats}\cdot
\frac{60\,\mathrm{s/min}}{138\,\mathrm{beats/min}}
\approx0.066\,\mathrm s.
```

Now that we got the offset and BPM, we can write them into the source codes file:

```ruby
offset 0.066
bpm 138
```

The whole source codes file should now look like this:

```ruby
# frozen_string_literal: true

Sunniesnow::Charter.open 'master' do

title 'Big-D'
artist 'Shaolin Dub'
charter 'UlyssesZhan' # replace this with your name
difficulty_name 'Master'
difficulty_color :master
difficulty '10'

offset 0.066
bpm 138

end
```

## Step 5: write the chart

Now, you are ready to write the main part of the chart!

### Write notes

Write the following code:

```ruby
hold -25, 0, 1/2r # a hold note at (-25,0) with the duration of 1/2 beats
beat 3/4r         # go to beat 3/4
hold 25, 0, 1/2r  # a hold note at (25,0) with the duration of 1/2 beats
beat 1/4r + 2     # go to beat 3
hold 0, 25, 1/2r  # a hold note at (0,25) with the duration of 1/2 beats
beat 1            # go to beat 4

hold -25, -25, 1/2r
beat 3/4r
hold 25, -25, 1/2r
beat 1/4r + 2
hold 0, -50, 1/2r
beat 1
```

By writing these, you added 6 hold notes to the chart.
Each `hold` adds a hold note to the chart.
The first argument is the $x$-coordinate of the hold note,
the second argument is the $y$-coordinate of the hold note,
and the third argument is the duration of the hold note in beats.
There is an optional fourth argument, which is the text on the hold note
(defaults to empty string).
Each `beat` call proceeds the current beat by the argument you specifies.

> Here is a notice for those who are not familiar with Ruby:
expression like `1/2r` means the rational number $1/2$.
In sscharter, you need to specify beats in integers or rational numbers
to avoid rounding errors.
Here is an example of how rational numbers avoid rounding errors:
>
> ```ruby
> 1/10r + 1/5r == 3/10r # => true
> 0.1 + 0.2 == 0.3 # => false
> ```
>
> The rounding error would not be huge even if being added up many times,
but it is still better to avoid it.
>
> If you are tired of appending `r` to every rational number, you may use
> 
> ```ruby
> Integer.alias_method :/, :quo
> ```
>
> to make the division operation between integers automatically return rational numbers.

You can also abbreviate `hold` to `h` and `beat` to `b`, like this:

```ruby
h -25, 0, 1/2r; b 3/4r
h 25, 0, 1/2r; b 1/4r + 2
h 0, 25, 1/2r; b 1
```

> Here is another notice for those who are not familiar with Ruby.
In Ruby, the semicolon `;` can be used to separate multiple statements in a single line.
Therefore, `h -25, 0, 1/2r; b 3/4r` is equivalent to
>
> ```ruby
> h -25, 0, 1/2r
> b 3/4r
> ```

Here is a list of all the note types you can use:

| Note type | Syntax | Abbreviation |
|-|-|-|
| tap | `tap x, y, text=""` | `t` |
| hold | `hold x, y, duration_beats, text=""` | `h` |
| drag | `drag x, y` | `d` |
| flick | `flick x, y, direction, text=""` | `f` |
| background note | `bg_note x, y, duration_beats=0, text=""` | |

Here are some notices:

- The direction of a flick note can be a number specifying the angle in **radians**
(zero is to the right, and increasing angle is counterclockwise),
or it can be one of the following 8 symbols:
`:right`, `:up_right`, `:up`, `:up_left`, `:left`, `:down_left`, `:down`, `:down_right`.
- The duration of a background note can be zero, but that of a hold note cannot.

> Here is another notice for those who are not familiar with Ruby.
> In Ruby, the parentheses around the arguments of a method call can be omitted.
> Therefore, `tap 25, 0, 'hi'` is equivalent to `tap(25, 0, 'hi')`.

Now, the whole source codes file should look like this:

```ruby
# frozen_string_literal: true

Sunniesnow::Charter.open 'master' do

title 'Big-D'
artist 'Shaolin Dub'
charter 'UlyssesZhan' # replace this with your name
difficulty_name 'Master'
difficulty_color :master
difficulty '10'

offset 0.066
bpm 138

h -25, 0, 1/2r; b 3/4r
h 25, 0, 1/2r; b 1/4r + 2
h 0, 25, 1/2r; b 1

h -25, -25, 1/2r; b 3/4r
h 25, -25, 1/2r; b 1/4r + 2
h 0, -50, 1/2r; b 1

end
```

You may build the level file and play it on Sunniesnow to see what you have done!
If everything is alright, you should see a chart like this:

![The chart](https://i.imgur.com/zPUtgGr.png)

If you see something similar, congratulations!

### Background patterns

There are totally 7 different kinds of background patterns:

| Pattern | Syntax |
|-|-|
| big text | `big_text duration_beats=0, text` |
| grid | `grid duration_beats=0` |
| hexagon | `hexagon duration_beats=0` |
| checkerboard | `checkerboard duration_beats=0` |
| diamond grid | `diamond_grid duration_beats=0` |
| pentagon | `pentagon duration_beats=0` |
| turntable | `turntable duration_beats=0` |

Most of them only has one optional argument, specifying the duration.
The big text is different in that it needs an additional required argument,
specifying the contents of the texts.

The mathematical details about the shapes of these patterns are
specified in [the documentation](https://sunniesnow.github.io/doc/chart.html).

You may now try adding a grid pattern to the chart:

```ruby
offset 0.066
bpm 138

grid 16 # add a grid pattern with duration 16 beats

# notes...
h -25, 0, 1/2r; b 3/4r
```

### Groups, duplicates, and transformations

You have already written the chart for the first 8 beats of *Big-D*.
Then, you want to have the same for the next 8 beats.
How would you do that?

Well, an obvious solution is to copy and paste the code you have written.
However, this has some drawbacks:

- If at some point you want to change the pattern,
you have to change it at multiple places.
- When you read the codes, it would not be obvious at a glance that
"hey, this part is the same as that part!"

Come on, you are programming! Are not there some better ways?
Fortunately, there are, and there are multiple ways to do that.

First, you can define a method, and call that method twice:

```ruby
def pattern # the method name `pattern` is arbitrary, set what you like
  h -25, 0, 1/2r; b 3/4r
  h 25, 0, 1/2r; b 1/4r + 2
  h 0, 25, 1/2r; b 1

  h -25, -25, 1/2r; b 3/4r
  h 25, -25, 1/2r; b 1/4r + 2
  h 0, -50, 1/2r; b 1
end
pattern
pattern
```

Another way of doing this is to create a group of notes and duplicate them.
You can write these:

```ruby
notes = group do # the variable name `notes` is arbitrary, set what you like
  h -25, 0, 1/2r; b 3/4r
  h 25, 0, 1/2r; b 1/4r + 2
  h 0, 25, 1/2r; b 1

  h -25, -25, 1/2r; b 3/4r
  h 25, -25, 1/2r; b 1/4r + 2
  h 0, -50, 1/2r; b 1
end
new_notes = duplicate notes # duplicate them to get a group of new notes
transform(new_notes) { beat_translate 8 } # translate those new notes by 8 beats
b 8 # calling `transform` does not affect current beat, so proceed by 8 beats now
```

In this example, the variable `notes` is assigned the return value of `group`,
which is actually an array of the events inside the code block in the call of `group`.
The variable `new_notes` is assigned the return value of `duplicate`,
which is another array of other events, which are copies of the events in `notes`.

> In Ruby, code blocks can be written as a `do`...`end` block **or** a curly-enclosed block (`{`...`}`).
They have equivalent effects but have different precedences,
and by convention, if the code block contains only one line of codes,
people use a curly-enclosed block to make it seem more compact.

Transformations are more powerful than just translating in time.
There are many other transformations you can apply to notes.
Here is a list:

| Syntax | Meaning |
|-|-|
| `translate dx, dy` | translating in space by vector $(\mathtt{dx},\mathtt{dy})$ |
| `horizontal_flip` | flipping horizontally |
| `vertical_flip` | flipping vertically |
| `rotate angle` | rotating by `angle` (in radians) counterclockwise |
| `scale sx, sy=sx` | scaling by `sx` in $x$ and by `sy` in $y$; negative values are also valid |
| `compound_linear xx, xy, yx, yy` | applying a linear transformation specified by numbers in a matrix |
| `beat_translate delta_beat` | translating in time by `delta_beat` beats |

> For those who are not familiar with linear algebra,
some of the transformations on a 2-dimensional shape can be specified by a $2\times2$ matrix.
Those transformations are called **linear transformations**.
The matrix is called the **transformation matrix**.
The transformation is done like this:
>
> ```math
> x'=\mathtt{xx}\cdot x+\mathtt{xy}\cdot y,\quad
> y'=\mathtt{yx}\cdot x+\mathtt{yy}\cdot y.
> ```

*Notice*: When doing spatial transformations,
you do not need to worry about the direction of flick notes.
They are taken care of as well.

*Another notice*: For background patterns,
they are ignored when doing spatial transformations.
They are still affected by temporal transformations, though.

Therefore, you can also apply, say, a horizontal flip on the duplicated notes like this:

```ruby
notes = group do
  # ...
end
transform duplicate notes do
  horizontal_flip
  beat_translate 8
end
```

Transformations can also be used to bulk edit notes.
Imagine that you have already written a bunch of notes with their coordinates,
but you then decided them move them (say, translating by vector $`(25,25)`$).
You can use `transform` to do that:

```ruby
notes = group do
  # ...
end
transform(notes) { translate 25, 25 }
```

> Because argument of `rotate` is in radians,
> you may want to use the Math constant $\pi$.
> In Ruby, it is `Math::PI`.
> If you use this constant a lot, you may want to write `include Math`
> at the beginning of the source codes file so that you can just write `PI`
> instead of `Math::PI` every time.

### Navigate among beats

You have already learned how to use `beat` to proceed the current beat
by a certain amount of beats.
It can also navigate backwards by using negative numbers.

You can get the current beat number by using `beat` without arguments:

```ruby
offset 0.066 # using `offset` will reset the current beat to zero
p beat # this will output 0 in the terminal, because the current beat is 0
p b # `b` is an abbreviation of `beat`, so this will also output 0
beat 1 # proceed the current beat by 1 beat
p beat # this will output 1 in the terminal, because the current beat is 1
b 3/4r # proceed the current beat by 3/4 beats
p b # this will output 7/4 in the terminal, because the current beat is 7/4
b -1/2r # go back by 1/2 beats
p b # outputs 5/4
b -2 # go back by 2 beats, even if the current beat is only 5/4
p b # outputs -3/4
```

> In Ruby, the method `p` is used to output any object in the terminal
in a human-readable form.
You can use it to debug your program.

You can use `beat!` (whose abbreviation is `b!`) to set the current beat directly,
instead of specifying the amount of beats to proceed relative to the current beat:

```ruby
beat! 10 # set the current beat to 10
p beat # outputs 10
b! -5 # set the current beat to -5
p b # outputs -5
p beat! # this outputs -5 because you may also use `beat!` without arguments to get the current beat
p b! # this also outputs -5
```

You can use `time_at` to get the time (in seconds) of a certain beat:

```ruby
offset 0.1
bpm 120
p time_at 0 # outputs 0.1, meaning that beat 0 is at 0.1 seconds
p time_at 1 # outputs 0.6, meaning that beat 1 is at 0.6 seconds
b! 10
p time_at # when using `time_at` without arguments, it will use the current beat; outputs 5.1

offset 0.2 # this resets current beat to 0
bpm 120 # calling `offset` clears BPM info, so you need to set it again
p time_at # outputs 0.2, meaning that beat 0 is at 0.2 seconds
```

Having `beat!`, you can now travel back to some point in time
to write some notes there:

```ruby
checkpoint = b

# write something here...

b! checkpoint # travel back to the checkpoint

# write something here...
```

However, there is another way of doing this.
You can encapsulate the first set of notes in a `group` that does
*not preserve beat*,
which means that the current beat is set to how it was at the start of the group when the group finishes,
like this:

```ruby
group preserve_beat: false do
  # write something here...
end
# write something here...
```

### BPM changes

*Notice*: because *Big-D* does not have BPM changes,
this part of the tutorial will not be used in the actual chart of *Big-D*.
You may still try it out, though.

You can use `bpm` to set the BPM starting at the current beat.

```ruby
offset 0
bpm 120
p time_at # outputs 0.0
b 1 # proceed by 1 beat
p time_at # outputs 0.5
bpm 60 # set the BPM starting at the current beat to 60
b 1
p time_at # outputs 1.5
```

As we can see, BPM changes only affect the beats **after** they were set.
Beats before the BPM changes are not affected.
However, this means that you cannot get the time before the first BPM you set:

```ruby
offset 0
bpm 120
p time_at -1 # raises an error!
```

### Tip points

Sscharter regards tap, hold, drag, and flick as *tip-pointable* events.
Note that although Sunniesnow also regards background notes as tip-pointable,
sscharter does not.
Tip-pointable events can be connected by tip points,
and one tip-pointable event can be connected by at most one tip point.
A set of events that are connected by the same tip point compose a *tip point chain*.

There are two methods for you to write tip points:
`tip_point_chain` and `tip_point_drop`,
and they are respectively abbreviated as `tp_chain` and `tp_drop`.
Before introducing them, I need to first explain how to specify
where and when a tip point spawns.
There are two ways to specify where the tip point spawns:

- Specifying the coordinates relative to the first tip-pointable event in the tip point chain.
This is the default way.
You specify the $x$-coordinate and $y$-coordinate
by the first two arguments of `tip_point_chain` or `tip_point_drop`.
- Specifying the absolute coordinates of the position where the tip point spawns.
To specify the position in this way,
you need to add a keyword argument `relative: false` to the call of `tip_point_chain` or `tip_point_drop`.

There are four ways to specify when the tip point spawns:

- Specifying how much time, in seconds,
before the first tip-pointable event in the tip point chain the tip point will have spawned.
This is the default way.
The time is specified by the third argument in the call of `tip_point_chain` or `tip_point_drop`.
- Specifying the speed of the tip point between its spawning and the first tip-pointable event in the tip point chain.
To specify the speed, you need to use the keyword argument `speed:`
in the call of `tip_point_chain` or `tip_point_drop`.
- Specifying how many beats before the first tip-pointable event
in the tip point chain the tip point will have spawned.
To specify the beats, you need to use the keyword argument `relative_beat:`
in the call of `tip_point_chain` or `tip_point_drop`.
- Specifying the beat speed (unit length per beat)
of the tip point between its spawning and the first tip-pointable event in the tip point chain.
To specify the beat speed, you need to use the keyword argument `beat_speed:`
in the call of `tip_point_chain` or `tip_point_drop`.
The beat speed may be specified as a float number,
and this is the only case where something related to beats is not preferred to be specified as a rational number.

Besides the two methods `tip_point_chain` and `tip_point_drop`,
there is another method `tip_point_none` (abbreviated as `tp_none`)
for you to specify that those events in the code block are not connected by tip points.
This is useful when you nest those methods inside each other.
Different from `tip_point_chain` and `tip_point_drop`,
the method `tip_point_none` does not take any arguments
(besides `preserve_beat`, which will be mentioned later).

We can summarize all of them in the following table:

<table>
  <tr>
    <th>Method</th>
    <td><code>tip_point_chain</code></td>
    <td><code>tip_point_drop</code></td>
    <td><code>tip_point_none</code></td>
  </tr>
  <tr>
    <th><code>relative_time</code></th>
    <td><code>tip_point_chain x=0, y=0, relative_time=0.0, relative: true</code></td>
    <td><code>tip_point_drop x=0, y=0, relative_time=0.0, relative: true</code></td>
    <td></td>
  </tr>
  <tr>
    <th><code>speed</code></th>
    <td><code>tip_point_chain x=0, y=0, relative: true, speed:</code></td>
    <td><code>tip_point_drop x=0, y=0, relative: true, speed:</code></td>
    <td></td>
  </tr>
  <tr>
    <th><code>relative_beat</code></th>
    <td><code>tip_point_chain x=0, y=0, relative: true, relative_beat:</code></td>
    <td><code>tip_point_drop x=0, y=0, relative: true, relative_beat:</code></td>
    <td></td>
  </tr>
  <tr>
    <th><code>beat_speed</code></th>
    <td><code>tip_point_chain x=0, y=0, relative: true, beat_speed:</code></td>
    <td><code>tip_point_drop x=0, y=0, relative: true, beat_speed:</code></td>
    <td></td>
  </tr>
</table>

You can only choose one of the four ways to specify the position and time of the spawning of a tip point.
If you specify more than one of them, an error will be raised.

> In Ruby, keyword arguments are specified after the normal arguments.
You need to explicitly write the name of the keyword argument followed by a colon
in the method call.
For example, in the expression
>
> ```ruby
> tp_chain 0, 100, speed: 100 do
>   # ...
> end
> ```
>
> the argument `speed:` is a keyword argument in the call of `tp_chain`.
The value of the keyword argument is `100`.

Knowing how to specify the position and time of the spawning of a tip point,
then creating tip points is just as easy as filling events in the code block
in the call of `tip_point_chain` or `tip_point_drop`.

Now I need to explain the difference of `tip_point_chain` and `tip_point_drop`.
`tip_point_chain` creates only one tip point chain,
and the tip point connects every tip-pointable event in the code block;
`tip_point_drop` creates as many tip point chains as the number of tip-pointable events in the code block,
and each tip point chain connects only one tip-pointable event.

As an example, let's connect the notes in the first 8 beats of *Big-D* by tip points:

```ruby
tp_chain 0, 100, speed: 100 do
  h -25, 0, 1/2r; b 3/4r
  h 25, 0, 1/2r; b 1/4r + 2
  h 0, 25, 1/2r; b 1

  h -25, -25, 1/2r; b 3/4r
  h 25, -25, 1/2r; b 1/4r + 2
  h 0, -50, 1/2r; b 1
end
```

If you want to duplicate those tip-pointed notes, you do not need to encapsulate them with another layer of `group`.
The return value of `tip_point_chain` or `tip_point_drop`
is already an array of the events in the code block.
Therefore, you can just do this:

```ruby
notes = tp_chain 0, 100, speed: 100 do
  # notes...
end
transform duplicate notes do
  # transforms...
end
```

*Tips*:
Just like `group`, `tip_point_chain` and `tip_point_drop`
may also not preserve beat.
You can let them not preserve beat by specifying the keyword argument `preserve_beat: false`:

```ruby
tp_chain 0, 100, speed: 100, preserve_beat: false do
  # notes...
end
```

Now, the whole source codes file should look like this:

```ruby
# frozen_string_literal: true

Sunniesnow::Charter.open 'master' do

title 'Big-D'
artist 'Shaolin Dub'
charter 'UlyssesZhan' # replace this with your name
difficulty_name 'Master'
difficulty_color :master
difficulty '10'

offset 0.066
bpm 138

grid 16

notes = tp_chain 0, 100, speed: 100 do
  h -25, 0, 1/2r; b 3/4r
  h 25, 0, 1/2r; b 1/4r + 2
  h 0, 25, 1/2r; b 1

  h -25, -25, 1/2r; b 3/4r
  h 25, -25, 1/2r; b 1/4r + 2
  h 0, -50, 1/2r; b 1
end
transform duplicate notes do
  horizontal_flip
  beat_translate 8
end

end
```

You may build the level file and play it on Sunniesnow to see what you have done!

![Second chart](https://i.imgur.com/ksu5sVW.png)

When duplicating tip-pointed events,
the duplicated events are not connected by the same tip point as the original events.
However, if two original events are connected by the same tip point,
their duplicates are also connected by the same tip point, too.
If you want the duplicated events to be connected by the same tip point as the original events,
you can add set the keyword argument `new_tip_points:` to `false` in the call of `duplicate`:

```ruby
notes = tp_chain 0, 100, speed: 100 do
  # notes...
end
transform duplicate notes, new_tip_points: false do
  # transforms...
end
```

## Advanced charting techniques

TODO.

### Use Git as a version manager

### Useful loops

### Homography

### Tip points and placeholders

### Multiple offsets and timing tweaking

### JSON post-processing

## Step 6: review your chart and write the README

Now, you have finished writing the chart!
Please always play the chart yourself on Sunniesnow to see if it is enjoyable to play it.
You should also try playing it in mirror mode (horizontal flip and/or vertical flip)
so that you do not apply too much of your charting memories to playing the chart.

Then, it is time to finish writing the README.
A template for the README file should have already been generated for you by sscharter.
Use your text editor to edit it!

## Step 7: distribute the level file

Congratulations! You finished your chart.
Now, you can distribute the level file to people who may want to play it.

If you want your chart to be available as an online level of Sunniesnow,
you need to
<a href="mailto:UlyssesZhan <ulysseszhan@gmail.com>">contact the author of Sunniesnow</a>.
