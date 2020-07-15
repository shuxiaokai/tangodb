Rails.application.routes.draw do
  root 'videos#index' 

  resources :videos, only: :index do
    collection do
      get :leader_id
      get :follower_id
    end
  end
end