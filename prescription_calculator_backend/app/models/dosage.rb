class Dosage < ApplicationRecord
  belongs_to :medication

  validates :amount, presence: true
  validates :frequency, presence: true
  validates :default_duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
