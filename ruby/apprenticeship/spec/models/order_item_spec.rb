require 'rails_helper'
describe OrderItem do
  let(:order_item) { FactoryGirl.build(:order_item) }

  describe 'validations' do
    it 'should require quantity' do
      order_item.quantity = nil
      expect(order_item).not_to be_valid
    end
    it 'should require product_price' do
      order_item.price = nil
      expect(order_item).not_to be_valid
    end
    it 'should require size' do
      order_item.size = nil
      expect(order_item).not_to be_valid
    end
    it 'should require vat' do
      order_item.vat = nil
      expect(order_item).not_to be_valid
    end
    it 'should require order_number' do
      order_item.order_number = nil
      expect(order_item).not_to be_valid
    end
    it 'should require name' do
      order_item.name = nil
      expect(order_item).not_to be_valid
    end
    it 'should require category' do
      order_item.category = nil
      expect(order_item).not_to be_valid
    end

    context 'with order' do
      let(:order) { FactoryGirl.create(:order) }
      let(:order_item) { FactoryGirl.build(:order_item, order: order) }

      it 'should not be valid with same size and name and order' do
        existing_item = FactoryGirl.create(:order_item, order: order)
        order_item.size = existing_item.size
        order_item.name = existing_item.name
        expect(order_item).not_to be_valid
      end
      it 'should be valid with different order, same size and same name' do
        another_order = FactoryGirl.create(:order)
        existing_item = FactoryGirl.create(:order_item, order: another_order)
        order_item.size = existing_item.size
        order_item.name = existing_item.name
        expect(order_item).to be_valid
      end
      it 'should be valid with different name, same size and same order' do
        order_item.name = 'schnick'
        existing_item = FactoryGirl.create(:order_item,
                                           order: order,
                                           name: 'schnack')
        order_item.size = existing_item.size
        expect(order_item).to be_valid
      end
      it 'should be valid with different size, same order and same name' do
        order_item.size = 'klein'
        existing_item = FactoryGirl.create(:order_item,
                                           order: order,
                                           size: 'groß')
        order_item.name = existing_item.name
        expect(order_item).to be_valid
      end
    end

  end

  describe '#subtotal_price' do
    it 'should return the product of price and quantity' do
      order_item.price = FactoryGirl.build(:price).value
      expect(order_item.subtotal_price)
        .to eq(order_item.price * order_item.quantity)
    end
  end
end
