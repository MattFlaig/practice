class OrderItemsController < ApplicationController
  include ControllerWithCart

  def create
    order = current_order
    price = Price.find_by(id: params[:price_id])
    food = price.pricable
    manage_create(order, food, price)
    session[:order_id] ||= order.id
    response_after_create(order)
  end

  def update
    order = current_order
    order_item = order.order_items.find(params[:id])
    manage_update(order_item)
    hour_type = current_hour_type(Time.zone.now.hour)
    delivery_hours = find_delivery_hours(hour_type)
    delivery_values = format_hours(delivery_hours)
    render_response(cart: { order: order, 
                            hour_type: hour_type, 
                            delivery_values: delivery_values })
  end

  def destroy
    order = current_order
    order_item = order.order_items.find(params[:id])
    order_item.destroy
    render_response(cart: order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

  def manage_create(order, food, price)
    attributes = food.order_item_attributes
    extras = params[:extras] ? Extra.where(id: params[:extras][:extra_ids]) : nil

    manage_attributes(
      attributes, price,
      order.order_items.new(order_item_params),
      food, extras: extras
    )
    order.save!
  end

  def manage_attributes(attributes, price, order_item, food, extras: nil)
    attributes.merge!(
      size: price.size,
      price: price.value,
      vat: food.vats.send(:takeout).first.value,
      order_itemable: food
    )
    order_item.assign_attributes(attributes)
    order_item.extras = extras if extras
  end

  def manage_update(order_item)
    order_item.update_attributes(quantity: params[:quantity])
  end

  def response_after_create(order)
    @foods = Food.all.includes(:prices)
    @categories = food_categories(@foods)
    @grouped_drinks = split_into_groups(@foods)
    @order = order
    #@discount = discount_value('start')
    #binding.pry
    render_response(cart: order, order_menu: [ @categories, @grouped_drinks, @order ])
  end

  def render_response(cart: false, order_menu: false)
    json = {}
    json.deep_merge!(cart_json(cart)) if cart
    json.merge!(order_menu_json(order_menu)) if order_menu

    respond_to do |format|
      format.json do
        render json: json
      end
    end
  end

  def order_menu_json(order_menu)
    {
      order_menu: render_to_string(
        partial: 'boxes/order',
        formats: [:html]
      )
    }
  end
end
