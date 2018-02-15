class ProductAddedToInventory < EventLogRecord
  data_reader :name, :description, :product_slug, :group_slug
end
