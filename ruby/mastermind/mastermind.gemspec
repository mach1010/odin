# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mastermind/version'

Gem::Specification.new do |spec|
  spec.name          = 'mastermind'
  spec.version       = Mastermind::VERSION
  spec.authors       = ['mach1010']
  spec.email         = ['jetstream1010@gmail.com']
  spec.summary       = 'mastermind game'
  spec.description   = 'Mastermind game where player can play as
                        codemaker or codebreaker'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
