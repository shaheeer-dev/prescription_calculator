class Prescription < ApplicationRecord
  CONFIGURED_BUDGET = 100.0.freeze

  has_many :prescription_items, dependent: :destroy

  validates :budget, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[valid invalid] }, allow_nil: true

  def cost_reduction_suggestions
    return [[], total_cost] if valid_prescription?

    temp_items = prescription_items.map { |item| item.dup }
    current_total_cost = total_cost

    while current_total_cost > CONFIGURED_BUDGET
      temp_items.each do |item|
        item.duration -= 1 if item.duration > 1
      end

      current_total_cost = temp_items.sum do |item|
        cost = item.calculate_cost
        cost *= 0.9 if item.duration >= 30
        cost
      end
    end

    [add_suggestion(temp_items), current_total_cost]
  end

  def add_medications(medications)
    medications.each do |med|
      prescription_items.create!(
        medication: Medication.find(med[:medication_id]),
        dosage: Dosage.find(med[:dosage_id]),
        duration: med[:duration]
      )
    end

    apply_discount
  end

  def finalize_prescription
    update(budget: total_cost)
    update(status: valid_prescription? ? "valid" : "invalid")
  end

  private

  def apply_discount
    prescription_items.each do |item|
      item.apply_discount
    end
  end

  def add_suggestion(temp_items)
    suggestions = []

    temp_items.each_with_index do |item, index|
      original_item = prescription_items[index]
      next if original_item.duration == item.duration

      suggestions << {
        id: item.medication.id,
        medication: item.medication.name,
        original_duration: original_item.duration,
        suggested_duration: item.duration,
      }
    end

    suggestions
  end

  def valid_prescription?
    total_cost <= CONFIGURED_BUDGET
  end

  def total_cost
    prescription_items.sum(&:cost)
  end
end
