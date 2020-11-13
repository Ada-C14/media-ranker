Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'works#homepage'
  resources :works
  get 'works/homepage', to: 'works#homepage', as: 'homepage'
end
