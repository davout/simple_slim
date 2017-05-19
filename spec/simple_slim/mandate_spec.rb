require_relative '../spec_helper'

RSpec.describe SimpleSlim::Mandate, :vcr do

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

  describe '.create_signature_order' do
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

  describe '.get_from_signature_order' do
    it 'should return a SimpleSlim::Mandate instance' do
      reference = '84ca416e-3c7f-11e7-9800-000000000000'
      mandate = SimpleSlim::Mandate.get_from_signature_order(reference)

      expect(mandate).to be_an_instance_of(SimpleSlim::Mandate)
      expect(mandate.rum).to eql('SLMP003441095')
      expect(mandate.state).to eql('active')
      expect(mandate.iban).to eql('FR7616348000019212905486870')
      expect(mandate.bic).to eql('SLMPFRP1XXX')
      expect(mandate.bank_name).to eql('SLIMPAY')
    end
  end

  describe '.get_from_rum' do
    it 'should return the correct mandate as a SimpleSlim::Mandate' do
      rum = 'SLMP003441095'
      mandate = SimpleSlim::Mandate.get_from_rum(rum)

      expect(mandate).to be_an_instance_of(SimpleSlim::Mandate)
      expect(mandate.rum).to eql(rum)
      expect(mandate.state).to eql('active')
      expect(mandate.iban).to eql('FR7616348000019212905486870')
      expect(mandate.bic).to eql('SLMPFRP1XXX')
      expect(mandate.bank_name).to eql('SLIMPAY')
    end
  end

end

