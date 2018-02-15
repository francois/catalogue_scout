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

  test "#add_product_to_inventory returns a ProductAddedToInventory" do
    result = @user.add_product_to_inventory(@product)
    assert_equal @group.slug,   result.group_slug
    assert_equal @product.slug, result.product_slug
  end

  test "#add_product_to_inventory raises ActiveRecord::RecordInvalid when the product is not valid" do
    assert_raise ActiveRecord::RecordInvalid do
      @product.name = nil # make the product invalid
      @user.add_product_to_inventory(@product)
    end
  end
end
