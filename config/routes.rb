Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  resources :homepages

  resources :votes
  resources :works do
    resources :votes, only: [:index, :new]
  end
  resources :users do
    resources :votes, only: [:index] # users/2/votes

  end

  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :works do
    member do
      post 'upvote'
    end
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"
end
