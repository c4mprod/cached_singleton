# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cached_singleton/version'

Gem::Specification.new do |spec|
  spec.name          = 'cached_singleton'
  spec.version       = CachedSingleton::VERSION
  spec.authors       = ['Thibault El Zamek, Cédric Darné, Lionel Oto']
  spec.email         = ['thibault.elzamek@c4mprod.com, cedric.darne@c4mprod.com, lionel.oto@c4mprod.com']
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files = Dir[*%w( LICENSE.txt README.md lib/**/* )]
  spec.test_files = Dir['spec/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
