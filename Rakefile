# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'

Rake::TestTask.new :test do |t|
	t.libs << 'test'
	t.libs << 'lib'
	t.test_files = FileList['test/**/test_*.rb']
end

YARD::Rake::YardocTask.new do |t|
	t.files.concat %w[README.md]
	t.options.concat %w[--title sscharter --output-dir doc --exclude lib/sscharter/cli.rb --readme]
end

task default: :test
