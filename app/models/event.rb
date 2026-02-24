class Event < ApplicationRecord
  # Relations
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances

  # Validations
  validates :start_date, presence: true
  validate :not_in_past

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :multiple_of_five

  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: { in: 1..1000 }
  validates :location, presence: true

  # Méthode d'instance pour calculer la date de fin
  def end_date
    start_date + (duration * 60)
  end

  private

  def not_in_past
    errors.add(:start_date, "ne peut pas être dans le passé") if start_date.present? && start_date < Time.now
  end

  def multiple_of_five
    errors.add(:duration, "doit être un multiple de 5") if duration.present? && duration % 5 != 0
  end
end