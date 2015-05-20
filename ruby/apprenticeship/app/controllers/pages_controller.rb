class PagesController < ApplicationController
  require 'pry'

  def index
    @foods = Food.all.includes(:prices)
    @categories = food_categories(@foods)
    # binding.pry
  end
end
