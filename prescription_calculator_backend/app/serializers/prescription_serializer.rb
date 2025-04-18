class PrescriptionSerializer < ActiveModel::Serializer
  attributes :id, :budget, :status

  has_many :prescription_items, serializer: PrescriptionItemSerializer
end
