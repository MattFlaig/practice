require 'rails_helper'

describe OrderItemsController do
  describe 'POST create' do
    context 'if there is an item with same name and size' do
      it 'updates the quantity of the existing item' do
        food = FactoryGirl.create(:food)
        order = FactoryGirl.create(:order)
        order_item = FactoryGirl.create(:order_item, order_itemable: food)

        order.order_items << order_item
        price = food.prices.last

        order_item.update_attributes(name: food.name, size: price.size)

        old_quantity = order_item.quantity

        session[:order_id] = order.id
        post :create, order_item: { quantity: 7 },
                      food_id: food.id,
                      price_id: price.id,
                      format: :json

        expect(order_item.reload.quantity)
          .to eql(old_quantity + 7)
      end
      it 'saves the existing item'
      it 'does not create a new item with same name and size'
    end

    context 'if there is no doubled item' do
      it 'merges the price and food attributes with order item params'
      it 'saves the order'
      it 'puts the order_id into the session'
    end

  end
end
