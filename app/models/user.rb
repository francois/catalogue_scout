class User < ApplicationRecord
  before_create :publish_user_registered

  def publish_user_registered
    publish_event_log_record(
      UserRegistered.new(
        email: email,
        name: name,
        user_slug: slug,
      )
    )
  end

  def add_user_to_group(user)
    group.users << user
    publish_event_log_record(
      UserAddedToGroup.new(
        group_slug: group.slug,
        user_slug:  user.slug,
      )
    )
  end

  def add_product_to_inventory(product)
    raise ActiveRecord::RecordInvalid.new(product) if product.invalid?

    group.products << product
    publish_event_log_record(
      ProductAddedToInventory.new(
        description: product.description,
        group_slug: group.slug,
        name: product.name,
        product_slug: product.slug,
      )
    )
  end

  delegate :products, to: :group

  belongs_to :group,  autosave: true, inverse_of: :users
  has_many   :events, autosave: true
end
