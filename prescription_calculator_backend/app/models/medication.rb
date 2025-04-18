class Medication < ApplicationRecord
  has_many :dosages
  has_many :prescription_items

  validates :name, presence: true, uniqueness: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
