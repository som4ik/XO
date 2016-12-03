Rails.application.routes.draw do
  resources :games, only: [:show, :create]
  resources :players, only: [:create] do
    collection do
      get :login
    end
  end
  root 'games#index'
end
