SimpleSlim
=

[![Build Status](https://secure.travis-ci.org/davout/simple_slim.png?branch=master)](http://travis-ci.org/davout/simple_slim)

Get paid.

1. Get your credentials
2. Get them in your code

````ruby
Slimpay.configure do |config|
  config.client_id          = 'your_client_id'
  config.client_secret      = 'your_client_secret'
  config.creditor_reference = 'your_creditor_reference'
  config.sandbox            = true
  config.notify_url         = 'your_notification_URL'
  config.return_url         = 'your_return_URL'
end
````

3. Get crackin'

````ruby
# Create a SDD mandate
mandate = SimpleSlim::Mandate.create({

})

# Redirect the customer to the `mandate.signature_url` and handle the returned
# success callback.

# Trigger a 42.03 EUR payment against this mandate
charge = mandate.charge(4203)
````

