Rails.application.routes.draw do
  root controller: 'homepage', action: 'index'
  resources :users do
    resources :posts
  end

  resources :posts, only: [:index, :show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
