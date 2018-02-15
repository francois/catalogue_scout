class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :slug, null: false, index: { unique: true }
      t.belongs_to :group, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
