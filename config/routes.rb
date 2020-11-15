Rails.application.routes.draw do
  # get 'votes/index'
  # get 'votes/show'
  # get 'votes/create'
  # get 'votes/edit'
  # get 'votes/new'
  # get 'votes/destroy'
  # get 'votes/update'

  resources :votes

  # get 'homepages/index'
  root to: "homepages#index"

  # with no votes controller
  # post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'

  # with a votes controller; and with the original works controller
  resources :works do
    resources :votes, only: [:create, :destroy]
  end

  # resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

