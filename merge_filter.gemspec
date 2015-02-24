# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'merge_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "merge_filter"
  spec.version       = MergeFilter::VERSION
  spec.authors       = ["Thomas Cioppettini"]
  spec.email         = ["thomas.cioppettini@gmail.com"]
  spec.summary       = %q{DSL for filtering ActiveRecord models}
  spec.description   = %q{Build quick search objects by merging ActiveRecord queries.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
