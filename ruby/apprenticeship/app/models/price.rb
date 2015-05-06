class Price < ActiveRecord::Base
  enum size: { very_small: 0, small: 1, normal: 2, large: 3, very_large: 4 }
  validates :value, :size, presence: true
  belongs_to :pricable, polymorphic: true
end
