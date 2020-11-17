Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works do
    resources :votes, only: [:index, :create]
  end



  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  get '/users/:id', to: "users#show", as: "user"

  post '/works/:id/upvote', to: "votes#create", as: "upvote"
  get '/users', to: "users#index", as: "users"
end
