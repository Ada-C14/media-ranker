Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#homepage'

  resources :works do
    resources :votes
  end

  get "/works", to: "works#homepage"

  resources :users do
    resources :votes
  end

  resources :votes


end
