module SimpleSlim

  #
  # Represents a SDD mandate
  #
  class Mandate

    #
    # Create a new mandate in order to be able to trigger payments against a
    # customer's account
    #
    # @return [SimpleSlim::Mandate]
    #
    def self.create
      raise 'implement me'
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

