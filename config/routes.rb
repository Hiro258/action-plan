Rails.application.routes.draw do
  root to: 'top#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
end
