FactoryBot.define do
  factory :dosage do
    association :medication
    amount { "500 mg" }
    frequency { "Once daily" }
    default_duration { 30 }
  end
end
