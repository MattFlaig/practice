class OrdersController < ApplicationController

  def index
  	@foods = Food.all
    @categories = food_categories(@foods)
  end

end