class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
      # Recharger les erreurs pour le formulaire
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    # Ajout de :category pour permettre l'enregistrement de la nouvelle donnée
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :category)
  end
end