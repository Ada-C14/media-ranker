Rails.application.routes.draw do

  root to: 'works#index'

  resources :votes

  resources :users do
    resources :votes
  end

  resources :works do
    resources :votes
  end
  # get 'votes/index'
  # get 'votes/show'
  # get 'votes/new'
  # get 'votes/create'
  # get 'votes/edit'
  # get 'votes/update'
  # get 'votes/destroy'
  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # get 'works/index'
  # get 'works/show'
  # get 'works/new'
  # get 'works/create'
  # get 'works/edit'
  # get 'works/update'
  # get 'works/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
