# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrappers/version'

Gem::Specification.new do |gem|
  gem.name          = "bootstrappers"
  gem.version       = Bootstrappers::VERSION
  gem.authors       = ["xdite"]
  gem.email         = ["xdite@rocodev.com"]
  gem.description   = %q{ Bootstrappers is the base Rails application using Bootstrap template and other goodies. }
  gem.summary       = %q{ Bootstrappers is the base Rails application using Bootstrap template and other goodies. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '3.2.11'
  gem.add_dependency 'bundler', '>= 1.1'
end
