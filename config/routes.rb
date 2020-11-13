Rails.application.routes.draw do

  root to: 'homepages#home'

  resources :works

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'

  get 'users/current', to: 'users#current', as: 'current_user'

      resources :works do
    resources :votes, only: [:create, :destroy]
  end


end
