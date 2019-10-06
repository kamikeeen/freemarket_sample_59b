Rails.application.routes.draw do

  root "items#index"
  
  devise_for :users,
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
              registrations: 'users/registrations',
              sessions: 'users/sessions' }
  resources :tests
  resources :signups, only: [:index,:new] do
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

  resources :items, only: [:index, :new, :show, :edit, :destroy] do
    collection do #member?
      get 'purchase/:id', to: 'items#purchase', as: 'purchase'
    end
  end

  resources :mypages, only: [:show, :edit] do
    member do
      get "cards", to:"mypages#cards"
      get "edit_identification", to: "mypages#identification"
      get "logout", to: "mypages#logout"
    end
  end

  resources :categories, only: [:index, :new, :show, :edit, :destroy]

end