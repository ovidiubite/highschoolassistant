Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}

  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => '/resque_web'

  root 'home#home'

  # UsersController
  get 'users', to: 'users#index'
  get 'show/:id', to: 'users#show', as: 'user'
  delete 'destroy/:id', to: 'users#destroy', as: 'destroy_user'

  post 'calculate_percentage', to: 'search#calculate_percentage'

  # CountiesController
  get 'county_highschools', to: 'counties#county_highschools'

  namespace :admin do
    get 'dashboard',                   to: 'dashboard#dashboard'
    post 'import_highschools',         to: 'dashboard#import_highschools'
    post 'import_counties',            to: 'dashboard#import_counties'
    post 'import_admission_results',   to: 'dashboard#import_admission_results'
    post 'import_evaluation_results',  to: 'dashboard#import_evaluation_results'
    get 'highschools',                 to: 'dashboard#highschools'
    get 'highschool_details/:id',      to: 'dashboard#highschool_details', as: 'highschool_details'
    post 'fetch_highschool_data',      to: 'dashboard#fetch_highschool_data'
    post 'fetch_evaluation_results',   to: 'dashboard#fetch_evaluation_results'
  end
end
