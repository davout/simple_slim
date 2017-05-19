SimpleSlim
=

[![Build Status](https://secure.travis-ci.org/davout/simple_slim.png?branch=master)](http://travis-ci.org/davout/simple_slim)

Get paid.

1. Get your credentials
2. Get crackin'

````ruby
# Configure it all
Slimpay.configure do |config|
  config.client_id          = 'democreditor01'
  config.client_secret      = 'demosecret01'
  config.creditor_reference = 'democreditor'
  config.sandbox            = true
  config.notify_url         = 'https://goatse.cx/callback' # This must be a HTTPS URL !
  config.return_url         = 'http://goatse.cx/'
end

# Create a SDD mandate signature request
mandate = SimpleSlim::Mandate.create({
  first_name:           'Jean',
  family_name:          'Valjean',
  title:                'Mr',
  telephone:            '+33600000000',
  email:                'jean@valjean.com',
  address_1:            '3 rue du Pain',
  city:                 'Donaldville',
  zip_code:             '66666',
  subscriber_reference: '42'
})

# => { success: true, url: "http://slimpay.com/...", iframe: "<iframe src='...' />" }

# Redirect the customer or show him the iframe, wait for the callback
````

