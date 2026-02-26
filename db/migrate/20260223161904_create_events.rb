class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.integer :duration
      t.string :title
      t.text :description
      t.integer :price
      t.string :location
      # On retire null: false et foreign_key: true pour éviter les erreurs au début
      t.references :admin, index: true

      t.timestamps
    end
  end
end
