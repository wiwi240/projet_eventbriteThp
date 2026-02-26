class AttendanceMailer < ApplicationMailer
  default from: "no-reply@eventbrite-thp.fr"

  def attendance_email(attendance)
    @attendance = attendance
    @event = attendance.event
    @admin = @event.admin
    @participant = attendance.user

    mail(to: @admin.email, subject: "Nouveau participant à votre événement : #{@event.title}")
  end
end
