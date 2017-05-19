module SimpleSlim

  #
  # Represents a SDD mandate
  #
  class Mandate

    #
    # Creates a new mandate signature request. This request is then submitted to
    # the customer who then signs it either on Slimpay's interface, or in an
    # iframe.
    #
    # The +subscriber_reference+ attribute must be unique to a subscriber and
    # would usually be a user ID.
    #
    # All parameters are mandatory except +country+ and locale that default
    # to 'FR', and +address_2+ that defaults to +nil+.
    #
    # @param first_name [String]
    # @param family_name [String]
    # @param title [String] Must either be 'Mr', 'Miss', or 'Mrs'
    # @param telephone [String]
    # @param email [String]
    # @param address_1 [String]
    # @param address_2 [String]
    # @param zip_code [String]
    # @param city [String]
    # @param subscriber_reference [String]
    # @param country [String]
    # @param locale [String]
    #
    # @return [SimpleSlim::Mandate]
    #
    def self.create_signature_order(first_name:, family_name:, title:,
                                    telephone:, 
                                    email:, address_1:, address_2: nil, city:,
                                    zip_code:, subscriber_reference:,
                                    country: 'FR', locale: 'fr')

      order = Slimpay::Order.new
      order_data = {
        creditor: { reference: Slimpay.configuration.creditor_reference },
        subscriber: { reference: subscriber_reference },
        locale: locale,
        paymentScheme: 'SEPA.DIRECT_DEBIT.CORE',
        started: true,
        items: [
          {
            type: 'signMandate',
            mandate: {
              signatory:  {
                billingAddress:  {
                  city: city,
                  country: country,
                  postalCode: zip_code,
                  street1: address_1,
                  street2: address_2
                },
                email: email,
                familyName: family_name,
                givenName: first_name,
                honorificPrefix: title,
                telephone: telephone
              }
            }
          }
        ]
      }

      res = JSON.load(order.create_orders(order_data))

      # Get user approval external link
      url = res['_links']['https://api.slimpay.net/alps#user-approval']['href']

      # Fetch approval iframe
      iframe = JSON.load(order.extended_user_approval(mode: 'iframeembedded').parsed_response)['content']

      { success: true, iframe: iframe, url: url }
    end

    #
    # Retrieves a mandate given a mandate reference
    #
    # @param reference [String]
    # @return [SimpleSlim::Mandate]
    #
    def self.find(reference)
      raise 'implement me'
    end

    #
    # Charges an EUR amount against this mandate
    #
    # @param amount [Integer] Amount to charge in EUR cents
    # @return charge [SimpleSlim::Charge]
    #
    def charge
      raise 'implement me'
    end

  end
end

