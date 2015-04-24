class Extra < ActiveRecord::Base
	has_many :prices, as: :pricable
end
