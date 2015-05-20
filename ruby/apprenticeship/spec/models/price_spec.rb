require 'rails_helper'

describe Price do
  let(:price) { FactoryGirl.build(:price) }

  describe 'validations' do
    it 'should require value' do
      price.value = nil
      expect(price).not_to be_valid
    end
    it 'should require size' do
      price.size = nil
      expect(price).not_to be_valid
    end
    it 'should require unique sizes' do
      existing_price = FactoryGirl.create(:price, size: 1)
      price.size = existing_price.size
      price.pricable_type = existing_price.pricable_type
      price.pricable_id = existing_price.pricable_id
      expect(price).not_to be_valid
    end
    it 'should be valid with same size and different pricable_id' do
      existing_price = FactoryGirl.create(:price, pricable_id: 1, size: 1)
      price.size = existing_price.size
      price.pricable_id = 2
      price.pricable_type = existing_price.pricable_type
      expect(price).to be_valid
    end
    it 'should be valid with same size and different pricable_type' do
      existing_price = FactoryGirl.create(:price, pricable_type: 'Food', size: 1)
      price.size = existing_price.size
      price.pricable_type = 'Extra'
      price.pricable_id = existing_price.pricable_id
      expect(price).to be_valid
    end
  end
end
