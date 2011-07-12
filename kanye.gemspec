# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kanye}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Vincent"]
  s.date = %q{2011-07-12}
  s.default_executable = %q{kanye}
  s.description = %q{Lyrical genius, voice of a generation.}
  s.email = %q{sam.vincent@mac.com}
  s.executables = ["kanye"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "History",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/kanye",
    "kanye.gemspec",
    "lib/kanye.rb",
    "lib/kanye/history.rb",
    "lib/kanye/itunes.rb",
    "lib/kanye/page.rb",
    "lib/kanye/track.rb",
    "spec/data/sample.html",
    "spec/data/super.mp3",
    "spec/kanye/itunes_spec.rb",
    "spec/kanye/track_spec.rb",
    "spec/kanye_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/samvincent/kanye}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Ruby H-Y-P-E utility}
  s.test_files = [
    "spec/kanye/itunes_spec.rb",
    "spec/kanye/playlist_spec.rb",
    "spec/kanye/track_spec.rb",
    "spec/kanye_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.7.4"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
      s.add_runtime_dependency(%q<rb-appscript>, ["= 0.6.1"])
      s.add_runtime_dependency(%q<mustache>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.7.4"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, ["> 1.4.0"])
      s.add_runtime_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
      s.add_runtime_dependency(%q<rb-appscript>, ["= 0.6.1"])
      s.add_runtime_dependency(%q<mustache>, [">= 0.99.4"])
    else
      s.add_dependency(%q<httparty>, [">= 0.7.4"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
      s.add_dependency(%q<rb-appscript>, ["= 0.6.1"])
      s.add_dependency(%q<mustache>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<httparty>, [">= 0.7.4"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<nokogiri>, ["> 1.4.0"])
      s.add_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
      s.add_dependency(%q<rb-appscript>, ["= 0.6.1"])
      s.add_dependency(%q<mustache>, [">= 0.99.4"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.7.4"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
    s.add_dependency(%q<rb-appscript>, ["= 0.6.1"])
    s.add_dependency(%q<mustache>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<httparty>, [">= 0.7.4"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<nokogiri>, ["> 1.4.0"])
    s.add_dependency(%q<ruby-mp3info>, ["= 0.6.14"])
    s.add_dependency(%q<rb-appscript>, ["= 0.6.1"])
    s.add_dependency(%q<mustache>, [">= 0.99.4"])
  end
end

