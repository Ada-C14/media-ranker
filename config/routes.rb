Rails.application.routes.draw do
  root to: 'homepages#index'
  get 'homepages/index'

  resources :works
end
