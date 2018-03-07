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
    resources :products do
      put "add_to_cart", on: :member
      put "remove_from_cart", on: :member
    end
  end

end
