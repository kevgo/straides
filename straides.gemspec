$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "straides/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "straides"
  s.version     = Straides::VERSION
  s.authors     = ["Kevin Goslar"]
  s.email       = ["kevin.goslar@gmail.com"]
  s.homepage    = "http://github.com/kevgo/straides"
  s.summary     = "HTTP STatus coDES for RAIls"
  s.description = "A more convenient way to return different HTTP status codes from Rails."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "rack"

  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency "rake"
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency "rspec-rails"
end
