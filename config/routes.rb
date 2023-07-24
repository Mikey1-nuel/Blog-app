Rails.application.routes.draw do
  get 'health/index'
  get '/users/index', to: 'users#index', as: 'users_index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
