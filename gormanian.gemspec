# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gormanian/version'

Gem::Specification.new do |spec|
  spec.name          = "gormanian"
  spec.version       = Gormanian::VERSION
  spec.authors       = ["Jon Cairns"]
  spec.email         = ["jon@joncairns.com"]

  spec.summary       = %q{A Date-like library that uses the Gormanian calendar (as opposed to Gregorian)}
  spec.description   = %q{A Date-like library that uses the Gormanian calendar (as opposed to Gregorian)}
  spec.homepage      = "https://github.com/joonty/gormanian"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
end
