class OrderItemExtra < ActiveRecord::Base
  belongs_to :extra
  belongs_to :order_item

  validates :price, presence: true
  validates :name, presence: true
  validates :extra_id, uniqueness: { scope: :order_item_id }

  before_validation do
    assign_extra_attributes if (!price || !name) && extra && order_item
  end

  def assign_extra_attributes
    self.name = extra.name
    self.price = extra.price_for_size(order_item.size)
  end
end
