class Order < ActiveRecord::Base
  belongs_to :shopping_cart, inverse_of: :orders
  belongs_to :product, inverse_of: :orders
end
