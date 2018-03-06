Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do
    get 'home', on: :collection
    get 'cart', on: :collection
    get 'payment', on: :collection
  end
  
  root "users#home"

  namespace :admin do
    root "products#index"
    resources :categories do
      resources :products
    end
  end
  
  resources :categories do
    resources :products
  end

end
