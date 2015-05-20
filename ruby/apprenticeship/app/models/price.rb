class Price < ActiveRecord::Base
  validates :value, :size, :vat, presence: true
  belongs_to :pricable, polymorphic: true
  has_many :vats
  validates :size, uniqueness: { scope: [:pricable_id, :pricable_type] }
end
