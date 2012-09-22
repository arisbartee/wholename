$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wholename/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wholename"
  s.version     = Wholename::VERSION
  s.authors     = ["Aris Bartee"]
  s.email       = ["arisbartee@gmail.com"]
  s.homepage    = "http://github.com/arisbartee/wholename"
  s.summary     = "Provides convenience metods for showing a user's name"
  s.description = "A person's name is made up of multiple name parts both official and affectionate, this gem provides conveniences for show a name based on the available name parts"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
end
