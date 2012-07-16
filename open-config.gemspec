# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "open-config/version"

Gem::Specification.new do |s|
  s.name        = "open-config"
  s.version     = Open::Config::VERSION
  s.authors     = ["Mathieu Berube"]
  s.email       = ["mathieu.berube@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Flexible configuration for ruby}
  s.description = %q{Flexible configuration for ruby}

  s.rubyforge_project = "open-config"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
