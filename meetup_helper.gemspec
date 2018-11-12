# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meetup_helper/version'
require "irb"

Gem::Specification.new do |spec|
  spec.name          = "meetup_helper"
  spec.version       = MeetupHelper::VERSION
  spec.authors       = ["jinjo39"]
  spec.email         = ["c.delavar@gmail.com"]

  spec.summary       = %q{CLI gem for connecting to meetup.com api}
  spec.description   = %q{Find past meetups attended and download pictures from events}
  spec.homepage      = "https://github.com/jinjo39/MeetupHelper"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mechanize"
  spec.add_development_dependency "meetup_client"
  

  
end
