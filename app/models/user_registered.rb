class UserRegistered < EventLogRecord
  data_reader :user_slug, :name, :email
end
