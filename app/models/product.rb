class Product < ActiveRecord::Base
  # title price, inventory count must be present
  validates :title, presence: true
  # price and inventory count must be positive
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  # implement filter for available inventory only
  scope :available_inventory, -> {
    where("inventory_count > 0") 
  }

  # search by specified search hash (eg: return products with available inventory)
  def self.search(params = {})
    products = params[:product_ids].present? ? Product.find(params[:product_ids]) : Product.all
    products = products.available_inventory if params[:only_available_inventory]
    
    products
  end

  # method that decrements inventory count by 1
  def decrement_product_inventory_count!
    self.decrement!(:inventory_count, 1)
  end

end
