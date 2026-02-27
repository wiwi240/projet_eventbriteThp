module Admin
  class EventSubmissionsController < BaseController
    def index
      @pending_events = Event.where(is_validated: false).order(created_at: :desc)
    end

    def update
      @event = Event.find(params[:id])
      if @event.update(is_validated: true)
        redirect_to admin_event_submissions_path, notice: "L'événement a été validé."
      else
        redirect_to admin_event_submissions_path, alert: "Erreur lors de la validation."
      end
    end
  end
end