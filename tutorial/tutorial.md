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

## Step 3: write the chart

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

