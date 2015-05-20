FactoryGirl.define do
  factory :vat do
    category { Vat.categories.keys.sample }
    value { Faker::Number.number(2) }
  end
end
