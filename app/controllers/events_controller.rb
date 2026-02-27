class EventsController < ApplicationController
  # 1. On sécurise les actions de modification/suppression
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  # 2. On vérifie que c'est bien l'organisateur AVANT d'agir
  before_action :is_admin?, only: [ :edit, :update, :destroy ]

  def index
    # On affiche uniquement les événements validés par l'administration
    @events = Event.where(is_validated: true).order(start_date: :asc)
  end

  def show
    @event = Event.find_by(id: params[:id])

    if @event.nil?
      redirect_to root_path, alert: "Événement introuvable."
      return
    end

    # Sécurité : Si l'événement n'est pas validé, seul l'admin ou l'organisateur peut y accéder
    if !@event.is_validated && (current_user != @event.admin && (!current_user&.is_admin))
      redirect_to root_path, alert: "Cet événement est en attente de validation."
      return
    end

    @attendances = @event.attendances
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
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :category, :event_picture)
  end

  def is_admin?
    @event = Event.find(params[:id])

    unless current_user == @event.admin
      redirect_to root_path, alert: "Vous n'êtes pas l'organisateur de cet événement !"
    end
  end
end