class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :slug, null: false, index: { unique: true }
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.date :begin_on, :end_on, null: false

      t.timestamps
    end
  end
end
