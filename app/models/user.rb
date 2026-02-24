class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # RELATIONS (NE PAS SUPPRIMER)
  has_many :administered_events, foreign_key: 'admin_id', class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  # MAILERS
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end