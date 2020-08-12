Rails.application.routes.draw do
  devise_for :users
  
  root "videos#index"

  get "search", to: "videos#search"


  resources :videos

  post 'videos_filter', action: :index, controller: 'videos_filter'
  
end