FactoryGirl.define do
  factory :order_item do
    transient do
      order_itemable_type nil
    end

    quantity { Faker::Number.digit }
    price { Faker::Number.number(3) }
    size { Faker::Lorem.word }
    vat { Faker::Number.number(2) }
    order_number { Faker::Number.number(2) }
    name { Faker::Lorem.word }
    category { Faker::Lorem.word }

    trait :with_food do
      transient do
        order_itemable_type :food
      end
    end

    after(:build) do |el, eva|
      el.order ||= FactoryGirl.build(:order, order_items: [el])

      unless el.order_itemable || eva.order_itemable_type.nil?
        el.order_itemable = FactoryGirl.build(
          eva.order_itemable_type,
          order_items: [el]
        )
      end
    end
  end
end
