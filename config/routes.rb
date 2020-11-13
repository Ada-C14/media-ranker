Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  resources :homepages, only: [:index] 
  resources :users, only: [:index, :show, :new, :create]

  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
end
