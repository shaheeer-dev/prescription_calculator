require 'rails_helper'

RSpec.describe Prescription, type: :model do

  describe "#cost_reduction_suggestions" do
    it "returns suggestions when the prescription exceeds the budget" do
      prescription = create(:prescription, budget: 100)
      medication = create(:medication, unit_price: 50)
      dosage = create(:dosage, frequency: "once daily", medication: medication)
      create(:prescription_item, prescription: prescription, medication: medication, dosage: dosage, duration: 3)

      suggestions, reduced_cost = prescription.cost_reduction_suggestions

      expect(suggestions).not_to be_empty
      expect(reduced_cost).to be < 150 # 50 * 3
    end

    it "returns an empty array when the prescription is within the budget" do
      prescription = create(:prescription, budget: 100)
      medication = create(:medication, unit_price: 20)
      dosage = create(:dosage, frequency: "once daily", medication: medication)
      create(:prescription_item, prescription: prescription, medication: medication, dosage: dosage, duration: 3)

      suggestions, reduced_cost = prescription.cost_reduction_suggestions

      expect(suggestions).to be_empty
      expect(reduced_cost).to eq(60) # 20 * 3
    end
  end

  describe "#add_medications" do
    it "adds medications to the prescription" do
      prescription = create(:prescription)
      medications = [
        { medication_id: create(:medication).id, dosage_id: create(:dosage).id, duration: 30 }
      ]

      expect {
        prescription.add_medications(medications)
      }.to change(prescription.prescription_items, :count).by(1)
    end
  end

  describe "#finalize_prescription" do
    it "updates the budget and status of the prescription" do
      prescription = create(:prescription)
      medication = create(:medication, unit_price: 50)
      dosage = create(:dosage, frequency: "once daily", medication: medication)
      create(:prescription_item, prescription: prescription, medication: medication, dosage: dosage, duration: 1)

      prescription.finalize_prescription

      expect(prescription.budget).to eq(50) # 50 * 1
      expect(prescription.status).to eq("valid")
    end
  end
end
