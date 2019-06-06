Rails.application.routes.draw do
  get 'child_view/index'
  get 'about/index'

  get 'parent_view/index'

  # get 'sessions/new'

  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy', as: :logout
  root 'landing#index'

  get '/dashboard', to: 'home#dashboard', as: :dashboard

  resources :goals
  resources :transactions
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
