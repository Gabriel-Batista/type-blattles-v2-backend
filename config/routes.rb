Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/matches/join', to: 'matches#join_game'
  get '/matches/join/practice', to: 'matches#join_practice'

  resources :cars
  resources :matches
  resources :users

  mount ActionCable.server => '/cable'
end
