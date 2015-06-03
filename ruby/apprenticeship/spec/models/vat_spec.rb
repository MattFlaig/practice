require 'rails_helper'

describe Vat do
  let(:vat) { FactoryGirl.build(:vat) }

  describe 'validations' do
    it 'should require value' do
      vat.value = nil
      expect(vat).not_to be_valid
    end

    it 'should require sales_type' do
      vat.sales_type = nil
      expect(vat).not_to be_valid
    end

    it 'should require category' do
      vat.category = nil
      expect(vat).not_to be_valid
    end

    it 'should not be valid with same sales type and same category' do
      existing_vat = FactoryGirl.create(:vat)
      vat.sales_type = existing_vat.sales_type
      vat.category = existing_vat.category
      expect(vat).not_to be_valid
    end

    it 'should be valid with same sales type and different category' do
      vat.category = 'Standard'
      existing_vat = FactoryGirl.create(:vat, category: 'Alcohol')
      vat.sales_type = existing_vat.sales_type
      expect(vat).to be_valid
    end

    it 'should be valid with different sales type and same category' do
      vat.sales_type = 0
      existing_vat = FactoryGirl.create(:vat, sales_type: 1)
      vat.category = existing_vat.category
      expect(vat).to be_valid
    end
  end
end
