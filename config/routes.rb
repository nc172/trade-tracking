Rails.application.routes.draw do
  devise_for :users

  root "rails/welcome#index"
end