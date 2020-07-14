Rails.application.routes.draw do
  root 'videos#index' 

  resources :videos do
    collection do
      get :leader_id
      get :follower_id
    end
  end
end