require_relative '../spec_helper'

RSpec.describe SimpleSlim::DirectDebit, :vcr do

  describe '.charge' do
    it 'should return a created direct debit instance' do
      dd = SimpleSlim::DirectDebit.charge('SLMP003441095', 1000, 'Foo')

      expect(dd).to be_an_instance_of(SimpleSlim::DirectDebit)
      expect(dd.label).to eql('Foo')
      expect(dd.amount).to eql(BigDecimal('10'))
      expect(dd.reference).to_not be_empty
    end
  end

  describe '.get_from_id' do
    it 'should return the correct direct debit' do
      dd = SimpleSlim::DirectDebit.
        get_from_id('69159d88-3c94-11e7-9800-000000000000')

      expect(dd).to be_an_instance_of(SimpleSlim::DirectDebit)
      expect(dd.reference).to eql('SDD-EXE-20170522-3630636')
    end
  end

end

