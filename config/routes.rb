Rails.application.routes.draw do
  resources :teams do
    resources :team_memberships
  end

  resources :repos do
    resources :pull_requests
  end

  devise_for :users

  root 'welcome#index'
end
