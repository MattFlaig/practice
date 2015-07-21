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

  def find_delivery_hours
    {
      delivery: [18..22],
      pickup: [12..15, 18..22]
    }
  end

  def format_hours
    find_delivery_hours.each_with_object({}) do |(which, times), hours|
      hours[which] = []
      times.each do |range|
        hours[which] << []
        hours[which].last << nil if range.include?(Time.zone.now.hour + 1)
        range_array = range.step(0.5).to_a
        range_array.each_with_index do |hour, i|
          next if i == range_array.size - 1 || Time.zone.now.hour > hour
          hours[which].last << [
            Time.zone.now.change(hour: hour, min: (hour % 1) * 60),
            Time.zone.now.change(hour: range_array[i + 1], min: (range_array[i + 1] % 1) * 60)
          ]
        end
      end
    end
  end
end
