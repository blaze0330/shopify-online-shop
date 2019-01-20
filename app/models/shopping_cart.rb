class ShoppingCart < ActiveRecord::Base
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  has_many :orders
  has_many :products, through: :orders
end
