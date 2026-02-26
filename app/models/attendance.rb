class Attendance < ApplicationRecord
  # Appelle le mailer de notification après chaque nouvelle participation
  after_create :attendance_send

  belongs_to :user
  belongs_to :event

  private

  def attendance_send
    # Envoie le mail à l'administrateur (ou ton adresse wiwi.test1402@gmail.com configurée dans le mailer)
    UserMailer.attendance_email(self).deliver_now
  end
end
