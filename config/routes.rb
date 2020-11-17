Rails.application.routes.draw do

  # login stuff will go here

  root to: "homepages#index"

  resources :homepages, only: [:index]
  resources :works do
    resources :votes, only: [:create] # destroy?
  end

  resources :users, except: [:edit, :update, :destroy]
end
