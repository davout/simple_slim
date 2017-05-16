require_relative '../spec_helper'

RSpec.describe SimpleSlim::Mandate do

  describe '.create' do
    it 'should create a mandate' do
      expect(SimpleSlim::Mandate.create).
        to be_an_instance_of(SimpleSlim::Mandate)
    end
  end

  describe '.find' do
    pending
  end

  describe '#charge' do
    pending
  end

end

