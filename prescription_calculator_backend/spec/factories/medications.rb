FactoryBot.define do
  factory :medication do
    sequence(:name) { |n| "Medication #{n}" }
    unit_price { 10.00 }
  end
end
