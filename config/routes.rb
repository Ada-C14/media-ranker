Rails.application.routes.draw do
  # verb "path", to: "controller#action"
  get "/users/current", to: "users#current", as: "current_user"
  resources :works
  resources :users
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  #allow user to visit this page of they logged in
  root to:'works#top'
  post "/users/vote", to: "users#vote", as: "vote"
  # get 'users/login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  # resources :votes
end
