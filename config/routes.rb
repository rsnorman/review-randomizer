Rails.application.routes.draw do
  resources :teams do
    resources :team_memberships
  end
  resources :repos
  devise_for :users
  root 'welcome#index'
end
