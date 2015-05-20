FactoryGirl.define do
  factory :order_item do
    quantity { Faker::Number.digit }
  end
end
