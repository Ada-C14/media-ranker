Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #RESTful routes
  root to:'homepages#index'

  resources :users
  resources :votes
  resources :works

  resources :works do
    resources :votes
  end

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"


# reference
  # get '/works/:id', to 'works#show'
end
