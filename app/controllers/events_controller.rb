class EventsController < ApplicationController
  # 1. On sécurise les actions de modification/suppression
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  # 2. On vérifie que c'est bien l'organisateur AVANT d'agir
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def index
    @events = Event.all.order(start_date: :asc)
  end

  def show
    @event = Event.find_by(id: params[:id])

    if @event.nil?
      redirect_to root_path, alert: "Événement introuvable."
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to event_path(@event), notice: "L'événement a été créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # --- AJOUTS JOUR 3 : MODIFICATION & SUPPRESSION ---

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Votre événement a été mis à jour !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "L'événement a été supprimé définitivement."
  end

  private

  def event_params
    # AJOUT : :event_picture est maintenant permis pour Active Storage
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :category, :event_picture)
  end

  # --- SECURITE ---

  def is_admin?
    @event = Event.find(params[:id])
    
    unless current_user == @event.admin
      redirect_to root_path, alert: "Vous n'êtes pas l'organisateur de cet événement !"
    end
  end
end