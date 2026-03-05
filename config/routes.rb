Rails.application.routes.draw do
  root "events#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # --- ÉVÉNEMENTS ---
  resources :events do
    resources :attendances, only: [:create]
    resources :comments, only: [:create, :destroy]
  end

  # --- UTILISATEURS ---
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  # --- MESSAGERIE ---
  resources :emails, only: [:index, :show, :create, :destroy, :update]

  # --- ESPACE ADMIN ---
  namespace :admin do
    root to: 'dashboard#index'
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :events, only: [:index, :edit, :update, :destroy]
    resources :event_submissions, only: [:index, :update]
  end

  # --- AUTRES ---
  resources :drums, only: [:index]
  resources :checkout, only: [:index, :create] do
    collection do
      resources :success, only: [:index]
      resources :cancel, only: [:index]
    end
  end
end