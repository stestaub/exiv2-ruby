require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'rake/extensiontask'
spec = Gem::Specification.load('exiv2-ruby.gemspec')

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "spec/*_spec.rb"
  t.verbose = true
end

Rake::ExtensionTask.new('exiv2') do |ext|
  # create the native extension under lib/exiv2 folder
  ext.lib_dir = 'lib/exiv2'
  if ENV['EXIV2_DIR']
    ext.config_options << "--with-exiv2-dir=#{ENV['EXIV2_DIR']}"
  end
end

Rake::Task[:test].prerequisites << :compile
task :default => [:compile, :test]