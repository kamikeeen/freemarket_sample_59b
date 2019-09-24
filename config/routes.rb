Rails.application.routes.draw do

  root "tests#index"
  devise_for :users

  resources :tests

  resources :items, only: [:index, :new, :show, :edit, :destroy] do
    collection do #member?
      get 'purchase/:id', to: 'items#purchase', as: 'purchase'
    end
  end
    
  resources :mypages, only: [:index, :new, :show, :edit, :destroy]

end