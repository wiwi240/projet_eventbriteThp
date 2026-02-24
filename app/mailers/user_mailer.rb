class UserMailer < ApplicationMailer
  default from: 'no-reply@eventbrite-thp.fr'

  def welcome_email(user)
    @user = user 
    @url  = 'http://eventbrite-thp.fr/login' 
    mail(to: @user.email, subject: 'Bienvenue sur Eventbrite Ville !') 
  end

  # Ajoute ceci pour les participations
  def attendance_email(attendance)
    @attendance = attendance
    @admin = attendance.event.admin
    @event = attendance.event

    mail(to: @admin.email, subject: 'Nouveau participant à ton événement !')
  end
end