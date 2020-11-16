Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :works
  patch "works/:id/upvote", to: "works#upvote", as: "upvote"
  get "/users/current", to: "users#current", as: "current_user"
  resources :users, only: [:index, :show, :new, :create]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
