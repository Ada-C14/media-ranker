Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :works

  root :to => 'works#homepage' #custome route for homepage
  resources :users, only:[:index, :show] #nested route
end
