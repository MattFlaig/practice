class Extra < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :prices, as: :pricable
  has_many :order_items, as: :order_itemable
end
