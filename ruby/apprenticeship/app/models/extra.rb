class Extra < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :prices, as: :pricable
end
