class PrescriptionItemSerializer < ActiveModel::Serializer
  attributes :id, :duration, :cost

  belongs_to :medication, serializer: MedicationSerializer
end
