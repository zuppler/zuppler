lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zuppler/version'

Gem::Specification.new do |spec|
  spec.name          = 'zuppler'
  spec.version       = Zuppler::VERSION
  spec.authors       = ['Iulian Costan']
  spec.email         = ['iulian.costan@zuppler.com']
  spec.description   = 'Zuppler API'
  spec.summary       = 'Zuppler API'
  spec.homepage      = 'https://github.com/zuppler/zuppler'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'active_attr', '< 0.14.0'
  spec.add_dependency 'hashie'
  spec.add_dependency 'httparty'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'omniauth-oauth2'
  spec.add_dependency 'retriable'

  spec.add_development_dependency 'bump'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'furious'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-cucumber'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'gem-release'
end
