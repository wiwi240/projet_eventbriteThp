class User < ApplicationRecord
  # Configuration Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Tes relations et mailer
  after_create :welcome_send
  has_many :attendances
  has_many :events, through: :attendances
  has_many :administered_events, class_name: "Event", foreign_key: "admin_id"

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end