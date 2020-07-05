Rails.application.routes.draw do
  root 'videos#index'

  resources :videos
  get '/welcome/index'
end
