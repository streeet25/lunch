Rails.application.routes.draw do
  devise_for :users

  namespace :users do
    resource :profile, only: [:edit, :update]
  end
end
