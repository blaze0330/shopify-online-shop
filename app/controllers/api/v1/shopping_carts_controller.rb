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
end
