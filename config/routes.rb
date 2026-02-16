Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :destinations, only: [:index, :show]
  resources :trips do
    resources :bookings, only: [:create, :destroy]
  end

  get "dashboard", to: "dashboard#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
