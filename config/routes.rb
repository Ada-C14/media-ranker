Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  resources :works
end
