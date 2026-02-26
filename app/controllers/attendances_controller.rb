class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(event: @event, user: current_user)

    if @attendance.save
      flash[:success] = "Inscription réussie ! Un mail a été envoyé."
      redirect_to event_path(@event)
    else
      flash[:error] = "Erreur lors de l'inscription."
      redirect_to event_path(@event)
    end
  end
end
