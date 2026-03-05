class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :destroy, :update]

  def index
    @emails = Email.all.order(created_at: :desc)
  end

  def show
    @email.update(read: true) unless @email.read

    respond_to do |format|
      format.html { redirect_to emails_path }
      format.turbo_stream
    end
  end

  def create
    sujets = ["Bonjour", "Réunion importante", "Urgent : Ton compte", "Facture n°12345", "Nouvelle mission"]
    textes = ["Voici les documents demandés pour le projet.", "On se voit demain à 10h au bureau.", "Merci de valider ce devis avant ce soir.", "Ton mot de passe expire bientôt, clique ici.", "Le système est prêt pour le lancement."]

    @email = Email.create!(
      object: sujets.sample,
      body: textes.sample,
      read: false
    )

    respond_to do |format|
      format.html { redirect_to emails_path }
      format.turbo_stream
    end
  end

  def destroy
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_path }
      format.turbo_stream
    end
  end

  def update
    @email.update(read: !@email.read)

    respond_to do |format|
      format.html { redirect_to emails_path }
      format.turbo_stream
    end
  end

  private

  def set_email
    @email = Email.find(params[:id])
  end
end