Rails.application.routes.draw do
  devise_for :users

  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => '/resque_web'

  root 'home#render_dashboard'

  get 'users', to: 'users#index'
  get 'show/:id', to: 'users#show', as: 'user'
  delete 'destroy/:id', to: 'users#destroy', as: 'destroy_user'

  get 'admin_dashboard',         to: 'admin#dashboard'
  post 'import_highschools',     to: 'admin#import_highschools'
end
