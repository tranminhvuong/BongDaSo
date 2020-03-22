Rails.application.routes.draw do
  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :teams do
      member do
        post 'add-player', to: 'teams#add_player'
        delete 'delete-player', to: 'teams#delete_player'
      end
    end
    resources :players, except: [:index]
    resources :tournaments
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
  resources :posts, only: [:show, :index]
  # resources :tournament, only: [:show, :index]
end
