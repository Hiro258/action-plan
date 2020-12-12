Rails.application.routes.draw do
  root to: 'top#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  delete 'destroy_user', to: 'users#destroy'
  
  
  resources :users, only: [:index, :show, :new, :destroy, :create, :edit, :update] do
    member do
      get :likes
    end
  end
  
  resources :actionplans, only: [:index, :show, :create, :new, :destroy, :edit, :update]
  resources :favorites, only: [:create, :destroy]
end
