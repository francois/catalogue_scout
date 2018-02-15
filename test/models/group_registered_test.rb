require 'test_helper'

class GroupRegisteredTest < ActiveSupport::TestCase
  test "registering a group without a name is an error" do
    assert_raise KeyError do
      GroupRegistered.new(group_slug: "jdjof")
    end
  end

  test "registering a group without a group_slug is an error" do
    assert_raise KeyError do
      GroupRegistered.new(name: "41eme")
    end
  end

  test "registering a group when both name and group_slug are present is OK" do
    GroupRegistered.new(name: "39eme", group_slug: "fjis")
  end
end
