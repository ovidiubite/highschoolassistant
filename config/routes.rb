Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}

  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => '/resque_web'

  root 'home#home'

  get 'users', to: 'users#index'
  get 'show/:id', to: 'users#show', as: 'user'
  delete 'destroy/:id', to: 'users#destroy', as: 'destroy_user'

  namespace :admin do
    get 'dashboard',                   to: 'dashboard#dashboard'
    post 'import_highschools',         to: 'dashboard#import_highschools'
    post 'import_counties',            to: 'dashboard#import_counties'
    post 'import_admission_results',   to: 'dashboard#import_admission_results'
    post 'import_evaluation_results',  to: 'dashboard#import_evaluation_results'
    get 'highschools',                 to: 'dashboard#highschools'
    get 'highschool_details/:id',      to: 'dashboard#highschool_details', as: 'highschool_details'
    post 'fetch_highschool_data',      to: 'dashboard#fetch_highschool_data'
  end
end
