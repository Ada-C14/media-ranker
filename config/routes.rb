Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#homepage'
  resources :works do
    resources :votes, only: [:create]
  end
  get '/works/homepage', to: 'works#homepage', as: 'homepage'

  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show" , as: "user"
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  post "/works/:id/vote", to: "votes#create", as: "vote"
end
