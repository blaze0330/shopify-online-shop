class ShoppingCart < ActiveRecord::Base
  # total must be present and positive
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # associations
  has_many :orders
  has_many :products, through: :orders

  # callback to set total before validating resource
  before_validation :set_total!

  # method to set total as total price of associated products
  def set_total!
    self.total = products.map(&:price).sum
  end
  
end
