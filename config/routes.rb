Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  resources :users, only: [:show]
  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
