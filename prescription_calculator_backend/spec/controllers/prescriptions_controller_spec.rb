require 'rails_helper'

RSpec.describe PrescriptionsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns all prescriptions with correct attributes" do
      prescriptions = create_list(:prescription, 3)
      get :index
      expect(json_response.size).to eq(3)

      expected_response = prescriptions.map do |prescription|
        {
          'id' => prescription.id,
          'budget' => prescription.budget.to_s,
          'status' => prescription.status,
          'prescription_items' => prescription.prescription_items.map do |item|
            {
              'id' => item.id,
              'duration' => item.duration,
              'cost' => item.cost.to_s,
              'medication' => {
                'id' => item.medication.id,
                'name' => item.medication.name,
                'unit_price' => item.medication.unit_price.to_s
              }
            }
          end
        }
      end

      expect(json_response).to match_array(expected_response)
    end
  end

  describe "POST #create" do
    let(:medications) { [{ medication_id: create(:medication).id, dosage_id: create(:dosage).id, duration: 30 }] }

    it "creates a new prescription" do
      expect {
        post :create, params: { medications: medications }
      }.to change(Prescription, :count).by(1)
    end

    it "returns the created prescription with budget and status" do
      post :create, params: { medications: medications }
      prescription = Prescription.last

      expected_response = {
        'budget' => prescription.budget.to_s,
        'status' => prescription.status,
        'suggestions' => prescription.cost_reduction_suggestions.first.map do |suggestion|
          suggestion.transform_keys(&:to_s)
        end,
        'reduced_cost' => prescription.cost_reduction_suggestions.second.to_s
      }

      expect(json_response).to eq(expected_response)
    end
  end

  describe "GET #show" do
    let(:prescription) { create(:prescription) }

    it "returns a success response" do
      get :show, params: { id: prescription.id }
      expect(response).to be_successful
    end

    it "returns the correct prescription with correct attributes" do
      get :show, params: { id: prescription.id }

      expected_response = {
        'id' => prescription.id,
        'budget' => prescription.budget.to_s,
        'status' => prescription.status,
        'prescription_items' => prescription.prescription_items.map do |item|
          {
            'id' => item.id,
            'duration' => item.duration,
            'cost' => item.cost.to_s,
            'medication' => {
              'id' => item.medication.id,
              'name' => item.medication.name,
              'unit_price' => item.medication.unit_price.to_s
            }
          }
        end
      }

      expect(json_response).to eq(expected_response)
    end
  end
end
