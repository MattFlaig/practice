class FoodExtra < ActiveRecord::Base
  belongs_to :extra
  belongs_to :food
end
