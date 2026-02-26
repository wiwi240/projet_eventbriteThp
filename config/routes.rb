Rails.application.routes.draw do
  root "events#index"
  devise_for :users
  
  # --- ÉVÉNEMENTS ---
  resources :events do
    # Inscriptions aux événements
    resources :attendances, only: [:create]
  end

  # --- UTILISATEURS & AVATARS ---
  # Imbrication nécessaire pour associer l'avatar à un user_id spécifique
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  # --- STRIPE CHECKOUT ---
  # Ajout de :index pour supporter checkout_index_path
  resources :checkout, only: [:index, :create] do
    collection do
      get :success
      get :cancel
    end
  end

  # PWA
  resource :manifest, only: :show, controller: "rails/pwa", action: "manifest", as: :pwa_manifest
  resource :service_worker, only: :show, controller: "rails/pwa", action: :service_worker, as: :pwa_service_worker
end