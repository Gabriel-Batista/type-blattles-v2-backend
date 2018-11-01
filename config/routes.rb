Rails.application.routes.draw do
  resources :cars
  resources :matches
  resources :users

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/join', to: 'matches#join'
end
