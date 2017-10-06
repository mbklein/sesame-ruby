
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sesame/version'

Gem::Specification.new do |spec|
  spec.name          = 'sesame-ruby'
  spec.version       = Sesame::VERSION
  spec.authors       = ['Michael B. Klein']
  spec.email         = ['mbklein@gmail.com']

  spec.summary       = 'Ruby wrapper for the CANDYHOUSE Sesame API (https://docs.candyhouse.co/)'
  spec.homepage      = 'https://github.com/mbklein/sesame-ruby'
  spec.license       = 'Apache2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'json'
  spec.add_dependency 'faraday'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'faraday-detailed_logger'
end
