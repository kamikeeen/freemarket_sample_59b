Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/signup', to: 'users/registrations#registration'
    get '/users/signup/registration', to: 'users/registrations#new'
    get '/users/signup/sms_confirmation/', to:'users/registrations#sms_confirmation'
    get '/users/signup/sms/', to:'users/registrations#sms'
  end
  root "dtests#index"
  resources :items, only: [:index, :new, :show, :edit, :destroy]
  resources :mypages, only: [:index, :new, :show, :edit, :destroy]
end
