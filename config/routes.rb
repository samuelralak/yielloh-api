require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do
      use_doorkeeper
      devise_for :users, controllers: {registrations: 'registrations'}

      # API definition
      namespace :api, defaults: { format: :json }, constraints: { subdomain: /.+/ }, path:  '/' do
      # namespace :api, defaults: { format: :json }, path:  '/' do
          scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
              post 'user_sessions',    to: 'user_sessions#logout_user',    as: 'logout_user'
              post 'add_interests',    to: 'profiles#add_interests',       as: 'add_interests'
              post 'remove_interests', to: 'profiles#remove_interests',    as: 'remove_interests'

              put 'update_profile', to: 'profiles#update', as: 'update_profile'

              get 'me',        to: 'profiles#me', as: 'me'
              get 'all_posts', to: 'posts#all',  as: 'all_posts'

              resources :comments, only: [:create, :update, :destroy]

              resources :relationships, only: [:create, :destroy] do
                member do
                  get :following, :followers
                end
              end
              resources :profiles,      except: [:new, :edit]
              resources :genders,       except: [:new, :edit]
              resources :photos,        except: [:new, :edit]
              resources :tags,          except: [:new, :edit]

              resources :articles do
                  resources :posts
              end

              resources :quotes do
                  resources :posts
              end

              resources :pages, except: [:new, :edit] do
                collection do
                  get :my_pages
                end
              end
          end
      end

      match '*path', :to => 'errors#url_not_identified', via: [:head, :get, :post, :patch, :put, :delete, :options]
end
