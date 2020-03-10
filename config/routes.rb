Rails.application.routes.draw do
  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :teams do
      post 'add-player', to: 'teams#add_player'
      delete 'delete-player', to: 'teams#delete_player'
    end
    resources :players
    resources :tournaments do
      member do
        resources :teams
      end
    end
    resources :posts do
      member do
        post 'public', to: 'posts#publiced'
        post 'private', to: 'posts#privated'
      end
    end
  end
  root to: 'home_pages#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
