class DeliveryAddress < Address
  validates :mobile, presence: true
  validates :email, presence: true
end
