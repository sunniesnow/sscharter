# frozen_string_literal: true

require_relative "lib/sscharter/version"

Gem::Specification.new do |spec|
	spec.name = "sscharter"
	spec.version = Sunniesnow::Charter::VERSION
	spec.authors = ["Ulysses Zhan"]
	spec.email = ["ulysseszhan@gmail.com"]

	spec.summary = "A Ruby DSL for writing Sunniesnow charts"
	#spec.description = "TODO: Write a longer description or delete this line."
	spec.homepage = "https://github.com/sunniesnow/sscharter"
	spec.required_ruby_version = ">= 3.0.0"

	#spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/sunniesnow/sscharter"
	#spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files = Dir.chdir(__dir__) do
		`git ls-files -z`.split("\x0").reject do |f|
			(File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
		end
	end
	spec.bindir = "exe"
	spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	# Uncomment to register a new dependency of your gem
	# spec.add_dependency "example-gem", "~> 1.0"
	spec.add_dependency 'rubyzip', '~> 2.3'
	spec.add_dependency 'launchy', '~> 2.5'
	spec.add_dependency 'webrick', '~> 1.8'
	spec.add_dependency 'filewatcher', '~> 2.0'
	spec.add_dependency 'em-websocket', '~> 0.5'
	spec.add_development_dependency 'minitest', '~> 5.0'
	spec.add_development_dependency 'rake', '~> 13.0'

	# For more information and examples about making a new gem, check out our
	# guide at: https://bundler.io/guides/creating_gem.html
end
