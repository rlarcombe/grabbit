require 'rubygems'
require 'bundler/setup'

require 'grabbit'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
