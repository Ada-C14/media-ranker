Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
  get '/users/current', to: 'users#current', as: 'current_user'

  # get '/works/:count', to: 'works#index', as: :works_count
end
