FactoryGirl.define do
  factory :order do
    transient do
      order_items_count 0 # { rand(1..5) }
    end

    total { Faker::Number.number(4) }
    status { Order.statuses.keys.sample }

    after(:build) do |el, eva|
      if el.order_items.length == 0
        eva.order_items_count.times do
          el.order_items << FactoryGirl.build(
            :order_item, order_itemable_type: :food)
        end
      end
    end
  end
end
