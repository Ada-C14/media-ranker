Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :users, only: [:show, :index]
  get '/login', to: 'users#login_form', as: 'login'

  resources :works

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
