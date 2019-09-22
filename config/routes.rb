Rails.application.routes.draw do
  devise_for :users
  root "dtests#index"
  resources :items, only: [:index, :new, :show, :edit, :destroy]
  resources :mypages, only: [:index, :new, :show, :edit, :destroy]
end
