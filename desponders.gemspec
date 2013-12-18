# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'desponders/version'

Gem::Specification.new do |spec|
  spec.name          = 'desponders'
  spec.version       = Desponders::VERSION
  spec.authors       = ['Parker Selbert']
  spec.email         = ['parker@sorentwo.com']
  spec.homepage      = 'https://github.com/dscout/desponders'
  spec.license       = 'MIT'
  spec.description   = 'A stack of light-weight responders tailored to JSON APIs'
  spec.summary       = 'A stack of light-weight responders tailored to JSON APIs'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'railties', '>= 3.2', '< 5'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',   '~> 2.99.0.beta1'
end
