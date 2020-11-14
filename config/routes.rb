Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #RESTful routes
  root to:'homepages#index'

  resources :users
  resources :works
  # resources :votes

end
