class OrderItemsController < ApplicationController
  require 'pry'

  def create
    order = current_order
    food = Food.find(params[:food_id])
    price = food.prices.find(params[:price_id])

    attributes = food.order_item_attributes
    doubled_item = order.order_items.find_by(
      name: attributes[:name],
      size: price.size
    )
    #binding.pry
    if doubled_item
      doubled_item.quantity += order_item_params[:quantity].to_i
      doubled_item.save!
    else
      manage_attributes(
        attributes, price,
        order.order_items.new(order_item_params)
      )
      order.save!

      session[:order_id] = order.id
    end
    render_shopping_cart(order)
  end

  def update
    order = current_order
    order_item = order.order_items.find(params[:id])
    order_item.update_attributes(quantity: params[:quantity])
    #binding.pry
    #order_item.save
    render_shopping_cart(order)
  end

  def destroy
    order = current_order
    order_item = order.order_items.find(params[:id])
    order_item.destroy
    order.order_items.reload
    render_shopping_cart(order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

  def manage_attributes(attributes, price, order_item)
    attributes.merge!(
      size: price.size,
      price: price.value
    )
    order_item.assign_attributes(attributes)
  end

  def render_shopping_cart(order)
    respond_to do |format|
      format.json do
        render json: {
          cart: render_to_string(
            partial: 'cart_text', locals: { order: order },
            formats: [:html]
          ), order_items_count: order.order_items.count
        }
      end
    end
  end
end
