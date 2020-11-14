Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  resources :homepages, only: [:index] 

  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
end
