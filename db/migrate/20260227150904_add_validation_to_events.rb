class AddValidationToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :is_validated, :boolean, default: false
  end
end