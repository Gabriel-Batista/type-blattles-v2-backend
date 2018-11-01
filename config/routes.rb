Rails.application.routes.draw do
  resources :cars
  resources :matches
  resources :users

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/matches/join', to: 'matches#join_game'

  mount ActionCable.server => '/cable'
end
