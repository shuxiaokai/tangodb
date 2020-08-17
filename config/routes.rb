Rails.application.routes.draw do
  devise_for :users
  
  root "videos#index"

  get "search", to: "videos#search"
  get "permalink#demo", to: "demo#show"

  resources :videos
  resources :permalink

  post 'videos_filter', action: :index, controller: 'videos_filter'
  
end