Rails.application.routes.draw do
  # Work routes
  resources :works

  # User routes
  resources :users, only: %i[index show new create]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  patch "/works/:id/upvote", to: "works#upvote", as: "upvote"
 
  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# Custom route for voting-check  
  # post 'works/vote', to: 'works#upvote', as: 'upvote' 

  # # Nested Routes Method-need votes controller-no view 
  #  resources :works do
  #   resources :votes, only: [:create, :destroy]
  # end
