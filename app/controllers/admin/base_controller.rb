module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_admin

    private

    def check_if_admin
      unless current_user.is_admin
        flash[:alert] = "Accès réservé aux administrateurs."
        redirect_to root_path
      end
    end
  end
end