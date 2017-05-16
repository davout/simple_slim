# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'simple_slim/version'

Gem::Specification.new do |s|
  s.name          = 'simple_slim'
  s.version       = SimpleSlim::VERSION
  s.authors       = ['David FRANÇOIS']
  s.email         = ['david@fr.anco.is']

  s.summary       = %(Slimpay HAPI API wrapper)
  s.description   = %(We wrap a Slimpay wrapper in order to actually get some stuff done today)
  s.homepage      = 'https://github.com/davout/simple_slim'
  s.license       = 'WTFPL'

  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'slimpay',     '~> 1.0'

  s.add_development_dependency 'webmock',   '~> 2.1'
  s.add_development_dependency 'byebug',    '~> 9.0'
  s.add_development_dependency 'rspec',     '~> 3.4'
  s.add_development_dependency 'vcr',       '~> 3.0'
  s.add_development_dependency 'rake',      '~> 10.4'
  s.add_development_dependency 'yard',      '~> 0.8'
  s.add_development_dependency 'simplecov', '~> 0.11'

  s.require_path = 'lib'

  s.files        = Dir['lib/**/*', 'README.md', 'LICENSE']
end

