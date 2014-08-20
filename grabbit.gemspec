# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grabbit/version'

Gem::Specification.new do |spec|
  spec.name          = "grabbit"
  spec.version       = Grabbit::VERSION
  spec.authors       = ["Richard Larcombe"]
  spec.email         = ["rjlarcombe@gmail.com"]
  spec.description   = %q{Grabbit - Scrape the title, description and best thumbnail image(s) from a given URL.}
  spec.summary       = %q{When you share a URL on Facebook in a post, you will have noticed how FB goes off in the background and pulls the title, description, and best thumbnail images to represent the content on the page. This gem is a simple scraper to do the same.}
  spec.homepage      = "https://github.com/rlarcombe/grabbit"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "nokogiri"  
  spec.add_dependency "httparty"
  spec.add_dependency "addressable"
end
