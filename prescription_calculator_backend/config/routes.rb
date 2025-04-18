Rails.application.routes.draw do
  resources :medications, only: [:index, :show]
  resources :prescriptions, only: [:index, :create, :show]
end
