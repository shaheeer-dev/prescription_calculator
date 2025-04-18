class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication
  belongs_to :dosage

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cost, presence: true

  before_validation :calculate_cost

  def calculate_cost
    frequency_factor = case dosage.frequency.downcase
                       when "once daily" then 1
                       when "twice daily" then 2
                       when "once weekly" then 1.0 / 7
                       else 1
                       end

    self.cost = (frequency_factor * duration * medication.unit_price).round(2)
  end

  def apply_discount
    self.cost *= 0.9 if duration >= 30
  end
end
