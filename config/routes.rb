Rails.application.routes.draw do
  root "events#index"
  devise_for :users
  
  # Ressources imbriquées pour créer le lien parent/enfant
  resources :events do
    resources :attendances, only: [:create]
  end

  resources :users, only: [:show]

  # PWA routes
  resource :manifest, only: :show, controller: "rails/pwa", action: "manifest", as: :pwa_manifest
  resource :service_worker, only: :show, controller: "rails/pwa", action: :service_worker, as: :pwa_service_worker
end