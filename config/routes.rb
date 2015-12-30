require 'api_constraints'
require 'subdomain'

Rails.application.routes.draw do
      use_doorkeeper
      devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }

      # API definition
      # namespace :api, defaults: { format: :json }, constraints: { subdomain: /.+/ }, path:  '/' do
      namespace :api, defaults: { format: :json }, path:  '/' do
          scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
              post 'user_sessions',    to: 'user_sessions#logout_user',    as: 'logout_user'
              post 'add_interests',    to: 'profiles#add_interests',       as: 'add_interests'
              post 'remove_interests', to: 'profiles#remove_interests',    as: 'remove_interests'

              put 'update_profile', to: 'profiles#update', as: 'update_profile'

              get 'me',         to: 'profiles#me',    as: 'me'
              get 'all_posts',  to: 'posts#all',      as: 'all_posts'
              get 'user_posts', to: 'profiles#posts',  as: 'user_posts'

              resources :comments, only: [:index, :create, :update, :destroy]

              resources :relationships, only: [:create, :destroy] do
                member do
                  get :following, :followers
                end
              end
              resources :profiles,      except: [:new, :edit]
              resources :genders,       except: [:new, :edit]
              # resources :photos,        except: [:new, :edit]
              resources :tags, except: [:new, :edit] do
                collection do
                  get :list
                end
              end

              resources :photos do
                  collection do
                    get :my_photos
                  end
              end

              resources :articles do
                  resources :posts
                  collection do
                    get :my_articles
                  end
              end

              resources :quotes do
                  resources :posts
                  collection do
                    get :my_quotes
                  end
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
