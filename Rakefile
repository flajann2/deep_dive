# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'semver'

def s_version
  SemVer.find.format "%M.%m.%p%s"
end

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "deep_dive"
  gem.homepage = "https://github.com/flajann2/deep_dive"
  gem.license = "MIT"
  gem.summary = %Q{DeepDive Deep Contolled Cloning}
  gem.version = s_version
  gem.required_ruby_version = '>= 2.0'
  gem.description = %Q{
  When you have a system of objects that have many references to each other, it becomes an
  issue to be able to clone properly that object graph. There may be control objects you may
  not want to clone, but maintain references to. And some references you may not wish to clone at all.

  Enter DeepDive. Allows you a means by which you can do controlled deep cloning or
  copying of your complex interconnected objects.
  }
  gem.email = "lordalveric@yahoo.com"
  gem.authors = ["Fred Mitchell"]

  # Exclusions
  gem.files.exclude 'foo/**/*', 'rdoc/*',
                    '.idea/**/*', '.idea/**/.*', '.yardoc/**/*',
                    'Guardfile'
end
Juwelier::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = s_version

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "deep_dive #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
