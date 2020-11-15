Rails.application.routes.draw do
  resources :users
  resources :works

  # Work routes
  # custom route for voting-check for routes order 
  post 'works/vote', to: 'works#upvote', as: 'upvote' 

  # # Nested Routes Method-need votes controller-no view 
  #  resources :works do
  #   resources :votes, only: [:create, :destroy]
  # end

  # User routes
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
 
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
