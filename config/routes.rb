Rails.application.routes.draw do
  root to: 'home#top'
  devise_for :users
  resources :users, only: :show
  resources :groups
  resources :destinations
  resources :plans
end
