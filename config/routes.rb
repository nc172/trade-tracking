Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  resources :imports, only: [:new, :create, :show]
  resources :trades, only: [:index, :show]
end