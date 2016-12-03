Rails.application.routes.draw do
  resources :games, only: [:show, :create]
  root 'games#index'
end
