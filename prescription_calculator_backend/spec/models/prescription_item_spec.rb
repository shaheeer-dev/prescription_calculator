require 'rails_helper'

RSpec.describe PrescriptionItem, type: :model do
  describe "#calculate_cost" do
    it "calculates the cost based on frequency and duration" do
      medication = create(:medication, unit_price: 10)
      dosage = create(:dosage, frequency: "once daily", medication: medication)
      item = build(:prescription_item, medication: medication, dosage: dosage, duration: 30)

      item.calculate_cost

      expect(item.cost).to eq(300)
    end
  end

  describe "#apply_discount" do
    it "applies a discount for long durations" do
      item = build(:prescription_item, duration: 30, cost: 1000)

      item.apply_discount

      expect(item.cost).to eq(900)
    end

    it "does not apply a discount for short durations" do
      item = build(:prescription_item, duration: 10, cost: 1000)

      item.apply_discount

      expect(item.cost).to eq(1000)
    end
  end
end
