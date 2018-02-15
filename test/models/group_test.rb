require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @group = Group.new(name: "10eme")
  end

  test "changing the slug of an existing object records an error" do
    @group.save!
    @group.slug = "fhj"
    assert_equal false, @group.save
    assert @group.errors.include?("slug")
  end

  test "saving the group saves the event log record(s)" do
    @group.save!
    assert_equal 1, EventLogRecord.where(type: GroupRegistered.name).count
  end
end
