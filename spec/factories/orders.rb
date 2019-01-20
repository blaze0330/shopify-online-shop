FactoryBot.define do
  factory :order do
    shopping_cart { nil }
    product { nil }
  end
end
