class Product < ApplicationRecord
  include HasSlug

  validates :name, :description, presence: true
end
