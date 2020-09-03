Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :circles
  get 'search', to: 'circles#search'
  resources :blogs do
    resources :likes, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :destroy, :show, :index]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :destroy, :show, :index]
  resources :notifications, only: :index
end
