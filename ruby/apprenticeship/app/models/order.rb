class Order < ActiveRecord::Base
  enum status: {
    booking: 0,
    submitted: 1,
    confirmed: 2,
    completed: 3,
    failed: 4,
    cancelled: 5
  }

  validates :status, presence: true
  validates :total, presence: true, if: proc { status != 'booking' }

  has_many :order_items

  def total_price
    order_items.each.sum(&:subtotal_price)
  end
end
