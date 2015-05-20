class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order, :food_categories

  private

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def food_categories(foods)
    foods.each_with_object({}) do |food, hash|
      (hash[food[:category]] ||= []) << food
    end
  end
end
