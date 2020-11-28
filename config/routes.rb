Rails.application.routes.draw do

  #Omniauth login route
  get '/auth/github', as: 'github_login'

  #Omniauth call back route
  get '/auth/:provider/callback', to: 'users#create', as: 'omniauth_callback'

  root to: 'homepages#home'

  resources :works

  # get '/login', to: 'users#login_form', as: 'login'
  # post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: :current_user
  resources :users, only: [:index, :show]

  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'
end
