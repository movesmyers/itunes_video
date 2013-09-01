Gem::Specification.new do |s|
  s.name        = 'itunes_video'
  s.version     = '0.4.2'
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "Import and organize videos in iTunes"
  s.description = "A gem to import and organize your video collection in iTunes. OS X only."
  s.authors     = ["Richard Myers"]
  s.email       = 'rick.myers@me.com'
  s.license     = 'WTFPL'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://rubygems.org/gems/itunes_video'
  
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
