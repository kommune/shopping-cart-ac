Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }
  
  resources :users do
    get 'cart', on: :collection
    get 'payment', on: :collection
  end

  resources :admin
end
