Rails.application.routes.draw do
 
  devise_for :users
  
  root "videos#index"

  post 'savenew', to: 'users#savenew'

  resources :videos do
    collection do
    get "search", constraints: lambda { |request| request.xhr? }
    end
  end
  
  namespace :admin do
    resources :users
  end
  
end
