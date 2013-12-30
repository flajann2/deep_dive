# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "deep_dive"
  gem.homepage = "http://github.com/linuxbloke/deep_dive"
  gem.license = "MIT"
  gem.summary = %Q{DeepDive Deep Contolled Cloning}
  gem.description = %Q{
  When you have a system of objects that have many references to each other, it becomes an
  issue to be able to clone properly that object graph. There may be control objects you may
  not want to clone, but maintain references to. And some references you may not wish to clone at all.

  Enter DeepDive. Allows you a means by which you can do controlled deep cloning or
  copying of your complex interconnected objects.
  }
  gem.email = "fred@lrcsoft.com"
  gem.authors = ["Fred Mitchell"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

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
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "deep_dive #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
