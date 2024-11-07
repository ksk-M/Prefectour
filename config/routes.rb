Rails.application.routes.draw do
  root to: 'home#top'
  get '/about', to: 'pages#about'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
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
