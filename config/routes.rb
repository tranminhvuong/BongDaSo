Rails.application.routes.draw do
  namespace :admin do
    root to: "users#index"
    resources :users, only: ['index']
    resources :teams, only: ['index']
    resources :players, only: ['index']
    resources :tournaments, only: ['index']
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
