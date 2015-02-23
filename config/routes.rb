require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do

  mount ApiTaster::Engine => "/api_taster" # if Rails.env.development?
  
  use_doorkeeper
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: /.+/ }, path:  '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	resources :user_sessions, only: [:destroy]
    end
  end
end
