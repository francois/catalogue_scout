class CreateEventLogRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :event_log_records do |t|
      t.jsonb :meta
      t.jsonb :data

      t.timestamps
    end
  end
end
