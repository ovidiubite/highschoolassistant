Rails.application.routes.draw do
  devise_for :users

  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => '/resque_web'

  root 'home#render_dashboard'

  get 'users', to: 'users#index'
  get 'show/:id', to: 'users#show', as: 'user'
  delete 'destroy/:id', to: 'users#destroy', as: 'destroy_user'

  get 'admin_dashboard',            to: 'admin#dashboard'
  post 'import_highschools',        to: 'admin#import_highschools'
  post 'import_counties',           to: 'admin#import_counties'
  post 'import_admission_results',  to: 'admin#import_admission_results'
  post 'import_evaluation_results', to: 'admin#import_evaluation_results'
end
