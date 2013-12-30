require File.expand_path('../lib/dep_dive/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'deep_dive'
  s.version     = DeepDive::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = "DeepDive Deep Contolled Cloning"
  s.description = <<-eof
When you have a system of objects that have many references to each other, it becomes an
issue to be able to clone properly that object graph. There may be control objects you may
not want to clone, but maintain references to. And some references you may not wish to clone at all.

Enter DeepDive. Allows you a means by which you can do controlled deep cloning or
copying of your complex interconnected objects.
eof

  s.require_paths = ['lib']
  s.authors     = ["Fred Mitchell"]
  s.email       = 'fred@lrcsoft.com'
  s.files       = Dir.glob("{docs,bin,lib,spec,templates,benchmarks}/**/*") +
                  ['LICENSE', 'LEGAL', 'README.md', 'Rakefile', '.yardopts', __FILE__]
  s.homepage    = 'http://rubygems.org/gems/deep_dive'
  s.license     = 'MIT'
  s.has_rdoc    = 'yard'
  s.platform    = Gem::Platform::RUBY
end
