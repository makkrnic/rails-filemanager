$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_filemanager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_filemanager"
  s.version     = RailsFilemanager::VERSION
  s.authors     = ["Mak Krnic"]
  s.email       = ["mkrnic@gmail.com"]
  s.homepage    = "https://github.com/makkrnic/rails-filemanager"
  s.summary     = "Simple file manager"
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "sqlite3"
end
