FactoryGirl.define do
  factory :food do
    transient do
      prices_count { (1..5).to_a.sample }
    end

    sequence(:order_number) { |n| n }
    sequence(:name) { |n| "food_#{n}" }
    description { Faker::Lorem.paragraph(2) }
    category { Food.categories.keys.sample }
    vat_category 'Standard'

    after :build do |el, eva|
      if el.prices.length == 0
        sizes = (1..eva.prices_count).to_a
        eva.prices_count.times do
          el.prices << FactoryGirl.build(:price, pricable: el, size: sizes.pop)
        end
      end
    end
  end
end
