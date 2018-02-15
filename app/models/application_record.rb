class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize {|r| r.clear_pending_event_log_records}
  after_initialize {|r| r.slug = r.class.generate_slug if r.attributes.include?("slug") && r.slug.blank? }

  attr_reader :pending_event_log_records

  def clear_pending_event_log_records
    @pending_event_log_records = []
  end

  def publish_event_log_record(record)
    pending_event_log_records << record
    self
  end

  def self.generate_slug
    SecureRandom.base58(8).downcase
  end
end
