Rails.application.routes.draw do

  resources :works do
    member do
      post :upvote
    end
  end

  resources :homepages, only: [:index]
  resources :users, only: [:index, :show]

  root to: 'homepages#index'

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
