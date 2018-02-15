class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :slug, null: false, index: { unique: true }
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
