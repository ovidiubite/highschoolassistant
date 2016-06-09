Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}

  ResqueWeb::Engine.eager_load!
  mount ResqueWeb::Engine => '/resque_web'

  root 'home#home'

  # UsersController
  get 'users', to: 'users#index'
  get ':id/results_history', to: 'users#results_history', as: 'results_history'
  get 'show/:id', to: 'users#show', as: 'user'
  delete 'destroy/:id', to: 'users#destroy', as: 'destroy_user'

  post 'calculate_percentage', to: 'search#calculate_percentage'
  get 'show_result', to: 'search#show_result'
  get 'new', to: 'search#new', as: 'new_search'

  # CountiesController
  get 'county_highschools', to: 'highschools#county_highschools'

  get 'highschool_sections', to: 'highschools#highschool_sections'

  namespace :admin do
    get 'dashboard',                   to: 'dashboard#dashboard'
    post 'import_highschools',         to: 'dashboard#import_highschools'
    post 'import_counties',            to: 'dashboard#import_counties'
    post 'import_admission_results',   to: 'dashboard#import_admission_results'
    post 'import_evaluation_results',  to: 'dashboard#import_evaluation_results'
    get 'highschools',                 to: 'dashboard#highschools'
    get 'users_index',                 to: 'dashboard#users_index'
    get 'highschool_details/:id',      to: 'dashboard#highschool_details', as: 'highschool_details'
    post 'fetch_highschool_data',      to: 'dashboard#fetch_highschool_data'
    post 'fetch_evaluation_results',   to: 'dashboard#fetch_evaluation_results'
  end
end
