Rails.application.routes.draw do

  root "tests#index"
  
  devise_for :users
  devise_scope :user do
    get '/users/signup', to: 'users/registrations#registration'
    get '/users/signup/registration', to: 'users/registrations#new'
    get '/users/signup/sms_confirmation/', to:'users/registrations#sms_confirmation'
    get '/users/signup/sms/', to:'users/registrations#sms'
    get '/users/signup/address/', to:'users/registrations#address'
    get '/users/signup/payment/', to:'users/registrations#payment'
    get '/users/signup/end/', to:'users/registrations#end'
  end

  resources :tests

  resources :items, only: [:index, :new, :show, :edit, :destroy] do
    collection do #member?
      get 'purchase/:id', to: 'items#purchase', as: 'purchase'
    end
  end

  resources :mypages, only: [:index, :new, :show, :edit, :destroy]

end