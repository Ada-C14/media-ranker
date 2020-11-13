Rails.application.routes.draw do
  # user
  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # show profile info about current user
  get "/users/current", to: "users#current", as: "current_user"

  # work
  resources :works

  # root
  root to: 'pages#index'
end
