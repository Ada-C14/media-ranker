Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  resources :homepages

  resources :votes
  resources :works do
    resources :votes, only: [:index, :new]
  end
  resources :users do
    resources :votes, only: [:index]
  end

end
