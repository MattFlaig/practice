class Food < ActiveRecord::Base
  enum category: { pizza: 0, main_course: 1, salad: 2, dessert: 3, drink: 4 }
  validates :order_number, :name, :description, :category, presence: true
  validates :name, :order_number, uniqueness: true
  has_many :prices, as: :pricable
  has_many :order_items
end
