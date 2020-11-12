Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#index'
  get '/works', to: 'works#index', as: 'works'
  get '/works/:id', to: 'works#show', as: 'work'

end
