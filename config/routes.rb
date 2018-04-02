Rails.application.routes.draw do
  root controller: 'homepage', action: 'index'
  resources :users

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
