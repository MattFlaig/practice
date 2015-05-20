require 'rails_helper'
describe OrderItem do
  let(:order_item) { FactoryGirl.build(:order_item) }

  describe 'validations' do
    it 'should require quantity' do
      order_item.quantity = nil
      expect(order_item).not_to be_valid
    end
  end

  describe '#subtotal_price' do
    it 'should return the product of value and quantity' do
      order_item.price = FactoryGirl.build(:price)
      expect(order_item.subtotal_price)
        .to eq(order_item.price.value * order_item.quantity)
    end
  end
end
