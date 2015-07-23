class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order, :food_categories, :split_into_groups,
                :discount_value, :find_delivery_hours, :format_hours,
                :current_hour, :find_delivery_postals, :orders_open?

  private

  def orders_open?
    return false if Settings.orders_open != 'open'
    format_hours.each do |_, hours|
      return true unless hours.flatten.blank?
    end
    false
  end

  def check_and_reset_order_id
    session[:order_id] = nil if session[:order_id] && (
      !Order.exists?(session[:order_id]) ||
      Order.find(session[:order_id]).status != 'booking'.freeze
    )
  end

  def current_order
    check_and_reset_order_id

    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new.tap { |o| o.discount = discount_value(:start) }
    end
  end

  def discount_value(type)
    { start: 10, regular: 5, christmas: 8 }
      .find { |k, _| type == k }.try(:second)
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

  def find_delivery_postals
    [10119, 10178, 10405,
     10407, 10409, 10435,
     10437, 10439, 13086,
     13357, 13359]
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
        hours[which].last << nil if range.include?((Time.zone.now + 15.minutes).hour + 1)
        range_array = range.step(0.5).to_a
        range_array.each_with_index do |hour, i|
          next if i == range_array.size - 1
          start = Time.zone.now.change(hour: hour, min: (hour % 1) * 60)
          ending =
            Time.zone.now.change(
              hour: range_array[i + 1], min: (range_array[i + 1] % 1) * 60
            )
          diff = TimeDifference.between(start, Time.zone.now).in_minutes
          next if diff < 45 || start < Time.zone.now
          hours[which].last << [start, ending]
        end
      end
    end
  end
end
