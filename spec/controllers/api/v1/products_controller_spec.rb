require 'spec_helper'

describe Api::V1::ProductsController do

  # Test get single product (show)
  describe "GET #show" do
    before(:each) do
      @product = FactoryBot.create :product
      get :show, id: @product.id
    end

    it "returns the information about a reporter on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @product.title
    end

    it { should respond_with 200 }
  end

  # Test get multiple products (index)
  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :product }
      get :index
    end

    it "returns 4 records from the database" do
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

  # Test product deletion
  describe "DELETE #destroy" do
    before(:each) do
      @product = FactoryBot.create :product
      delete :destroy, { id: @product.id }, format: :json
    end
    
    it { should respond_with 204 }
  end
end
