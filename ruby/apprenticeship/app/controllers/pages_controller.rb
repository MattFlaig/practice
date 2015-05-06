class PagesController < ApplicationController
  require 'pry'

  def index
    @foods = Food.all
    @categories = food_categories(@foods)
    # binding.pry
  end


end
