FactoryBot.define do
  factory :product do
    title { FFaker::Product.product_name }
    price { rand() * 100 }
    inventory_count { rand(100) }
  end
end
