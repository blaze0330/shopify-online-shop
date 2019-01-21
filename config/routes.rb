require 'api_constraints'

OnlineMarketplace::Application.routes.draw do

  # API
  namespace :api, defaults: { format: :json }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	# Resources
    	resources :products, :only => [:show, :index, :create, :destroy, :update]
    	# resources :shopping_carts, :only => [:show, :index, :create, :add_products]
    end
  end
end