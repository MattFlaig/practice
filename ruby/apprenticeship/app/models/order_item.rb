class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :order_itemable, polymorphic: true

  has_many :order_item_extras
  has_many :extras, through: :order_item_extras

  validates :quantity, presence: true
  validates :price, presence: true
  validates :size, presence: true
  validates :vat, presence: true
  validates :order_number, presence: true
  validates :name, presence: true
  validates :category, presence: true
  #validates_uniqueness_of :id, scope: :order
  #validates_uniqueness_of :size, scope: [:name, :order]
  #validates_associated :order_item_extras, if: proc { extras }
    #conditions: -> { where({extras: []}) },
    #unless: proc { extras.any? }

  def total_price(extras: true, quantity: true, item: true)
    calculate_quantity = quantity && self.quantity || 1
    total = 0
    total += price * calculate_quantity if item
    total +=
      self.order_item_extras.each.sum { |oie| oie.price * calculate_quantity } if extras
    total
  end

  def vat_value
    ((vat.to_f / 100_00) * total_price).round
  end

  def vats
    Vat.where(category: vat_category)
  end
end
