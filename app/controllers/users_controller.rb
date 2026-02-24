class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_it_me?, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def is_it_me?
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:alert] = "Accès refusé : tu ne peux voir que ton propre profil."
      redirect_to root_path
    end
  end
end