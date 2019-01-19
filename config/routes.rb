require 'api_constraints'

OnlineMarketplace::Application.routes.draw do

  # API
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    end
  end
end