class Order < ActiveRecord::Base
  enum status: { booking: 0, submitted: 1, confirmed: 2, completed: 3, failed: 4, cancelled: 5 }
  validates :total, :status, presence: true
  has_many :order_items
end
