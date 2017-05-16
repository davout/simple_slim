require 'byebug'
require 'simplecov'
require 'vcr'

SimpleCov.start do
  add_filter '/spec/'
end

VCR.configure do |config|
  config.cassette_library_dir       = 'spec/cassettes'
  config.hook_into                  :webmock
  config.default_cassette_options   = { record: :once }
  config.configure_rspec_metadata!
end

require(File.expand_path('../../lib/simple_slim', __FILE__))

