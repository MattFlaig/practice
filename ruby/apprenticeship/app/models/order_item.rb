class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :order_itemable, polymorphic: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :size, presence: true
  #validates :vat, presence: true, if: proc { order.status != 'booking' }
  validates :order_number, presence: true
  validates :name, presence: true
  validates :category, presence: true
  validates :size, uniqueness: { scope: [:name, :order] }

  def subtotal_price
    price * quantity
  end
end
