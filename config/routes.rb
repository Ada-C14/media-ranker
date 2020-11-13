Rails.application.routes.draw do


  resources :works
  resources :homepages, only: [:index]
  resources :users, only: [:index, :show]

  root to: 'homepages#index'

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"
end
