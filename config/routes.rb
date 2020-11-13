Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works do
    post '/upvote', to: 'votes#upvote', as: 'upvote'
  end

  resources :users, only: [:index, :show]
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/login', to: 'users#logout', as: 'logout'

  get "users/current", to: "users#current", as: "current_user"

  # resources :votes, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
