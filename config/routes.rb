Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.
  root 'homepages#index'

  get '/works/new', to: 'works#new', as: 'new_work'
  get '/works/:id', to: 'works#show', as: "work"
  get '/works', to: 'works#index', as: 'works_path'
  get  '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  post '/works', to: 'works#create'
  post '/votes', to: 'votes#create'

  get '/users', to: 'users#index', as: 'users_path'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  # session
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

end
