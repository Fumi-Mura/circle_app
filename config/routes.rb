Rails.application.routes.draw do

  devise_for :users, controllers: {
   registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
    
  root "home#index"
  resources :home
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :circles
  get 'search', to: 'circles#search'
  resources :blogs do
    resources :likes, only: %i[create destroy]
  end
  resources :comments, only: %i[create destroy]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :destroy, :show, :index]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :destroy, :show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
