Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  root to: 'home#top'
  devise_for :users
  resources :users, only: :show
  resources :groups, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :destinations
  resources :plans, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      get 'edit_status'
      patch 'update_status'
    end
  end
end
