class Backend::OrdersController < ApplicationController
  before_action :check_access, except: %i(login validate_login)

  def login
    redirect_to backend_orders_submitted_path if access_allowed?
  end

  def validate_login
    check_and_login('PizzaGrande2', params[:login].try(:[], :login))
    if access_allowed?
      redirect_to backend_orders_submitted_path
    else
      redirect_to backend_orders_login_path
    end
  end

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
    Order.includes(*order_includes)
      .where('orders.status = 2 and delivery_at < NOW() - INTERVAL \'60 min\' or orders.status > 2')
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

  def check_and_login(correct, pw)
    session[:backend_access] = pw if correct == pw
  end

  def access_allowed?
    session[:backend_access].present?
  end

  def check_access
    check_and_login('PizzaG8', params[:login])
    redirect_to backend_orders_login_path unless access_allowed?
  end
end
