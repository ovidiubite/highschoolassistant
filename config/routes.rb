Rails.application.routes.draw do
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)

  devise_for :users
  resources :users

  root 'users#index'

end
