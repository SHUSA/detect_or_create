# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'detect_or_create/version'

Gem::Specification.new do |spec|
  spec.name          = "detect_or_create"
  spec.version       = DetectOrCreate::VERSION
  spec.authors       = ["jnwheeler44"]
  spec.email         = ["jnwheeler44@gmail.com"]
  spec.summary       = %q{Gem to replace find_or_create_by functionality in Rails 2.3}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency 'rails', '~> 2.3'
  spec.add_development_dependency 'pry'
  spec.add_runtime_dependency 'rails', '~> 2.3'
end
