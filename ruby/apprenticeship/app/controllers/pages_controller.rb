class PagesController < ApplicationController
  require 'pry'

  def index
    @foods = Food.all
    @categories = get_food_categories(@foods)
    # binding.pry
  end



  private

  def get_food_categories(foods)
    hash = Hash.new []
    foods.each {|food| hash[food[:category]] += [food] }
    return hash
  end
end