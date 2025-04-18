FactoryBot.define do
  factory :prescription_item do
    association :prescription
    association :medication
    association :dosage
    duration { 3 }

  end
end
