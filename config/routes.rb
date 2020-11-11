Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works do
    post '/upvote', to: 'votes#upvote', as: 'upvote'
  end

  resources :users, only: [:index, :new, :create, :show]

  # resources :votes, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
