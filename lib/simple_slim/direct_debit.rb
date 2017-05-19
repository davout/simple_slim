module SimpleSlim

  #
  # Represents a SEPA Direct Debit
  #
  class DirectDebit

    attr_accessor :id, :amount, :reference, :label, :execution_status,
      :currency, :sequence_type

    def initialize
      yield(self) if block_given?
    end

    #
    # Creates a Direct Debit for a specific mandate
    #
    # @param rum [String] Mandate reference
    # @param amount [Fixnum] Charged amount in EUR cents
    # @param label [String]
    # @return [SimpleSlim::DirectDebit]
    #
    def self.charge(rum, amount, label = nil)
      direct_debit = Slimpay::DirectDebit.new

      res = direct_debit.create_direct_debits({
        creditor: { reference: Slimpay.configuration.creditor_reference },
        mandate:  { reference: rum },
        amount:   amount / 100,
        currency: 'EUR',
        label:    label
      })

      build_from_hash(JSON.load(res.parsed_response))
    end

    #
    # Returns a single instance given an ID
    #
    # @param id [String] A Slimpay direct debit ID
    # @return [SimpleSlim::DirectDebit]
    #
    def self.get_from_id(id)
      direct_debit = Slimpay::DirectDebit.new
      build_from_hash(JSON.load(direct_debit.get_direct_debits({ id: id })))
    end


    protected

    #
    # Builds a +SimpleSlim::DirectDebit+ instance from a Slimpay representation
    #
    # @param [Hash]
    # @return [SimpleSlim::DirectDebit]
    #
    def self.build_from_hash(hsh)
      SimpleSlim::DirectDebit.new do |dd|
        dd.id               = hsh['id']
        dd.amount           = BigDecimal(hsh['amount'])
        dd.reference        = hsh['paymentReference']
        dd.label            = hsh['label']
        dd.execution_status = hsh['executionStatus']
        dd.sequence_type    = hsh['sequenceType']
        dd.currency         = hsh['currency']
      end
    end

  end
end

