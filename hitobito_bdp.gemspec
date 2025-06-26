$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your wagon's version:
require "hitobito_bdp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "hitobito_bdp"
  s.version = HitobitoBdp::VERSION
  s.authors = ["Your name"]
  s.email = ["Your email"]
  s.summary = "Hitobito-Wagon für Gruppenstruktur und Design der BDP"
  s.description = "Hitobito-Wagon für Gruppenstruktur und Design der BDP"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
end
