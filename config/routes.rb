require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do
  use_doorkeeper
  post 'login_oauth', to: 'landing#login', as: 'login_oauth'
  root 'landing#index'

  mount ApiTaster::Engine => "/api_taster" # if Rails.env.development?
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
    end
  end
end
