Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: ['index']
    resources :teams, only: ['index']
    resources :players, only: ['index']
    resources :tournaments, only: ['index']
  end
end
