Rails.application.routes.draw do
  devise_for :users

  root 'dashboard#index'

  resources :dashboard, only: :index, controller: :dashboard

  resources :orders

  namespace :users do
    resource 		:profile, only: [:edit, :update], controller: :profile
    resources 	:orders, only: [:index, :new, :create]
  end

  namespace :admins do
  	resources 	:products
  end
end
