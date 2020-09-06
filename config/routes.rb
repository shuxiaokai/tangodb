Rails.application.routes.draw do
  root "videos#index"

  resources :videos, only: %i[index]
end
