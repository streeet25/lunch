Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root 'dashboard#index'

  resource :dashboard, only: [:index,:show], controller: :dashboard

  namespace :users do
    resource    :profile, only: [:edit, :update], controller: :profile
    resources   :orders, only: [:index, :new, :create, :show]
  end

  namespace :admins do
    resources   :users, only: [:index, :edit, :update, :destroy]
    resources   :orders, only: [:index, :show, :destroy]
    resources   :products
    resources   :weekdays
  end
end
