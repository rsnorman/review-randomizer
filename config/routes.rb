Rails.application.routes.draw do
  resources :teams
  resources :repos
  devise_for :users
  root 'welcome#index'
end
