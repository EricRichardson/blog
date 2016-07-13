Rails.application.routes.draw do

  resources :clients
  root "home#index"
  get "/about" => "home#about"

  resources :posts do
    resources :comments
    resources :favorites, only: [:create, :destroy]
    resources :ratings, only: [:create, :update]
  end
  get "/posts/search" => "posts#search"
  post "/posts/search" => "posts#search", as: :search

  get "/posts/page/:page" => "posts#index", as: :page

  resources :users, only: [:new, :create, :edit, :update]

  get '/changepassword' => 'users#change_password', as: :change_password
  patch '/changepassword' => 'users#update_password'

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
