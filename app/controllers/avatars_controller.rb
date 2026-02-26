class AvatarsController < ApplicationController
  # Gère le téléversement de la photo de profil
  def create
    # Recherche de l'utilisateur cible via l'ID passé en paramètre d'URL
    @user = User.find(params[:user_id])

    # Utilisation de la méthode .attach fournie par Active Storage
    # Le fichier provient du champ file_field_tag :avatar
    @user.avatar.attach(params[:avatar])

    # Redirection vers la vue show de l'utilisateur après succès
    redirect_to(user_path(@user), notice: "Votre photo de profil a été mise à jour.")
  end
end
