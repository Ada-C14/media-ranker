Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#index'
  resources :works
  # get '/works', to: 'works#index', as: 'works'
  # get '/works/new', to: 'works#new', as: 'new_work'
  # post '/works', to: 'works#create'
  #
  # get '/works/:id', to: 'works#show', as: 'work'
  # patch '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  # get '/works/:id', to: 'works#update'
  # delete '/works/:id', to: 'works#destroy'

end
