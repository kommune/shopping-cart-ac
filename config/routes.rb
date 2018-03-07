Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do
    get 'cart', on: :collection
    get 'payment', on: :collection
  end

  namespace :admin do
<<<<<<< Updated upstream
    root "admin/products#index"
=======
    root "categories#index"
>>>>>>> Stashed changes
    resources :categories do
      resources :products
    end
  end
  
  resources :categories do
    resources :products
  end

  root "users#index"
end
