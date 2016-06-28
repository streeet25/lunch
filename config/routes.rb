Rails.application.routes.draw do
  devise_for :users

  root 'dashboard#index'

  resource :dashboard, only: [:index,:show], controller: :dashboard

  namespace :users do
    resource    :profile, only: [:edit, :update], controller: :profile
    resources   :orders, only: [:index, :new, :create, :show]
  end

  namespace :admins do
    resources   :orders
    resources   :products, only: [:index, :show, :destroy]
  end
end
