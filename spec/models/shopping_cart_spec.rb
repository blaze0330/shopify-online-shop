require 'spec_helper'

describe ShoppingCart do
  # Create shopping cart using factory
  let(:shopping_cart) { FactoryBot.build :shopping_cart }
  subject { shopping_cart }

  # Test shopping cart has total and that total is positive
  it { should respond_to(:total) }

  # Test association
  it { should have_many(:orders) }
  it { should have_many(:products).through(:orders) }

  # Test setting total depending on associated product price
  describe '#set_total!' do
    before(:each) do
      product_1 = FactoryBot.create :product, price: 100
      product_2 = FactoryBot.create :product, price: 85

      @shopping_cart = FactoryBot.build :shopping_cart, product_ids: [product_1.id, product_2.id]
    end
    it "returns the total amount to pay for the products" do
      expect{@shopping_cart.set_total!}.to change{@shopping_cart.total}.from(0).to(185)
    end
  end
end
