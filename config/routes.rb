Rails.application.routes.draw do
  root to: "videos#index"

  resources :videos

  get "/welcome/index"
end
