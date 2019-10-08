Rails.application.routes.draw do

  root "items#index"

  devise_for :users,
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
              registrations: 'users/registrations',
              sessions: 'users/sessions' }
              
  resources :signups, only: [:index,:new, :create] do
    collection do
      get 'registration', to: 'signups#registration'
      get 'sms_confirmation', to: 'signups#sms_confirmation'
      get 'sms', to: 'signups#sms'
      get 'address', to: 'signups#address'
      get 'payment', to: 'signups#payment'
      get 'end', to: 'signups#end'
      get 'signin_sms', to: 'signups#signin_sms'
    end
  end

  resources :items do
    member do 
      get 'purchase', to: 'items#purchase', as: 'purchase'
      get "buy", to: "items#buy"
    end
  end

  resources :mypages, only: [:show, :edit] do
    member do
      get "edit_identification", to: "mypages#identification"
      get "logout", to: "mypages#logout"
    end
  end

  resources :categories, only: [:index, :new, :show, :edit, :destroy]
  namespace :api do
    get "categories/select_children"
    get "categories/select_grand_children"
    get "categories/set_children"
    get "categories/set_grand_children"
    get "sizes/select"
    get "sizes/set"
    get "delivery_methods/select"
    get "delivery_methods/set"
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end


