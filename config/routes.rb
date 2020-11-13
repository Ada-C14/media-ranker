Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :users
  resources :works

  resources :works do
    resources :votes, only: [:create]
  end


end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
