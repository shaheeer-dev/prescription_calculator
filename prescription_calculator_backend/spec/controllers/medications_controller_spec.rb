require 'rails_helper'

RSpec.describe MedicationsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns all medications with correct attributes" do
      medications = create_list(:medication, 3)
      get :index
      expect(json_response.size).to eq(3)

      expected_response = medications.map do |medication|
        {
          'id' => medication.id,
          'name' => medication.name,
          'unit_price' => medication.unit_price.to_s,
          'dosages' => medication.dosages.map do |dosage|
            {
              'id' => dosage.id,
              'amount' => dosage.amount,
              'frequency' => dosage.frequency,
              'default_duration' => dosage.default_duration
            }
          end
        }
      end

      expect(json_response).to match_array(expected_response)
    end
  end

  describe "GET #show" do
    let(:medication) { create(:medication) }

    it "returns a success response" do
      get :show, params: { id: medication.id }
      expect(response).to be_successful
    end

    it "returns the correct medication with correct attributes" do
      get :show, params: { id: medication.id }

      expected_response = {
        'id' => medication.id,
        'name' => medication.name,
        'unit_price' => medication.unit_price.to_s,
        'dosages' => medication.dosages.map do |dosage|
          {
            'id' => dosage.id,
            'amount' => dosage.amount,
            'frequency' => dosage.frequency,
            'default_duration' => dosage.default_duration
          }
        end
      }

      expect(json_response).to eq(expected_response)
    end
  end
end
