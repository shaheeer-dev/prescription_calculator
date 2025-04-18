medications_data = [
  {
    name: "Metformin", unit_price: 5.00, dosages: [
      { amount: "500 mg", frequency: "Once daily", default_duration: 30 },
      { amount: "500 mg", frequency: "Twice daily", default_duration: 30 },
      { amount: "1000 mg", frequency: "Once daily", default_duration: 30 }
    ]
  },
  {
    name: "Phentermine", unit_price: 15.00, dosages: [
      { amount: "15 mg", frequency: "Once daily", default_duration: 14 },
      { amount: "30 mg", frequency: "Once daily", default_duration: 14 },
      { amount: "37.5 mg", frequency: "Once daily", default_duration: 14 }
    ]
  },
  {
    name: "Naltrexone", unit_price: 12.00, dosages: [
      { amount: "25 mg", frequency: "Once daily", default_duration: 7 },
      { amount: "50 mg", frequency: "Once daily", default_duration: 28 },
      { amount: "50 mg", frequency: "Twice daily", default_duration: 28 }
    ]
  },
  {
    name: "Wellbutrin", unit_price: 10.00, dosages: [
      { amount: "100 mg", frequency: "Twice daily", default_duration: 14 },
      { amount: "150 mg", frequency: "Once daily", default_duration: 14 },
      { amount: "150 mg", frequency: "Twice daily", default_duration: 14 }
    ]
  },
  {
    name: "Topiramate", unit_price: 8.00, dosages: [
      { amount: "25 mg", frequency: "Once daily", default_duration: 30 },
      { amount: "25 mg", frequency: "Twice daily", default_duration: 30 },
      { amount: "50 mg", frequency: "Twice daily", default_duration: 30 }
    ]
  },
  {
    name: "Ozempic", unit_price: 40.00, dosages: [
      { amount: "0.25 mg", frequency: "Once weekly", default_duration: 4 },
      { amount: "0.5 mg", frequency: "Once weekly", default_duration: 4 },
      { amount: "1 mg", frequency: "Once weekly", default_duration: 4 }
    ]
  },
  {
    name: "Bupropion", unit_price: 2.50, dosages: [
      { amount: "75 mg", frequency: "Once daily", default_duration: 21 },
      { amount: "150 mg", frequency: "Once daily", default_duration: 21 },
      { amount: "150 mg", frequency: "Twice daily", default_duration: 21 }
    ]
  }
]

medications_data.each do |med_data|
  medication = Medication.create!(name: med_data[:name], unit_price: med_data[:unit_price])

  med_data[:dosages].each do |dosage_data|
    Dosage.create!(
      medication: medication,
      amount: dosage_data[:amount],
      frequency: dosage_data[:frequency],
      default_duration: dosage_data[:default_duration]
    )
  end
end

puts "Seeded #{Medication.count} medications with #{Dosage.count} dosages."
