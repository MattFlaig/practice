class OrderItem < ActiveRecord::Base
  belongs_to :food
  belongs_to :order
  has_one :price, as: :pricable
  validates :quantity, presence: true

  def subtotal_price
    price.value * quantity
  end
end
