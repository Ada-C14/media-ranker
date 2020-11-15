Rails.application.routes.draw do
  root to: 'homepages#index'
  get 'homepages/index'

  resources :works
  post "/works/:id/upvote", to: "works#upvote", as: "upvote"

  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  # /works/:id(.:format)                                                                     works#update
end
