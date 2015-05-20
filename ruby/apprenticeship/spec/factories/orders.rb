FactoryGirl.define do
  factory :order do
    total { Faker::Number.number(4) }
    status { Order.statuses.keys.sample }
  end
end
