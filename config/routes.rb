Rails.application.routes.draw do

  # login stuff will go here

  root to: "homepages#index"

  resources :homepages, only: [:index]
  resources :works

  # resources :votes  << nested in works?

  resources :users, except: [:edit, :update, :destroy]
end
