Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do 
    get 'home', on: :collection
    get 'aboutus', on: :collection
    get 'theprocess', on: :collection
    get 'materialsandcare', on: :collection
    get 'payment', on: :member
    get '/cart', to: 'carts#show'
    resources :orders
  end

  root "users#home"
  
  resources :categories, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end

  resources :products, only: [] do
    put 'add_to_cart', on: :member
    put 'remove_from_cart', on: :member
  end

  namespace :admin do
    root "products#index"
    resources :categories do
      resources :products, except: [:index, :new, :create]
    end
    resources :products, only: [:index]
    resources :creations, only: [:new, :create]
  end

end
