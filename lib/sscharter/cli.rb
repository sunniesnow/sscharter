# frozen_string_literal: true

require 'fileutils'
require 'yaml'

require 'zip'

require 'sscharter'

module Sunniesnow
	class Charter
		module CLI
		end
	end
end

module Sunniesnow::Charter::CLI
	module_function

	COMMANDS = %i[init build]

	def init project_dir, *files
		if File.directory? project_dir
			puts "Directory #{project_dir} already exists"
			return 1
		end
		files_dir = File.join project_dir, 'files'
		FileUtils.mkdir_p files_dir
		FileUtils.cp_r files, files_dir
		FileUtils.cd project_dir do
			File.write 'Gemfile', <<~GEMFILE
				# frozen_string_literal: true
				source 'https://rubygems.org'
				gem 'sscharter', '~> #{Sunniesnow::Charter::VERSION}'
			GEMFILE
			File.write 'Rakefile', <<~RAKEFILE
				# frozen_string_literal: true
				task default: :build
				task :build do
					sh 'bundle exec sscharter build'
				end
			RAKEFILE
			File.write '.gitignore', <<~GITIGNORE
				/.bundle/
				/tmp/
				/build/
			GITIGNORE
			File.write '.sscharter.yml', <<~SSCHARTER
				---
				project_name: #{File.basename project_dir}
				build_dir: build
				files_dir: files
				sources_dir: src
				include:
				  - README.md
			SSCHARTER
			File.write 'README.md', <<~README
				# #{File.basename project_dir}

				<!-- TODO: Write a description for your project here -->

				## Building

				[Install Ruby (>= 3.0.0)](https://www.ruby-lang.org/en/documentation/installation/),
				and then run `rake`.
				The built chart will be `build/#{File.basename project_dir}.ssc`.

				## Legal status

				<!-- The artist should have explicitly stated publicly that they permit charting the music,
				or have contacted you to give proper permission.
				Whether or not, you should state clearly the legal status of the chart here. -->
			README
			FileUtils.mkdir_p 'src'
			File.write 'src/master.rb', <<~CHART
				# frozen_string_literal: true

				Sunniesnow::Charter.new 'master' do

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
			CHART
		end
		puts "Project initialized at #{project_dir}"
	end

	def build
		config_filename = '.sschart.yml'
		config_filename = '.sschart.yaml' unless File.exist? config_filename
		unless File.exist? config_filename
			puts 'No .sschart.yml found'
			return 1
		end
		config = YAML.load_file config_filename, symbolize_names: true
		project_name = config[:project_name] || File.basename(Dir.pwd)
		build_dir = config[:build_dir] || 'build'
		files_dir = config[:files_dir] || 'files'
		sources_dir = config[:sources_dir] || 'src'
		include_files = config[:include] || []
		Dir.glob File.join sources_dir, '*.rb' do |filename|
			load filename
		end
		Zip::File.open File.join build_dir, "#{project_name}.ssc" do |zip_file|
			Dir.glob File.join files_dir, '**', '*' do |filename|
				zip_file.add filename["#{files_dir}/".length..], filename
			end
			include_files.each do |pattern|
				Dir.glob pattern do |filename|
					zip_file.add filename, filename
				end
			end
			::Sunniesnow::Charter.charts.each do |name, chart|
				zip_file.get_output_stream "#{name}.json" do |file|
					file.write chart.output_json
				end
			end
		end
	end
end