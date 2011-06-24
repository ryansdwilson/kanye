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
  gem.name = "kanye"
  gem.homepage = "http://github.com/samvincent/kanye"
  gem.license = "MIT"
  gem.summary = %Q{Ruby H-Y-P-E utility}
  gem.description = %Q{Lyrical genius, voice of a generation.}
  gem.email = "sam.vincent@mac.com"
  gem.authors = ["Sam Vincent"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'httparty', '>= 0.7.4'
  gem.add_runtime_dependency 'sqlite3'
  gem.add_runtime_dependency 'nokogiri', '> 1.4.0'
  gem.add_runtime_dependency 'ruby-mp3info', '0.6.14'
  gem.add_runtime_dependency 'rb-appscript', '0.6.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

task :default => :spec