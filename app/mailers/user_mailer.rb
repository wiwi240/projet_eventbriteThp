class UserMailer < ApplicationMailer
  default from: 'no-reply@eventbrite-thp.fr'

  def welcome_email(user)
    @user = user 
    @url  = 'http://localhost:3000/login' 
    mail(to: @user.email, subject: 'Bienvenue sur Eventbrite Ville !') 
  end

  def attendance_email(attendance)
    @attendance = attendance
    @admin = attendance.event.admin
    @event = attendance.event
    @participant = attendance.user

    # Notification envoyée à ton adresse spécifique
    mail(to: 'wiwi.test1402@gmail.com', subject: 'Alerte : Nouveau participant sur la plateforme !')
  end
end