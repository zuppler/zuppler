# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zuppler/version'

Gem::Specification.new do |spec|
  spec.name          = "zuppler"
  spec.version       = Zuppler::VERSION
  spec.authors       = ["Iulian Costan"]
  spec.email         = ["iulian.costan@zuppler.com"]
  spec.description   = %q{Zuppler API}
  spec.summary       = %q{Zuppler API}
  spec.homepage      = "https://github.com/zuppler/zuppler"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "active_attr"
  spec.add_dependency "multi_json"
  spec.add_dependency "hashie"
  
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-cucumber"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "codeclimate-test-reporter"
end
