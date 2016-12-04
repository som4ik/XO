Rails.application.routes.draw do
  resources :games, only: [:show, :create] do
    collection do
      get  :join
      post :click
    end
  end
  resources :players, only: [:create] do
    collection do
      get :login
    end
  end
  root 'games#index'
end
