FactoryGirl.define do
  factory :price do
    value { Faker::Number.number(3) }
    size { Faker::Number.number(1) }

    after(:build) do |el|
      el.vats.nil? && el.vat = FactoryGirl.build(:vat)
    end
  end
end
