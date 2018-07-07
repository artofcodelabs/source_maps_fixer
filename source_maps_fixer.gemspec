$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "source_maps_fixer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "source_maps_fixer"
  s.version     = SourceMapsFixer::VERSION
  s.authors     = ["Zbigniew Humeniuk"]
  s.email       = ["zbigniew.humeniuk@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SourceMapsFixer."
  s.description = "TODO: Description of SourceMapsFixer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
