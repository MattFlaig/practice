class Food < ActiveRecord::Base
  enum category: { pizza: 0, main_course: 1, salad: 2, dessert: 3, drink: 4 }

  validates :order_number, presence: true
  validates :name, presence: true
  validates :category, presence: true
  validates :vat_category, presence: true
  validates :name, :order_number, uniqueness: true

  has_many :prices, as: :pricable
  has_many :order_items, as: :order_itemable

  has_many :food_extras
  has_many :extras, through: :food_extras

  has_attached_file :thumbnail, styles: { thumb: '170x170#' },
                                 default_url: '/images/'
  validates_attachment_content_type :thumbnail,
                                     content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def order_item_attributes
    {
      category: category,
      description: description,
      name: name,
      order_number: order_number,
      vat_category: vat_category
    }
  end

  def vats
    Vat.where(category: vat_category)
  end
end
