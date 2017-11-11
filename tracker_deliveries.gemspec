# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tracker_deliveries/version'

Gem::Specification.new do |spec|
  spec.name          = "tracker_deliveries"
  spec.version       = TrackerDeliveries::VERSION
  spec.authors       = ["Jason Milkins"]
  spec.email         = ["ocodo@pivotal.io"]
  spec.license       = "MIT"

  spec.summary       = %q{Generate a plaintext summary of Pivotal Tracker delivered stories}
  spec.description   = %q{Tracker Deliveries

Generates a list of currently delivered tracker stories.

Made to assist automatically generating release notes
for continuous delivery.
    }

  spec.homepage      = "https://github.com/ocodo/tracker_deliveries"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "blanket_wrapper", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.3"
  spec.add_development_dependency "sinatra", "~> 2.0"
end
