Rails.application.routes.draw do
 
  devise_for :users
  
  root "videos#index"

  post 'savenew', to: 'users#savenew'

  post 'videos', action: :index, controller: 'videos'

  resources :videos, only: %i[index]

  namespace :admin do
    resources :users
  end
  
end
