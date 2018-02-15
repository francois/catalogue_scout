class User < ApplicationRecord
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

  belongs_to :group
  has_many :events
end
