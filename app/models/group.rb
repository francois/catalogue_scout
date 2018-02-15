class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :users
  has_many :products

  before_create :register_group_event

  def register_group_event
    publish_event_log_record(
      GroupRegistered.new(
        group_slug: slug,
        name: name,
      )
    )
  end
end
