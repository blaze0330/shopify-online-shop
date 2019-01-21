require 'spec_helper'

describe Api::V1::ProductsController do

  # Test get single product (show)
  describe "GET #show" do
    before(:each) do
      @product = FactoryBot.create :product
      get :show, id: @product.id
    end

    it "returns the information about a product on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @product.title
    end

    it { should respond_with 200 }
  end

  # Test get multiple products (index) with argument to only return products with available inv
  describe "GET #index" do
    before(:each) do
      @product1 = FactoryBot.create :product, inventory_count: 0
      @product2 = FactoryBot.create :product, inventory_count: 50
      @product3 = FactoryBot.create :product, inventory_count: 0
      @product4 = FactoryBot.create :product, inventory_count: 99
      get :index, only_available_inventory: true
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response.length).to eq(2)
    end

    it { should respond_with 200 }
  end

  # Test get multiple products (index)
  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :product }
      get :index
    end

    it "returns 2 records from the database that have available inventory" do
      products_response = json_response
      expect(products_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  # Test create product (create)
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @product_attributes = FactoryBot.attributes_for :product
        post :create, { product: @product_attributes }, format: :json
      end

      it "renders the json representation for the product record just created" do
        product_response = json_response
        expect(product_response[:title]).to eql @product_attributes[:title]
      end

      it { should respond_with 201 }
    end

    #Test product creation failure
    context "when is not created" do
      before(:each) do
      	product = FactoryBot.create :product
        # invalid price (non numeric)
        @invalid_product_attributes = { title: "Monitor", price: "hello", inventory_count: "10" }
        post :create, { product: @invalid_product_attributes }, format: :json
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end
  
  # Test product update inventory count (update)
  describe "PUT/PATCH #update" do

    context "when is successfully purchased" do
      before(:each) do
        @product = FactoryBot.create :product, inventory_count: 10
        patch :update, { id: @product.id, purchase: true}, format: :json
      end

      # test product inventory count went down
      it "renders the json representation for the updated user" do
        product_response = json_response
        expect(product_response[:inventory_count]).to eql 9
      end


      it { should respond_with 200 }
    end

    # Test product purchase unsucessful because product out of inventory
    context "when is not updated" do
      before(:each) do
        @product = FactoryBot.create :product, inventory_count: 0
        patch :update, { id: @product.id, purchase: true}, format: :json
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be purchased" do
        product_response = json_response
        expect(product_response[:errors]).to include "Cannot purchase product with 0 inventory count"
      end

      it { should respond_with 422 }
    end
  end
  
  # Test product deletion
  describe "DELETE #destroy" do
    before(:each) do
      @product = FactoryBot.create :product
      delete :destroy, { id: @product.id }, format: :json
    end
    
    it { should respond_with 204 }
  end
end
