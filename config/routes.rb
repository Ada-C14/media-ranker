Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "users/id", to: "users#show", as: "user_path"

  root to: 'homepages#index', as: 'homepage'

  resources :works do
    post '/upvote', to: "votes#create"
  end
  resources :homepages
  resources :users, only: [:index, :show, :new, :create]





end


