Rails.application.routes.draw do
  get 'users/login_form'
  get 'users/login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :works
  resources :homepage
end
