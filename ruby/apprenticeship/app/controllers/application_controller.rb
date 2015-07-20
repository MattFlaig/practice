class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order, :food_categories, :split_into_groups,
                :discount_value, :find_delivery_hours, :format_hours,
                :current_hour

  private

  def current_order
    session[:order_id] = nil if session[:order_id] && (
      !Order.exists?(session[:order_id]) ||
      Order.find(session[:order_id]).status != 'booking'.freeze
    )

    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def discount_value(type)
    discounts = { 'start'=> 10, 'regular'=> 5, 'christmas'=> 8 }
    discounts.each { |k,v| return v if type == k }
  end

  def food_categories(foods)
    foods.each_with_object({}) do |food, hash|
      (hash[food[:category]] ||= []) << food
    end
  end

  def split_into_groups(foods)
    foods.each_with_object({}) do |food, hash|
      (hash[food.group] ||= []) << food unless food.group.nil?
    end
  end

  def current_hour_type(current_hour)
    hours = { 'no_order' => [(0..11).to_a, (15..17).to_a, (22..23).to_a].flatten!,
              'only_pickup' => (12..15).to_a,
              'both' => (18..21).to_a
            }
    hours.each { |k,v| return k if v.include?(current_hour) }
  end

  def find_delivery_hours(hour_type)
    time = Time.zone.now.strftime('%H.%M')
    hours = []
    ['12.00', '12.30', '13.00',
     '13.30', '14.00', '14.30',
     '15.00', '18.00', '18.30',
     '19.00', '19.30', '20.00',
     '20.30', '21.00', '21.30',
     '22.00'
    ].map { |h| hours << h if h.to_f > time.to_f + 1 }
    #hours.each { |i| i.gsub!(".", ":") }
    hours
  end

  def format_hours(delivery_hours)
    formatted_hours = []
    delivery_hours.each do |dh|
      hour = dh[0..1].to_i
      minute = dh[3..4].to_i
      formatted_hours << Time.new(Time.now.year, Time.now.month, Time.now.day, hour, minute)
    end
    #binding.pry
    formatted_hours
  end

end
