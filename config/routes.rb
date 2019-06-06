Rails.application.routes.draw do
  get 'parent_view/index'

  # get 'sessions/new'

  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy', as: :logout
  root 'goals#index'

  resources :goals
  resources :transactions
  resources :parent_children
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
