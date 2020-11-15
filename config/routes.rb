Rails.application.routes.draw do
  get 'votes/index'
  get 'votes/show'
  get 'votes/create'
  get 'votes/edit'
  get 'votes/new'
  get 'votes/destroy'
  get 'votes/update'
  # get 'homepages/index'
  root to: "homepages#index"

  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'

  resources :works
  # resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

