Rails.application.routes.draw do
  resources :works
  root to: 'pages#index'

  # User routes
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
