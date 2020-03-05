Rails.application.routes.draw do
  namespace :admin do
    root to: "users#index"
    resources :users
    resources :teams
    resources :players
    resources :tournaments
    resources :posts
  end
  root to: "home_pages#index"
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
