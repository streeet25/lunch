Rails.application.routes.draw do
  devise_for :users

  root 'dashboard#index'

  resources :dashboard, only: :index, controller: :dashboard

  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
  end
end
