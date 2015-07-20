class PagesController < ApplicationController
  def index
    @foods = Food.all
    @categories = food_categories(@foods)
    @grouped_drinks = split_into_groups(@foods)
  end

  def order
    #check_opening_hours
    @foods = Food.all.includes(:prices)
    @order = current_order
    set_discount(@order)
    @categories = food_categories(@foods)
    @grouped_drinks = split_into_groups(@foods)
    @hour_type = current_hour_type(Time.zone.now.hour)
    @delivery_hours = find_delivery_hours(@hour_type)
    @delivery_values = format_hours(@delivery_hours)
  end

  def toggle_extras
    food = Food.find_by(id: params[:food_id])
    price = food.prices.find_by(id: params[:price_id])
    name = params[:name]
    chosen_extras = Extra.where(id: params[:extras]) if params[:extras]
    render_response(toggle_extras: { food: food,
                                     price: price,
                                     name: name,
                                     chosen_extras: chosen_extras })
  end

  def show_postal
    order = current_order
    unless order.persisted?
      order.save!
      session[:order_id] = order.id
    end
    hour_type = current_hour_type(Time.zone.now.hour)
    delivery_hours = find_delivery_hours(hour_type)
    delivery_values = format_hours(delivery_hours)
    postals = [10119, 10178, 10405,
             10407, 10409, 10435,
             10437, 10439, 13086,
             13357, 13359]
    render_response(show_postal: { postals: postals,
                                   order: order,
                                   hour_type: hour_type,
                                   delivery_values: delivery_values })
  end

  def imprint
    render 'imprint'
  end

  def order_finished
    @order = Order.find(session[:finished_order_id])
    render 'pages/order_finished'
  end


  private

  def set_discount(order)
    order.discount = discount_value('start')
    order.save!(validate: false)
  end

  def check_opening_hours
    current_hour = Time.zone.now.hour.to_i
    hour_type = current_hour_type(current_hour)
    redirect_to root_path if hour_type == 'no_order'
  end

  def toggle_extras_json(toggle_extras)
    {
      toggle_extras: render_to_string(
        partial: 'toggle_extras',
        locals: { food: toggle_extras[:food],
                  price: toggle_extras[:price],
                  chosen_extras: toggle_extras[:chosen_extras] },
        formats: [:html]
      ), food_id: toggle_extras[:food].id,
      name: toggle_extras[:name]
    }
  end

  def show_postal_json(show_postal)
    {
      show_postal: render_to_string(
        partial: 'postal_modal',
        locals: { order: show_postal[:order],
                  postals: show_postal[:postals],
                  hour_type: show_postal[:hour_type],
                  delivery_values: show_postal[:delivery_values] },
        formats: [:html]
      )
    }
  end


  def render_response(toggle_extras: false, show_postal: false)
    json = {}
    json.merge!(toggle_extras_json(toggle_extras)) if toggle_extras
    json.merge!(show_postal_json(show_postal)) if show_postal
    respond_to do |format|
      format.json do
        render json: json
      end
    end
  end
end
