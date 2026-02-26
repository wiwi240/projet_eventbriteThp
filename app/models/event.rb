class Event < ApplicationRecord
  # --- RELATIONS ---
  belongs_to :admin, class_name: "User"
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  
  # AJOUT : Active Storage pour la photo de l'événement
  has_one_attached :event_picture

  # --- VALIDATIONS ---
  
  # Photo obligatoire (Consigne 2.1)
  validate :picture_must_be_attached

  # Date de début
  validates :start_date, presence: true
  validate :not_in_past

  # Durée
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :multiple_of_five

  # Contenu
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  
  # Prix et Lieu
  validates :price, presence: true, inclusion: { in: 1..1000 }
  validates :location, presence: true

  # --- MÉTHODES ---

  def end_date
    start_date + (duration * 60)
  end

  private

  # Validation pour la photo obligatoire
  def picture_must_be_attached
    unless event_picture.attached?
      errors.add(:event_picture, "doit être jointe à l'événement")
    end
  end

  def not_in_past
    if start_date.present? && start_date < Time.now
      errors.add(:start_date, "ne peut pas être dans le passé")
    end
  end

  def multiple_of_five
    if duration.present? && duration % 5 != 0
      errors.add(:duration, "doit être un multiple de 5")
    end
  end
end