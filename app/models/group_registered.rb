class GroupRegistered < EventLogRecord
  data_reader :name, :group_slug
end
