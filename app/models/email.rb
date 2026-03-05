class Email < ApplicationRecord
  # Un email est non-lu par défaut
  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.read ||= false
  end
end