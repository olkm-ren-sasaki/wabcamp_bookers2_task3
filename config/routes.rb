Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#top"
  get "/home/about", to: "home#about", as: "home_about"
  resources :books, only: [:create, :index, :show, :edit, :destroy, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end
