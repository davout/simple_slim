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

CLIENT_ID     = "democreditor01"
CLIENT_SECRET = "demosecret01"
CREDITOR_REF  = "democreditor"
IS_SANDBOX    = true
NOTIFY_URL    = 'https://requestb.in/1jyece91' # Must be HTTPS !
RETURN_URL    = 'http://lexpress.mu/'

Slimpay.configure do |config|
  config.client_id          = CLIENT_ID
  config.client_secret      = CLIENT_SECRET
  config.creditor_reference = CREDITOR_REF
  config.sandbox            = IS_SANDBOX
  config.notify_url         = NOTIFY_URL
  config.return_url         = RETURN_URL
end

