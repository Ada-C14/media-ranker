Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # root 'works#home'
  #
  # resources :works do
  #   resources :votes, only: [:create, :destroy]
  # end
  # resources :users, only: [:index, :show]
  #
  # get 'sessions/login', to: 'sessions#new'
  # post 'sessions/login', to: 'sessions#login', as: 'login'
  # delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  root 'homepage#index'

  get '/works/new', to: 'works#new', as: 'new_work'
  get '/works/:id', to: 'works#show', as: "work"
  get '/works', to: 'works#index', as: 'works'
  get  '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  # put '/works/:id', to: 'works#update'
  patch '/works/:id', to: 'works#update'
  post '/works', to: 'works#create'
  delete '/works/:id', to: 'works#destroy', as: 'destroy_work'

  post '/votes', to: 'votes#create'

  get '/users', to: 'users#index', as: 'users'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  # session
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

end
