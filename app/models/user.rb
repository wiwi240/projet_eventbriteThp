class User < ApplicationRecord
  # --- DEVISE ---
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # --- RELATIONS ---
  has_many :administered_events, foreign_key: 'admin_id', class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  # --- ACTIVE STORAGE ---
  # Ajout de la liaison pour la photo de profil (Consigne 2.3)
  has_one_attached :avatar

  # --- MAILERS ---
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end