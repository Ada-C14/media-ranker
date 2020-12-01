Rails.application.routes.draw do
  get 'users/login_form'
  get '/login', to: "users#login_form", as:'login'
  post '/login', to: "users#login"
  post '/logout', to: "users#logout", as: 'logout'

  get '/users/current', to 'users#current', as: 'current_user'

  # Routes for all works
  get '/homepages', to: 'homepages#index'
  get '/works', to: 'works#index', as: 'works'
  get 'works/new', to: 'works#new', as: 'new_work'
  post '/works', to: 'works#create'
  get '/users', to: 'users#index', as: 'users'
  get 'users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'

  # Routes for using a specific task page
  get '/works/:id', to: 'works#show', as: 'work'
  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  patch '/works/:id', to: 'works#update'
  get '/works/:id/confirm_delete', to: 'works#confirm', as: 'confirm_work'
  delete '/works/:id', to: 'works#delete', as: 'delete_work'
  patch '/works/:id/complete', to: 'works#complete', as: 'complete_work'

  root to: 'homepages#index'
end