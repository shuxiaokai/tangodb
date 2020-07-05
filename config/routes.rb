Rails.application.routes.draw do
  get '/welcome/index'
  root 'videos#index'

  resources :videos
end
