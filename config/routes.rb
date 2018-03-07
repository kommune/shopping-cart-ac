Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do
    get 'home', on: :collection
    get 'cart', on: :member
    get 'payment', on: :member
  end
  root "users#home"
  
  resources :categories do
    resources :products do
      put "add_to_cart", on: :member
      put "remove_from_cart", on: :member
    end
  end

  namespace :admin do
    root "products#index"
    resources :categories do
      resources :products, except: [:index, :new, :create]
    end
    resources :products, only: [:index]
    resources :creation, only: [:new, :create]
  end

end
