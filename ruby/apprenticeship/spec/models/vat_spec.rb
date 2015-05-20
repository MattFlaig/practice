require 'rails_helper'

describe Vat do
  let(:vat) { FactoryGirl.build(:vat) }

  describe 'validations' do
    it 'should require value' do
      vat.value = nil
      expect(vat).not_to be_valid
    end

    it 'should require category' do
      vat.category = nil
      expect(vat).not_to be_valid
    end
  end
end
