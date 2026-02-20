Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :destinations, only: [:index, :show]
  resources :trips do
    resources :bookings, only: [:create, :destroy] do
      member do
        post :confirm
        post :reject
      end
    end
    resources :ratings, only: [:new, :create]
  end

  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :notifications, only: [:index] do
    member do
      post :mark_as_read
    end
    collection do
      post :mark_all_as_read
    end
  end

  resources :profiles, only: [:show, :edit, :update]

  get "dashboard", to: "dashboard#index"
  get "admin/stats", to: "admin#stats"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
