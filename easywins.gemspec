# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easywins/version'

Gem::Specification.new do |spec|
  spec.name          = "easywins"
  spec.version       = Easywins::VERSION
  spec.authors       = ["Michael Henriksen"]
  spec.email         = ["michenriksen@neomailbox.ch"]
  spec.summary       = %q{Probe a web server for common files and endpoints that are useful for gathering information or gaining a foothold.}
  spec.description   = %q{Probe a web server for common files and endpoints that are useful for gathering information or gaining a foothold.}
  spec.homepage      = "https://github.com/michenriksen/easywins"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'methadone'
  spec.add_dependency 'paint'
  spec.add_dependency 'thread'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
