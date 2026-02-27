Rails.application.routes.draw do
  root "events#index"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # --- ÉVÉNEMENTS PUBLICS ---
  resources :events do
    resources :attendances, only: [:create]
  end

  # --- UTILISATEURS PUBLICS ---
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  # --- ESPACE ADMINISTRATEUR ---
  namespace :admin do
    root to: 'dashboard#index'
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :events, only: [:index, :edit, :update, :destroy]
    resources :event_submissions, only: [:index, :update]
  end

  # --- STRIPE & PWA ---
  resources :checkout, only: [:index, :create] do
    collection do
      get :success
      get :cancel
    end
  end

  resource :manifest, only: :show, controller: "rails/pwa", action: "manifest", as: :pwa_manifest
  resource :service_worker, only: :show, controller: "rails/pwa", action: :service_worker, as: :pwa_service_worker
end