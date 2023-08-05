Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create, :destroy]
    end
  end

    #API routes
    namespace :api do
      resources :users, only: [:show] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
end
