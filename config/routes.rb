Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :works

  root to: "works#main"

  # get '/users/login', to: "users#login_form", as "login"
  # get '/users/login', to: "users#login", as: :login_user
  # post 'users/login', to: "users#login"
  # post 'users/logout', to: "users#logout", as: "logout"
end
