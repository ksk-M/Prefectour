Rails.application.routes.draw do
  root to: 'home#top'
  devise_for :users
  resources :users, only: :show
  resources :groups, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :destinations
  resources :plans, only: [:new, :create, :show, :edit, :update, :destroy]
end
