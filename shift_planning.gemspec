# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shift_planning/version'

Gem::Specification.new do |spec|
  spec.name          = "shift_planning_client"
  spec.version       = ShiftPlanning::VERSION
  spec.authors       = ["Askar Zinurov"]
  spec.email         = ["mail@asktim.ru"]
  spec.summary       = %q{Client library to www.shiftplanning.com}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/AskarZinurov/shift_planning"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.1"

  spec.add_runtime_dependency 'faraday', "~> 0.9"
  spec.add_runtime_dependency 'faraday_middleware', "~> 0.9.1"
end
