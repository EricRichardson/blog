Rails.application.routes.draw do
  root "home#index"
  get "/about" => "home#about"

  resources :posts do
    resources :comments
  end
  get "/posts/search" => "posts#search"
  post "/posts/search" => "posts#search", as: :search

  get "/posts/page/:page" => "posts#index", as: :page

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
