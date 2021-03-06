class Vat < ActiveRecord::Base
  enum sales_type: { inhouse: 0, takeout: 1 }
  validates :value, presence: true
  validates :category, presence: true
  validates :sales_type, presence: true
  validates :sales_type, uniqueness: { scope: :category }
end
