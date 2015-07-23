class Backend::OrdersController < Backend::BackendController
  def submitted
    respond_to do |format|
      format.html do
        order_types.each do |type|
          instance_variable_set("@#{type}", send(type))
        end
      end
      format.json do
        json_render_response
      end
    end
  end

  def update
    order = Order.find(params[:id])
    order.update_attributes(order_attributes)
    order_actions.each do |action|
      order.send(action, order_params[action]) if order_params[action]
    end
    json_render_response
  end

  private

  def order_params
    params.require(:order).permit([
      :delivery_time,
      :confirm!, :cancel!, :complete!
    ])
  end

  def order_attributes
    order_params.except(*order_actions)
  end

  delegate :order_types, to: :class
  def self.order_types
    %i(submitted_orders recent_orders to_do_orders)
  end

  delegate :order_actions, to: :class
  def self.order_actions
    %i(cancel! confirm! complete!)
  end

  def order_includes
    [{ order_items: :extras }, :delivery_address]
  end

  def submitted_orders
    Order.submitted.includes(*order_includes).order(submitted_at: :asc)
  end

  def to_do_orders
    Order.includes(*order_includes)
      .where('orders.status = 2 and delivery_at >= NOW() - INTERVAL \'60 min\'')
      .order(delivery_at: :asc)
  end

  def recent_orders
    date = params[:recent_date].try(:to_date) || Time.zone.today
    Order.includes(*order_includes)
      .where('orders.status = 2 and delivery_at < NOW() - INTERVAL \'60 min\' or orders.status > 2')
      .where('orders.submitted_at::date = :date', date: date)
      .order(submitted_at: :desc)
  end

  order_types.each do |type|
    define_method("#{type}_json") do
      {
        replace: {
          "##{type}" => render_to_string(
            partial: "backend/orders/#{type}",
            locals: { orders: send(type) },
            formats: [:html]
          )
        }
      }
    end
  end

  def json_render_response
    render(json: order_types.each_with_object({}) do |type, object|
      object.deep_merge! send("#{type}_json")
    end)
  end
end
