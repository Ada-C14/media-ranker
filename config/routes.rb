Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/login_form'
  get 'users/login'
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: 'current_user'

  get '/works/top', to: 'works#top'


  resources :works
  resources :users
  resources :votes

  root to: 'homepages#index'
end
