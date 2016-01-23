Rails.application.routes.draw do
  resources :team_memberships
  resources :teams
  resources :repos
  devise_for :users
  root 'welcome#index'
end
