# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new :test do |t|
	t.libs << 'test'
	t.libs << 'lib'
	t.test_files = FileList['test/**/test_*.rb']
end

RDoc::Task.new do |t|
	t.main = 'README.md'
	t.rdoc_dir = 'doc'
	t.rdoc_files.include 'README.md', 'tutorial/tutorial.md', 'lib/**/*.rb'
	t.options << '--tab-width'
	t.options << '2'
end

task default: :test
