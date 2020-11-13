Rails.application.routes.draw do

  root to: 'works#top_works'

  resources :votes, only: [:index, :new]

  resources :works
  get '/works/top_works', to: 'works#top_works', as: 'top_works'

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :users, only: [:index, :show] do
    resources :votes, only: [:index, :new]
  end
  # do
  #   resources :votes, only: [:index, :new]
  # end

  # get 'votes/index'
  # get 'votes/show'
  # get 'votes/new'
  # get 'votes/create'
  # get 'votes/edit'
  # get 'votes/update'
  # get 'votes/destroy'
  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # get 'works/index'
  # get 'works/show'
  # get 'works/new'
  # get 'works/create'
  # get 'works/edit'
  # get 'works/update'
  # get 'works/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
