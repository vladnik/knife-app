# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife/app/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-app"
  spec.version       = Knife::App::VERSION
  spec.authors       = ["vladnik"]
  spec.email         = ["vladnik@demandbase.com"]
  spec.summary       = 'Heroku-style Chef commands'
  spec.description   = 'Run application-specific commands in no time'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chef"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
