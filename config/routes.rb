Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get 'home_authenticated', to: 'home#index_authenticated'
  get 'home_unauthenticated', to: 'home#index_unauthenticated'

  post 'user/login', to: 'users#login'
  post 'user/forgot', to: 'users#forgot_password'
  get 'user/logout', to: 'users#logout'

  namespace :components do
    namespace :form do
      get 'register', to: 'register#index'
      get 'login', to: 'login#index'
      get 'forgot', to: 'forgot#index'
      get 'update', to: 'update#index'
    end
  end
end
