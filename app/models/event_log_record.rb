# Used as the system's memory of the individual actions that occurred.
#
# Whenever a user of the system executes an action, a new event log record is
# created and appended to the log. Those event log records represent the different
# states the system has been in.
#
# @example Recording the addition of a User to a Group
#
#     class UserAddedToGroup < EventLogRecord
#       data_attr :user_slug, :group_slug
#     end
#
#     class Group < ApplicationRecord
#       def register_user(user, meta: {})
#         users << user
#         publish_event_log_record(
#           UserAddedToGroup.new(
#             group_slug: group.slug,
#             meta:       meta,
#             user_slug:  user.slug,
#           )
#         )
#       end
#     end
#
#     group = Group.last
#     group.register_user(User.new(...))
#     group.save!
class EventLogRecord < ApplicationRecord
  validates :data, presence: true

  def initialize(attrs={})
    meta = attrs.delete(:meta) || attrs.delete("meta") || Hash.new
    data = data_attrs.fetch(self.class).map do |attr|
      [attr, attrs.fetch(attr.to_sym){ attrs.fetch(attr.to_s) }]
    end.to_h.compact

    super(meta: meta, data: data)
  end

  cattr_accessor :data_attrs

  # Declares an attribute that is stored in the data portion of the event log record.
  #
  # Data attributes are the different attributes we wish to preserve about the state
  # of the system. Slugs are one of the primary ways to identify objects in this system,
  # and are the most important values to record in events.
  #
  # All declared attributes are required. A `KeyError` will be raised for missing attributes.
  def self.data_reader(*attrs)
    Array(attrs).flatten.compact.map(&:to_sym).each do |attr|
      self.data_attrs       ||= Hash.new
      self.data_attrs[self] ||= Set.new
      self.data_attrs[self]  << attr
      define_method(attr) do
        data[attr.to_s]
      end
    end
  end
end
