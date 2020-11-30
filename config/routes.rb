Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#homepage'

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"

  get "/users/:id", to: "users#show", as: "user"
  get "/users", to: "users#index"

  post "/users/upvote/:id", to: "users#upvote", as: "upvote"

  resources :works
end
