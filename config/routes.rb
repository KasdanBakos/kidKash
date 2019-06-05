Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search
  get 'home/dashboard', to: 'home#dashboard', as: :dashboard
  root 'home#index'

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  # Routes for main resources
  resources :camps
  resources :instructors
  resources :locations
  resources :curriculums
  resources :families
  resources :students

  # Routes for managing camp instructors
  get 'camps/:id/instructors', to: 'camps#instructors', as: :camp_instructors
  post 'camps/:id/instructors', to: 'camp_instructors#create', as: :create_instructor
  delete 'camps/:id/instructors/:instructor_id', to: 'camp_instructors#destroy', as: :remove_instructor


  # Routes for cart
  get 'cart' => 'carts#index', :as => :show_cart
  post'cart/add' => 'carts#add_to_cart', :as => :add_to_cart
  delete 'cart/remove_from_cart/:camp_id/:student_id' => 'carts#remove_from_cart', :as => :remove_from_cart
  get 'cart/empty_cart' => 'carts#empty_cart', as: :empty_cart
  get 'checkout' => 'registrations#new', as: :checkout
  post 'final_checkout' => 'carts#checkout', as: :final_checkout

  #Routes for managing a camp's students
  get 'camps/:id/students', to: 'camps#students', as: :camp_students
  post 'camps/:id/students', to: 'registrations#create', as: :new_registration
  delete 'camps/:id/students/:student_id', to: 'registrations#destroy', as: :remove_registration

end








