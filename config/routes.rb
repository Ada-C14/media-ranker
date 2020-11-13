Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "user#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
