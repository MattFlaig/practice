class Food < ActiveRecord::Base
	enum category:{ pizza: 0, main_course: 1, salad: 2, dessert: 3, drink: 4 }

	has_many :prices, as: :pricable
end
