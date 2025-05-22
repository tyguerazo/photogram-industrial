Rails.application.routes.draw do
  root "users#feed"

  devise_for :users
  
  resources :comments
  resources :follow_requests do
    member do
      patch :accept
      patch :reject
    end
  end
  resources :likes
  resources :photos

  # Like/Unlike routes
  post "/likes" => "likes#create"
  delete "/likes/:id" => "likes#destroy", as: :unlike

  # User profile routes
  get ":username" => "users#show", as: :user
  get ":username/liked" => "users#liked", as: :liked
  get ":username/feed" => "users#feed", as: :feed
  get ":username/discover" => "users#discover", as: :discover

  get "up" => "rails/health#show", as: :rails_health_check
end
