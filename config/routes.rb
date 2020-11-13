Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'homepages#index'

  get '/homepages', to: 'homepages#index', as: 'homepages'
  get '/works', to: 'works#index', as: 'works'
  get '/works/new', to: 'works#new', as: 'new_work'
  post '/works', to: 'works#create'
  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  patch '/works/:id', to: 'works#update'
  get '/works/:id', to: 'works#show', as: 'work'
  delete '/works/:id', to: 'works#destroy', as: 'destroy_work'
end
