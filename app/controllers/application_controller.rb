class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Autorise les paramètres supplémentaires pour Devise (Consigne 2.3)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Pour la modification du profil (edit)
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :description])
    
    # Pour la création du compte (sign up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end