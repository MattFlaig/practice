class Extra < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :prices, as: :pricable
  has_many :order_items, as: :order_itemable

  has_many :food_extras
  has_many :foods, through: :food_extras

  has_many :order_item_extras
  has_many :order_items, through: :order_item_extras

  scope :for_size, -> (size) { joins(:prices).where(prices: { size: size }) }

  def price_for_size(size)
    prices.find_by(size: size).try(:value)
  end

  def extra_price(object)
    prices.find_by(size: object.size).try(:value)
  end
end
