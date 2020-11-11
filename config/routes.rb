Rails.application.routes.draw do
  resources :works
  root 'pages#index'
  # get 'votes/index'
  # get 'users/index'
  # get 'works/index'
  # get 'pages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
