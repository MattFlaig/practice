class Price < ActiveRecord::Base
  validates :value, :size, presence: true
  belongs_to :pricable, polymorphic: true
  validates :size, uniqueness: { scope: [:pricable_id, :pricable_type] }
end
