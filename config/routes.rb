Rails.application.routes.draw do
  root "events#index"
  devise_for :users
  
  # CRUD standard pour les événements
  resources :events do
    # Uniquement Create pour l'inscription (POST)
    resources :attendances, only: [:create]
  end

  resources :users, only: [:show]

  # --- STRIPE CHECKOUT ---
  # On utilise 'resources' pour rester RESTful.
  # 'collection' permet d'ajouter les routes de retour (success/cancel)
  # qui sont des pages d'affichage (donc GET par nature).
  resources :checkout, only: [:create] do
    collection do
      get :success
      get :cancel
    end
  end

  # PWA
  resource :manifest, only: :show, controller: "rails/pwa", action: "manifest", as: :pwa_manifest
  resource :service_worker, only: :show, controller: "rails/pwa", action: :service_worker, as: :pwa_service_worker
end