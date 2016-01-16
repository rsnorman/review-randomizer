Rails.application.routes.draw do
  resources :repos
  devise_for :users
  root 'welcome#index'
end
