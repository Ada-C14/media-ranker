Rails.application.routes.draw do

  root to: 'works#top_works'

  resources :works do
    resources :votes, only: [:create]
  end

  get '/works/top_works', to: 'works#top_works', as: 'top_works'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: 'current_user'

  resources :users, only: [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
