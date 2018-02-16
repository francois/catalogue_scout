class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_create :publish_group_registered_event

  def publish_group_registered_event
    publish_event_log_record(
      GroupRegistered.new(
        group_slug: slug,
        name: name,
      )
    )
  end

  has_many :users,    autosave: true
  has_many :products, autosave: true
end
