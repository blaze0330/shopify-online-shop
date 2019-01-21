class Api::V1::ProductsController < ApplicationController
  respond_to :json
  
  # Access single product
  def show
    respond_with Product.find(params[:id])
  end

  # Access all products
  def index
    respond_with Product.search(params)
  end

  # Create product
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 201, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  # Destroy product
  def destroy
    product = Product.find(params[:id])
    product.destroy
    head 204
  end

  # Purchase product
  def update
    product = Product.find(params[:id])
    if params[:purchase]
      if product.inventory_count > 0
        product.decrement_product_inventory_count!
        render json: product, status: 200, location: [:api, product]
      else
        render json: { errors: "Cannot purchase product with 0 inventory count" }, status: 422
      end
    else
      render json: { errors: "Can only use the update method to purchase product" }, status: 422
    end
  end
  
  private

	def product_params
      params.require(:product).permit(:title, :price, :inventory_count)
    end
end
