require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do
  use_doorkeeper 
  devise_for :users
  
  

  # API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: /.+/ }, path:  '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	delete 'user_sessions', to: 'user_sessions#destroy', as: 'logout_user'

      resources :profiles, only: [:show, :create, :update]
      resources :articles do
        resources :posts
      end
      resources :quotes do
        resources :posts
      end

      get 'all_posts', to: 'posts#all', as: 'all_posts'
    end
  end

  match '*path', :to => 'errors#url_not_identified', via: [:head, :get, :post, :patch, :put, :delete, :options]
end
