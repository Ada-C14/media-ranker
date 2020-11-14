Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :works   #Nested Routes --
  #   resources :votes, only: [:create]
  # end

  root :to => "works#homepage" #homepage custom route

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  #Custom route for upvotes -- votes controller who handles upvoting
  post 'works/:work_id/vote', to: 'votes#upvote', as: 'upvote'

  resources :users, only: [:index, :show]
end
