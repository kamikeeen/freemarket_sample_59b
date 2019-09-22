Rails.application.routes.draw do
  root "tests#index"
  devise_for :users
  resources :tests
  resources :items, only: [:index, :new, :show, :edit, :destroy]
  resources :mypages, only: [:index, :new, :show, :edit, :destroy]
end
