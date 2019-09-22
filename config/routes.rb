Rails.application.routes.draw do
  devise_for :users
  root "dtests#index"
end
