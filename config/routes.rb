Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'homepages#index'

  get '/homepages', to: 'homepages#index', as: 'homepages'
  get '/works', to: 'works#index', as: 'works'
  get '/works/new', to: 'works#new', as: 'new_work'
  post '/works', to: 'works#create'
  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  patch '/works/:id', to: 'works#update'
  get '/works/:id', to: 'works#show', as: 'work'
  delete '/works/:id', to: 'works#destroy', as: 'destroy_work'
  post 'works/:id', to: 'works#vote', as: 'vote_work'


  get "/login", to: "users#login_form", as: "login"
  get '/users', to: 'users#index', as: 'users'
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
