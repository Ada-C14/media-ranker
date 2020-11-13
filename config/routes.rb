Rails.application.routes.draw do
  get 'users/login_form'
  get 'users/login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # user
  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  # work
  resources :works

  # root
  root to: 'pages#index'
end
