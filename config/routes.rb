Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "works#top"
  resources :works
  resources :users, only:[:index, :show, :new, :create]

  get 'works/top', to: 'works#top', as: 'top_works'

end
