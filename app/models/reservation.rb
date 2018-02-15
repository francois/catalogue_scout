class Reservation < ApplicationRecord
  belongs_to :product
  belongs_to :event

  validates :product, :event, presence: true
end
