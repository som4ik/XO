Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  resources :games, only: [:show, :create] do
    collection do
      get  :join
      post :click
    end
  end
  resources :players, only: [:create] do
    post 'logout' => :destroy
    collection do
      get :login
    end
  end
  root 'games#index'
end
