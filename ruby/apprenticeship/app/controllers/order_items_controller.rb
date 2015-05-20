class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.status = 0
    @order.save
    session[:order_id] = @order.id

    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :order_id, :food_id)
  end
end
