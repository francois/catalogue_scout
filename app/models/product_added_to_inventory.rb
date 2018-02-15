class ProductAddedToInventory < EventLogRecord
  def initialize(product_slug:, group_slug:, meta: {})
    super(
      meta: meta,
      data: {
        "product_slug" => product_slug,
        "group_slug"   => group_slug,
      }
    )
  end

  def product_slug
    data["product_slug"]
  end

  def group_slug
    data["group_slug"]
  end
end
