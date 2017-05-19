module SimpleSlim

  #
  # Represents a SDD mandate
  #
  class Mandate

    attr_accessor :rum, :state, :signature_order, :iban, :bic, :bank_name

    def initialize
      yield(self) if block_given?
    end

    #
    # Creates a new mandate signature request. This request is then submitted to
    # the customer who can then sign it either on Slimpay's interface, or in an
    # iframe.
    #
    # The +subscriber_reference+ attribute must be unique to a subscriber and
    # would usually be a user ID.
    #
    # All parameters are mandatory except +country+ and +locale+ that default
    # to 'FR', and +address_2+ that defaults to +nil+.
    #
    # The method returns a hash containing both the URL to redirect the customer
    # to, and the iframe HTML that can be embedded.
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
    # @return [Hash]
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
      # iframe = JSON.load(order.extended_user_approval(mode: 'iframeembedded').parsed_response)['content']
      iframe = JSON.load(order.extended_user_approval(mode: 'iframepopin').parsed_response)['content']

      { success: true, iframe: Base64.decode64(iframe), url: url }
    end

    #
    # Retrieves a mandate given a the reference of a signature order
    #
    # @param reference [String] Order signature reference
    # @return [SimpleSlim::Mandate]
    #
    def self.get_from_signature_order(reference)
      order = Slimpay::Order.new
      order.get_one(reference)
      mandate = JSON.load(order.get_mandate.parsed_response)
      bank_account = JSON.load(order.get_bank_account)
      build_from(mandate, bank_account)
    end

    #
    # Retrieves a mandate given a RUM (reference unique de mandat)
    #
    # @param rum [String]
    # @return [SimpleSlim::Mandate]
    #
    def self.get_from_rum(rum)
      mand = Slimpay::Mandate.new
      mandate = JSON.load(mand.get_one(rum).parsed_response)
      bank_account = JSON.load(mand.get_bank_account)
      build_from(mandate, bank_account)
    end


    protected

    #
    # Instantiates a +SimpleSlim::Mandate+ given Slimpay's representations
    #
    # @param mandate [Hash]
    # @param bank_account [Hash]
    # @return [SimpleSlim::Mandate]
    #
    def self.build_from(mandate, bank_account)
      SimpleSlim::Mandate.new do |m|
        m.rum             = mandate['rum']
        m.state           = mandate['state']
        m.iban            = bank_account['iban']
        m.bic             = bank_account['bic']
        m.bank_name       = bank_account['institutionName']
      end
    end

  end
end

