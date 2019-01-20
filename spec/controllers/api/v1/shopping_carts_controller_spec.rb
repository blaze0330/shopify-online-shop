require 'spec_helper'

describe Api::V1::ShoppingCartsController do

  # show single shopping cart
  describe "GET #show" do
    before(:each) do
      @shopping_cart = FactoryBot.create :shopping_cart
      get :show, id: @shopping_cart.id
    end

    it "returns the information about a shopping cart on a hash" do
      shopping_cart_response = json_response
      expect(shopping_cart_response[:id]).to eql @shopping_cart.id
    end

    it { should respond_with 200 }
  end

  # show all shopping cart
  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :shopping_cart }
      get :index
    end

    it "returns 4 shopping carts records from the database" do
      shopping_carts_response = json_response
      expect(shopping_carts_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  # create a shopping cart
  describe "POST #create" do
    before(:each) do
      product_1 = FactoryBot.create :product
      product_2 = FactoryBot.create :product
      shopping_cart_params = { product_ids: [product_1.id, product_2.id] }
      post :create, shopping_cart: shopping_cart_params
    end

    it "returns a shopping cart record" do
      shopping_cart_response = json_response
      expect(shopping_cart_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end
  
end
