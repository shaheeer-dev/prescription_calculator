require 'rails_helper'

RSpec.describe DosageSerializer, type: :serializer do
  let(:medication) { create(:medication) }
  let(:dosage) { create(:dosage, medication: medication, frequency: frequency) }
  let(:serialized_dosage) { DosageSerializer.new(dosage).as_json }

  context "when frequency is 'Once daily'" do
    let(:frequency) { "Once daily" }

    it "returns 1 for frequency" do
      expect(serialized_dosage[:frequency]).to eq(1)
    end
  end

  context "when frequency is 'Twice daily'" do
    let(:frequency) { "Twice daily" }

    it "returns 2 for frequency" do
      expect(serialized_dosage[:frequency]).to eq(2)
    end
  end

  context "when frequency is 'Once weekly'" do
    let(:frequency) { "Once weekly" }

    it "returns 1.0/7 for frequency" do
      expect(serialized_dosage[:frequency]).to eq(1.0 / 7)
    end
  end

  context "when frequency is unspecified" do
    let(:frequency) { "Thrice daily" }

    it "returns 1 for frequency" do
      expect(serialized_dosage[:frequency]).to eq(1)
    end
  end
end
