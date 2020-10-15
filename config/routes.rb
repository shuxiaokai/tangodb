Rails.application.routes.draw do
 
  devise_for :users
  
  root "videos#index"

  post 'savenew', to: 'users#savenew'

  post 'videos_filter', action: :index, controller: 'videos_filter'

  resources :videos, only: %i[index]

  namespace :admin do
    resources :users
  end
  
end
