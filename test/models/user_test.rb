require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @group   = Group.new
    @user    = @group.users.build
    @product = @group.products.build(name: "Tent", description: "8x12")
  end

  test "newly instantiated user has a slug" do
    assert_not_nil @user.slug
  end

  test "#add_product_to_inventory adds product to the user's group" do
    @user.add_product_to_inventory(@product)
    assert @group.products.include?(@product)
  end

  test "#add_product_to_inventory publishes a ProductAddedToInventory" do
    @user.add_product_to_inventory(@product)
    assert @user.pending_event_log_records.any?
    results = @user.pending_event_log_records.select{|r| r.kind_of?(ProductAddedToInventory)}
    assert_equal 1, results.size
    result = results.first
    assert_equal @product.name,        result.name
    assert_equal @product.description, result.description
    assert_equal @group.slug,          result.group_slug
    assert_equal @product.slug,        result.product_slug
  end

  test "#add_product_to_inventory raises ActiveRecord::RecordInvalid when the product is not valid" do
    assert_raise ActiveRecord::RecordInvalid do
      @product.name = nil # make the product invalid
      @user.add_product_to_inventory(@product)
    end
  end

  test "#add_user_to_group publishes a UserAddedToGroup event" do
    added = User.new
    @user.add_user_to_group(added)
    results = @user.pending_event_log_records.select{|r| r.kind_of?(UserAddedToGroup)}
    assert_equal 1, results.size
    result = results.first
    assert_equal added.slug, result.user_slug
    assert_equal @group.slug, result.group_slug
  end

  test "#add_user_to_group adds the user to the group" do
    added = User.new
    @user.add_user_to_group(added)
    assert @group.users.include?(added)
  end

  test "calling #save creates a UserRegistered event" do
    @group.attributes = {name: "10eme"}
    @user.attributes = {
      name: "Francois",
      email: "francois@teksol.info",
      encrypted_password: BCrypt::Password.create("password"),
    }
    @user.save!

    event = UserRegistered.first!
    assert_equal @user.email, event.email
    assert_equal @user.name, event.name
    assert_equal @user.slug, event.user_slug
  end

  test "#remove_user_from_group raises an CannotRemoveLastUserFromGroup if only one user is in the group" do
    group = Group.new
    user = group.users.build
    assert_raise CannotRemoveLastUserFromGroup do
      user.remove_user_from_group(user)
    end
  end

  test "#remove_user_from_group raises an ArgumentError if the user doesn't belong to the group" do
    assert_raise ArgumentError do
      @user.remove_user_from_group(User.new)
    end
  end

  test "#remove_user_from_group publishes a UserRemovedFromGroup event" do
    added = User.new
    @user.add_user_to_group(added)
    @user.remove_user_from_group(added)
    results = @user.pending_event_log_records.select{|r| r.kind_of?(UserRemovedFromGroup)}
    assert_equal 1, results.size
    result = results.first
    assert_equal @group.slug, result.group_slug
    assert_equal added.slug, result.user_slug
  end
end
