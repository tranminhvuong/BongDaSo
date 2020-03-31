Rails.application.routes.draw do
  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :teams, only: %i[show edit update] do
      resources :players, only: %i[new create]
    end
    resources :players, except: [:index]
    resources :tournaments do
      resources :matches, only: %i[index edit update show]
      resources :teams, only: [:index]
      member do
        get 'statictical', to: 'staticticals#index'
      end
    end
    resources :events
    resources :matches, only: %i[update show]
    resources :posts do
      member do
        post 'public', to: 'posts#publiced'
        post 'private', to: 'posts#privated'
      end
    end
  end
  # login
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  # public
  root to: 'home_pages#index'
  resources :posts, only: %i[show index]
  resources :tournaments, only: [:show, :index]
  get '/schedules', to: 'schedules#index'
  resources :teams, only: [:show]
end
