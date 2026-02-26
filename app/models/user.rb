class User < ApplicationRecord
  # --- DEVISE ---
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # --- RELATIONS ---
  has_many :administered_events, foreign_key: "admin_id", class_name: "Event", dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  # --- ACTIVE STORAGE ---
  has_one_attached :avatar

  # --- VALIDATIONS ---
  validate :avatar_format

  # --- MAILERS ---
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  private

  # Vérifie le format et la taille de l'avatar
  def avatar_format
    return unless avatar.attached?

    unless avatar.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:avatar, "doit être au format JPG, PNG ou GIF")
    end

    if avatar.byte_size > 2.megabytes
      errors.add(:avatar, "est trop lourde (maximum 2 Mo)")
    end
  end
end
