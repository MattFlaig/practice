class PagesController < ApplicationController
  require 'pry'

  def index
    @foods = Food.all
    @categories = food_categories(@foods)
  end

  def order
    @foods = Food.all.includes(:prices)
    @order = current_order
    @categories = food_categories(@foods)
  end
end
