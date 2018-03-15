Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do 
    get 'home', on: :collection
    get 'aboutus', on: :collection
    get 'theprocess', on: :collection
    get 'materialsandcare', on: :collection
    resources :orders

  end

  root "users#home"
  
  resource :cart, only: [:show]

  post 'cart/:product_id', to: 'carts#add', as: 'add_to_cart'
  delete 'cart/:product_id', to: 'carts#remove', as: 'remove_from_cart'

  resources :categories, only: [:index, :show]

  resources :products, only: [:index, :show]

  resources :orders, only: [:show] do
    get 'checkout', on: :collection
    resources :transactions, only: [:new, :create], on: :member
  end

  namespace :admin do
    root "products#index"
    resources :categories do
      resources :products, except: [:index, :new, :create]
    end
    resources :products, only: [:index]
    resources :creations, only: [:new, :create]
    resources :orders, only: [:index, :show, :update, :edit, :destroy]
  end

end
