class Product < ApplicationRecord
  include HasSlug

  validates :name, presence: true
end
