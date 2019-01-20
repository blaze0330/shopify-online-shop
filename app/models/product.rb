class Product < ActiveRecord::Base
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  has_many :orders
  has_many :shopping_carts, through: :orders
end
