require 'rails_helper'

describe Food do
  let(:food) { FactoryGirl.build(:food) }

  describe 'validations' do
    it 'should require category' do
      food.category = nil
      expect(food).not_to be_valid
    end
    it 'should require name' do 
      food.name = nil
      expect(food).not_to be_valid
    end
    it 'should require order_number' do 
      food.order_number = nil
      expect(food).not_to be_valid
    end
    it 'should require unique name' do
      existing_food = FactoryGirl.create(:food)
      food.name = existing_food.name
      expect(food).not_to be_valid 
    end
    it 'should require unique order_number' do
      existing_food = FactoryGirl.create(:food)
      food.order_number = existing_food.order_number
      expect(food).not_to be_valid 
    end
  end
end