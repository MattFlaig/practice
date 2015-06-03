class Food < ActiveRecord::Base
  enum category: { pizza: 0, main_course: 1, salad: 2, dessert: 3, drink: 4 }
  validates :order_number, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :vat_category, presence: true
  validates :name, :order_number, uniqueness: true
  has_many :prices, as: :pricable
  has_many :order_items, as: :order_itemable

  def order_item_attributes
    {
      name: name,
      order_number: order_number,
      category: category
    }
  end
end
