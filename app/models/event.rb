class Event < ApplicationRecord
  belongs_to :user

  validates :name, :user, :begin_on, :end_on, presence: true

  has_many :reservations
  has_many :products, through: :reservations
end
