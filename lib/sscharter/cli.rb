# frozen_string_literal: true

require 'fileutils'
require 'yaml'
require 'cgi'
require 'optparse'

require 'zip'
require 'launchy'
require 'webrick'
require 'filewatcher'
require 'rake'
require 'bundler'
require 'em-websocket'

require 'sscharter'

module Sunniesnow
	class Charter
		module CLI
			module_function

			def config
				config_filename = '.sscharter.yml'
				config_filename = '.sscharter.yaml' unless File.exist? config_filename
				unless File.exist? config_filename
					puts 'No .sscharter.yml found'
					return nil
				end
				YAML.load_file config_filename, symbolize_names: true
			end

			singleton_class.attr_reader :commands
			@commands = {}

			class Subcommand
				def initialize name, option_parser, &block
					@name = name
					@option_parser = option_parser
					@block = block
					CLI.commands[name] = self
				end
			
				def run
					options = {}
					@option_parser.parse! into: options
					@block.(*ARGV, **options)
				end
			end
		end
	end
end

class Filewatcher
	# This is a hack. See:
	# https://github.com/filewatcher/filewatcher/blob/v2.0.0/lib/filewatcher.rb#L42
	# The `exit` call here will cause the WEBrick server to report a fatal error.
	def exit
		stop
	end
end

option_parser = OptionParser.new do |o|
	o.banner = 'Usage: sscharter init [project_dir] [files...]'
end
Sunniesnow::Charter::CLI::Subcommand.new :init, option_parser do |project_dir = '.', *files|
	if File.directory?(project_dir) && !Dir.empty?(project_dir)
		puts "Directory #{project_dir} already exists and is not empty"
		return 1
	end
	files_dir = File.expand_path File.join project_dir, 'files'
	FileUtils.mkdir_p files_dir
	FileUtils.cp_r files, files_dir
	FileUtils.cd project_dir do
		File.write 'Gemfile', <<~GEMFILE
			# frozen_string_literal: true
			source 'https://rubygems.org'
			gem 'sscharter', '~> #{Sunniesnow::Charter::VERSION}'
			gem 'rake', '~> #{Rake::VERSION}'
			gem 'bundler', '~> #{Bundler::VERSION}'
		GEMFILE
		File.write 'Rakefile', <<~RAKEFILE
			# frozen_string_literal: true
			task default: :build
			task :build do
				exec 'bundle exec sscharter build'
			end
			task :serve do
				exec 'bundle exec sscharter serve'
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
		CHART
	end
	puts "Project initialized at #{project_dir}"
end

def build **opts
	return 1 unless config = Sunniesnow::Charter::CLI.config
	project_name = config[:project_name] || File.basename(Dir.pwd)
	build_dir = config[:build_dir] || 'build'
	files_dir = config[:files_dir] || 'files'
	sources_dir = config[:sources_dir] || 'src'
	include_files = config[:include] || []
	::Sunniesnow::Charter.charts.clear
	Dir.glob File.join sources_dir, '*.rb' do |filename|
		load filename
	rescue Exception => e
		puts "Error loading #{filename}:"
		puts e.full_message
		return 1
	end
	FileUtils.mkdir_p build_dir
	build_filename = File.join build_dir, "#{project_name}.ssc"
	FileUtils.rm build_filename if File.exist? build_filename
	Zip::File.open build_filename, create: true do |zip_file|
		Dir.glob File.join files_dir, '**', '*' do |filename|
			zip_file.add filename["#{files_dir}/".length..], filename
		end
		include_files.each do |pattern|
			Dir.glob pattern do |filename|
				zip_file.add filename, filename
			end
		end
		::Sunniesnow::Charter.charts.each do |name, chart|
			begin
				output = chart.output_json **opts
			rescue => e
				puts 'An error happened. Report if this is a bug of sscharter.'
				puts e.full_message
				return 2
			end
			zip_file.get_output_stream "#{name}.json" do |file|
				file.write output
			end
		end
	end
	0
end

option_parser = OptionParser.new do |o|
	o.banner = 'Usage: sscharter build'
end
Sunniesnow::Charter::CLI::Subcommand.new :build, option_parser do
	build production: true
end

option_parser = OptionParser.new do |o|
	o.banner = 'Usage: sscharter serve [options]'
	o.on '--host=HOST', String, 'Host name'
	o.on '--exposed-host=HOST', String, 'Exposed host name'
	o.on '--port=PORT', Integer, 'Port number'
	o.on '--live-reload-port=PORT', Integer, 'live_reload port number'
	o.on '--production', 'Disable live_reload'
	o.on '--live-restart', 'Enable live_restart'
	o.on '--open-browser', 'Open browser'
end
Sunniesnow::Charter::CLI::Subcommand.new :serve, option_parser do |host: '0.0.0.0', exposed_host: 'localhost', port: 8011, live_reload_port: 31108, production: false, live_restart: false, open_browser: true|
	return 1 unless config = Sunniesnow::Charter::CLI.config
	server = WEBrick::HTTPServer.new BindAddress: host, Port: port, DocumentRoot: config[:build_dir]
	def server.service request, response
		super
		response['Access-Control-Allow-Origin'] = '*'
		response['Cache-Control'] = 'no-cache'
		response['Content-Type'] = 'application/zip' if request.path.end_with? '.ssc'
	end
	unless production
		live_reload_clients = []
		Thread.new do
			EM.run do
				EM::WebSocket.run host:, port: live_reload_port do |ws|
					ws.onopen do
						live_reload_clients.push ws
					end
					ws.onclose do
						live_reload_clients.delete ws
					end
					ws.onmessage do |message|
						data = JSON.parse message
						case data['type']
						when 'connect'
							puts "Connected: #{data['userAgent']}"
						else
							puts "Unknown message type '#{data['type']}' from live reload client"
						end
					end
				end
			end
		end
	end
	url = CGI.escape "http://#{exposed_host}:#{port}/#{config[:project_name]}.ssc"
	filewatcher = Filewatcher.new [config[:files_dir], config[:sources_dir], *config[:include]]
	Launchy.open "https://sunniesnow.github.io/game/?level-file=online&level-file-online=#{url}" if open_browser
	build_proc = -> do
		puts build(live_reload_port:, production:, live_restart:) == 0 ? 'Finished' : 'Failed'
		live_reload_clients.each { _1.send JSON.generate type: 'update' } unless production
	end
	filewatcher_thread = Thread.new do
		puts 'Building...'
		build_proc.()
		filewatcher.watch do |changes|
			puts 'Rebuilding...'
			build_proc.()
		end
		server.shutdown
		EM.stop unless production
	end
	server.start
	0
end
