Rails.application.routes.draw do
  root to: "sessions#show"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  get '/pay', to: 'sessions#pay'

  resources :users, only: [:new, :create, :edit, :update]

  get '/dashboard', to: 'users#show'

  namespace :admin do
    get '/dashboard', to: 'orders#dashboard'
    get '/filter', to: 'orders#filter'
    resources :powers, only: [:new, :create]
  end

  resources :powers, only: [:index, :show, :destroy]

  resources :briefcases, only: [:create]
  get '/briefcase', to: "briefcases#show"
  put '/briefcase', to: "briefcases#update"
  patch '/briefcase', to: "briefcases#alter_quantity"

  resources :orders, only: [:index, :show, :create, :update]
  get '/categories', to: 'categories#index'
  get '/:category', to: 'categories#show', as: 'category'
  
end
