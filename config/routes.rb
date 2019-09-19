Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'application#index'

  get '/auth/facebook/callback' => 'sessions#create'

  resources :users do
  	resources :reservations, only: [:show, :index]
  end

  resources :users
  resources :rooms
  resources :reservations

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
