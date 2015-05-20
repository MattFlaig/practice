FactoryGirl.define do
  factory :food do
    transient do
      prices_count { rand(1..5) }
    end

    sequence(:order_number) { |n| n }
    sequence(:name) { |n| "food_#{n}" }
    description { Faker::Lorem.paragraph(2) }
    category { Food.categories.keys.sample }

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
