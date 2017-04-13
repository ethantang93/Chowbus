Rails.application.routes.draw do
  root 'chowbus#index'
  post 'login_auth' => 'chowbus#login_auth'

  get 'admin' => 'chowbus#admin'
  post '/update_schedule/:rest_id' => 'chowbus#update_schedule'
  get '/allmeal' => 'chowbus#allmeal'
  get 'restaurant' => 'chowbus#restaurant'
  get '/delete_meal/:id' => 'chowbus#delete_meal'
  get '/logout' => 'chowbus#logout'
  #api
  namespace :api, :defaults => {:format => :json } do
    # resources :meals, only: [:find_meal]
    get '/meals/:date' => 'api#find_meal'
  end
end
