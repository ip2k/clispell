# encoding: utf-8

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
  gem.name = "clispell"
  gem.add_dependency 'dmarkow-raspell'
#  gem.add_dependency 'open-uri'
  gem.executables = ['clispell']
  gem.homepage = "http://github.com/ip2k/clispell"
  gem.license = "Creative Commons by-nc-sa"
  gem.summary = "Simple spell checking and definitions right in your terminal"
  gem.description = "clispell provides an easy-to-use CLI that harnesses ASpell and delivers pretty word info FAST right to your terminal"
  gem.email = "github@seanp2k.endjunk.com"
  gem.authors = ["ip2k"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

=begin
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
=end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

=begin
require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rubycliweather #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
=end
