Rails.application.routes.draw do
  mount ApiTaster::Engine => "/api_taster" # if Rails.env.development?
  
  use_doorkeeper
  devise_for :users
end
