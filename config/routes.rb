Rails.application.routes.draw do
  root to: 'homepages#home'
  resources :works
end
