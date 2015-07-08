require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do
      use_doorkeeper
      devise_for :users

      # API definition
      namespace :api, defaults: { format: :json }, constraints: { subdomain: /.+/ }, path:  '/' do
          scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
              post 'user_sessions', to: 'user_sessions#logout_user', as: 'logout_user'

              get 'all_posts', to: 'posts#all', as: 'all_posts'

              resources :profiles, only: [:show, :create, :update]
              resources :comments, only: [:create, :update, :destroy]

              resources :photos,   except: [:new, :edit]
              resources :pages,    except: [:new, :edit]

              resources :articles do
                  resources :posts
              end

              resources :quotes do
                  resources :posts
              end
          end
      end

      match '*path', :to => 'errors#url_not_identified', via: [:head, :get, :post, :patch, :put, :delete, :options]
end
