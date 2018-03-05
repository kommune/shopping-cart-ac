Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  
  resources :users do
    get 'cart', on: :collection
    get 'payment', on: :collection
  end

  resources :admin
end
