Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  resources :imports, only: [:index, :new, :create, :show]
  resources :trades, only: [:index, :show, :update]
end