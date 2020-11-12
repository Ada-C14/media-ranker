Rails.application.routes.draw do

  resources :works
  resources :homepages, only: [:index]
  root to: 'homepages#index'

end
