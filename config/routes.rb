Rails.application.routes.draw do

  root to: 'works#homepage'

  get "/users/current", to: "users#current", as: "current_user"
  post '/works/:work_id/upvote', to: 'votes#upvote', as: 'upvote'

  resources :users, only: [:show, :index]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  resources :works

end
