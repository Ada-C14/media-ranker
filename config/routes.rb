Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/login_form'
  get 'users/login'
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  get '/works/top', to: 'works#top'

  resources :works do
    member do
      post :upvote
    end
  end

  resources :works
  resources :users, only: [:index, :show]

  root to: 'works#top'
end