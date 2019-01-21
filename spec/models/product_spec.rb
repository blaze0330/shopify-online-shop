require 'spec_helper'

describe Product do
  # Create product using factory
  let(:product) { FactoryBot.build :product }
  subject { product }

  # Test product creation has title, price, inventory count
  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:inventory_count) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  # Test price and inventory count are positive integers or decimals
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :inventory_count }
  it { should validate_numericality_of(:inventory_count).is_greater_than_or_equal_to(0) }

  # Test to filter products that have non zero inventory
  describe ".available_inventory" do
    before(:each) do
      @product1 = FactoryBot.create :product, inventory_count: 0
      @product2 = FactoryBot.create :product, inventory_count: 50
      @product3 = FactoryBot.create :product, inventory_count: 0
      @product4 = FactoryBot.create :product, inventory_count: 99
    end

    it "returns the products which have available inventory" do
      expect(Product.available_inventory.sort).to match_array([@product2, @product4])
    end
  end

  # Test to search products with specific filters (eg: non zero inventory)
  describe ".search" do
    before(:each) do
      @product1 = FactoryBot.create :product, inventory_count: 0
      @product2 = FactoryBot.create :product, inventory_count: 50
      @product3 = FactoryBot.create :product, inventory_count: 0
      @product4 = FactoryBot.create :product, inventory_count: 99
    end

    context "when only available inventory is set" do
      it "returns all products with available inventory" do
        search_hash = { only_available_inventory: true }
        expect(Product.search(search_hash)).to match_array([@product2, @product4])
      end
    end

    context "when an empty hash is sent" do
      it "returns all the products" do
        expect(Product.search({})).to match_array([@product1, @product2, @product3, @product4])
      end
    end

    context "when product_ids is present" do
      it "returns the product from the ids" do
        search_hash = { product_ids: [@product1.id, @product2.id]}
        expect(Product.search(search_hash)).to match_array([@product1, @product2])
      end
    end
  end

  # Test decreasing product inventory count
  describe "#decrement_product_inventory_count!" do
    before(:each) do
      @product1 = FactoryBot.create :product, inventory_count: 50
    end
    it "decreases the product inventory count by 1" do
      expect{@product1.decrement_product_inventory_count!}.to change{@product1.inventory_count}.by(-1)
    end
  end

end
