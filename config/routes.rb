Rails.application.routes.draw do
  resources :carts do
    get 'check', on: :collection
  end
  resources :users
  resources :reviews
  root 'home#index'
  resources :transactions
  resources :books
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'

  get 'check_cart', to: 'carts#check', as: 'check'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
