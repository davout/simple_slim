require_relative '../spec_helper'

RSpec.describe SimpleSlim::Mandate do

  let(:correct_mandate_data) do
    {
      first_name:           'Jean',
      family_name:          'Valjean',
      title:                'Mr',
      telephone:            '+33600000000',
      email:                'jean@valjean.com',
      address_1:            '3 rue du Pain',
      city:                 'Donaldville',
      zip_code:             '66666',
      subscriber_reference: '42'
    }
  end

  # To make the data bogus, we empty one field
  let(:bogus_mandate_data) do
    correct_mandate_data[:first_name] = ''
    correct_mandate_data
  end

  describe '.create_signature_order', :vcr do
    it 'should successfully create a signature order with correct params' do
      res = SimpleSlim::Mandate.create_signature_order(**correct_mandate_data)

      expect(res[:success]).to be(true)
      expect(res).to have_key(:url)
      expect(res).to have_key(:iframe)
    end

    it 'should fail with incorrect params' do
      expect { SimpleSlim::Mandate.create_signature_order(**bogus_mandate_data) }.
        to raise_error(Slimpay::Error)
    end
  end

  describe '.find' do
    pending
  end

  describe '#charge' do
    pending
  end

end

