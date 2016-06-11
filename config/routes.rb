Rails.application.routes.draw do
  root "home#index"
  get "/about" => "home#about"

  resources :posts
  get "/posts/search" => "posts#search"
  post "/posts/search" => "posts#search", as: :search

  get "/posts/page/:page" => "posts#index", as: :page

  resources :comments
end
