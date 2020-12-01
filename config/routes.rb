Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :works
  resources :homepage
  resources :users

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  get "/users/current", to: "users#current", as: "current_user"

  post "/works/:id/vote", to: "works#vote", as: "vote"
end
