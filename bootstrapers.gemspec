# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrapers/version'

Gem::Specification.new do |gem|
  gem.name          = "bootstrapers"
  gem.version       = Bootstrapers::VERSION
  gem.authors       = ["xdite"]
  gem.email         = ["xdite@rocodev.com"]
  gem.description   = %q{ Write a gem description}
  gem.summary       = %q{ Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '3.2.8'
  gem.add_dependency 'bundler', '>= 1.1'
end
