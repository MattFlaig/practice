class Vat < ActiveRecord::Base
  enum category: { standard: 0, delivery: 1}
  belongs_to :price
  validates :value, :category, presence: true
end
