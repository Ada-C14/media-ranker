Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#home'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  delete '/logout', to: 'users#logout', as: 'logout'

  get '/signup', to: 'users#new'

  get "/users/current", to: "users#current", as: "current_user"

  resources :works do
    resources :votes, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show]


end
