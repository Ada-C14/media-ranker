Rails.application.routes.draw do
  get 'users/index' # will probably want to change this since their site uses /users and users/:id
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  # resources :works # probably don't need this anymore?
  resources :users, only: [:index, :show]
  resources :works do
    member do
      post 'upvote'
    end
  end

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
