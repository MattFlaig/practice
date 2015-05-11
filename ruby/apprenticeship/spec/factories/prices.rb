FactoryGirl.define do

  factory :price do
    value { Faker::Number.number(3) }
    pricable_type 'Food'
    pricable_id { Faker::Number.digit }
  end
end
