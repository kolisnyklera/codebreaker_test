# frozen_string_literal: true

require_relative 'lib/Codebreaker/version'

Gem::Specification.new do |spec|
  spec.name          = 'Codebreaker'
  spec.version       = Codebreaker::VERSION
  spec.authors       = ['']
  spec.email         = ['']

  spec.summary       = 'Codebreaker gem'
  spec.description   = 'Codebreaker gem'
  spec.homepage      = 'https://github.com/kolisnyklera/codebreaker_test'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.1')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
