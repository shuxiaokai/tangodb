Rails.application.routes.draw do
  devise_for :users
  root "videos#index"

  get "search", to: "videos#search"

  resources :videos, only: :index do
    collection do
      get :leader_id
      get :follower_id
      get :song_id
    end  
  end
end