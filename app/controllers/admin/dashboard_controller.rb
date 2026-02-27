module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_admin

    def index
      @users_count = User.count
      @validated_events_count = Event.where(is_validated: true).count
      @pending_events_count = Event.where(is_validated: false).count
    end

    private

    def check_if_admin
      unless current_user.is_admin
        redirect_to root_path, alert: "Accès réservé aux administrateurs."
      end
    end
  end
end