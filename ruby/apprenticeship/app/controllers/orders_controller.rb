class OrdersController < ApplicationController
  def index
    @foods = Food.all.includes(:prices)
    @categories = food_categories(@foods)
    @order_item = current_order.order_items.new
  end
end
