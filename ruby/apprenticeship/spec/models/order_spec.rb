require 'rails_helper'
describe Order do
  let(:order) { FactoryGirl.build(:order) }

  describe 'validations' do

    it 'should require status' do
      order.status = nil
      expect(order).not_to be_valid
    end
    it 'should require total if status is not booking' do
      order.status = :submitted
      order.total = nil
      expect(order).not_to be_valid
    end
    it 'should not require total if status is booking' do
      order.status = :booking
      order.total = nil
      expect(order).to be_valid
    end
  end

  describe '#total_price' do
    it 'should return the total price of the order' do
      total = order.order_items.each.sum do |order_item|
        order_item.product_price * order_item.quantity
      end

      expect(order.total_price).to eq(total)
    end
  end
end
