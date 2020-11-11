Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :works
  root to:'works#top'
  # resources :users
  # resources :votes
end
