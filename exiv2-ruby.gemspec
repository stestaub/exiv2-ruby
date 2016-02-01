# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exiv2/version'

Gem::Specification.new do |spec|
  spec.name          = "exiv2-ruby"
  spec.version       = Exiv2::VERSION
  spec.authors       = ["Stefan Staub"]
  spec.email         = ["ste.staub@gmail.com"]

  spec.summary       = %q{Wraps the exiv2 library to Ruby}
  spec.description   = %q{Wraps the exiv2 library to Ruby by using Rice.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         =  Dir.glob("ext/**/*.{c,cpp,rb}") +
                        Dir.glob("lib/**/*.rb")
  spec.require_paths = ["lib"]

  spec.extensions << 'ext/exiv2/extconf.rb'

  spec.add_development_dependency 'rice'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
end
