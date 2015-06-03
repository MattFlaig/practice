FactoryGirl.define do
  factory :vat do
    sales_type { Vat.sales_types.keys.sample }
    value { Faker::Number.number(2) }
    category 'Standard'
  end
end
