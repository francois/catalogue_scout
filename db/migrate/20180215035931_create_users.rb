class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: false, index: { unique: true }
      t.string :encrypted_password, null: false
      t.string :name, null: false
      t.string :slug, null: false, index: { unique: true }
      t.belongs_to :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
