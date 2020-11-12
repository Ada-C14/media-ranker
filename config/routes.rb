Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :works

  # get '/works/:count', to: 'works#index', as: :works_count
end
