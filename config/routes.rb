Rails.application.routes.draw do
  # verb "path", to: "controller#action"
  resources :works
  resources :users
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  #allow user to visit this page of they logged in
  get "/users/current", to: "users#current", as: "current_user"
  root to:'works#top'

  # get 'users/login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  # resources :votes
end
