class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize {|r| r.clear_pending_event_log_records}
  after_initialize {|r| r.slug = r.class.generate_slug if r.slug.blank? }
  after_save       {|r| r.pending_event_log_records.each(&:save!) }
  after_commit     {|r| r.clear_pending_event_log_records }

  validate :slug_has_not_changed, on: :update

  attr_reader :pending_event_log_records

  def clear_pending_event_log_records
    @pending_event_log_records = []
  end

  def publish_event_log_record(record)
    pending_event_log_records << record
    self
  end

  def to_key
    [slug]
  end

  def to_param
    slug if persisted?
  end

  def self.generate_slug
    SecureRandom.base58(8).downcase
  end

  def slug_has_not_changed
    return unless attributes.include?("slug")
    return unless slug_changed?

    errors.add(:slug, "must not change")
  end
end
