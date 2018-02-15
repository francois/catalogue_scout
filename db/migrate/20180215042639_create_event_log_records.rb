class CreateEventLogRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :event_log_records do |t|
      t.string :type, null: false, index: true
      t.jsonb :meta, null: false
      t.jsonb :data, null: false

      t.timestamps
    end
  end
end
