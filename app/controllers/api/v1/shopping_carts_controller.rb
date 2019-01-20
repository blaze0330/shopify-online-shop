class Api::V1::ShoppingCartsController < ApplicationController
  respond_to :json
  
  # Access single shopping cart
  def show
    respond_with ShoppingCart.find(params[:id])
  end
  
  # Access all shopping carts
  def index
    respond_with ShoppingCart.all
  end

  # Create a shopping cart
  def create
    shopping_cart = ShoppingCart.new(shopping_cart_params)

    if shopping_cart.save
      render json: shopping_cart, status: 201, location: [:api, shopping_cart]
    else
      render json: { errors: shopping_cart.errors }, status: 422
    end
  end

  private

    def shopping_cart_params
      params.require(:shopping_cart).permit(:product_ids => [])
    end
end
