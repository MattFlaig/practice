class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def food_categories(foods)
    foods.each_with_object({}) do |food, hash|
      (hash[food[:category]] ||= []) << food
    end
  end
end
