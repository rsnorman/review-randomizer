Rails.application.routes.draw do
  resources :companies

  resources :teams do
    resources :team_memberships
  end

  resources :repos do
    resources :pull_requests, controller: :repo_pull_requests
  end

  resources :pull_requests, only: [:new, :create] do
    resources :review_assignments
  end

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :pull_requests, only: :create
    end
  end

  root 'welcome#index'
end
