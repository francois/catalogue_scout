class UserAddedToGroup < EventLogRecord
  data_reader :user_slug, :group_slug
end
