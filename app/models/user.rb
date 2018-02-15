class User < ApplicationRecord
  include HasSlug

  def add_product_to_inventory(product)
    raise ActiveRecord::RecordInvalid.new(product) if product.invalid?

    group.products << product
    ProductAddedToInventory.new(product_slug: product.slug, group_slug: group.slug)
  end

  belongs_to :group
  has_many :events
end
