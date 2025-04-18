class MedicationSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit_price

  has_many :dosages, serializer: DosageSerializer
end
