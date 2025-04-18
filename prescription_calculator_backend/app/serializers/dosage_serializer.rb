class DosageSerializer < ActiveModel::Serializer
  attributes :id, :amount, :frequency, :default_duration

  # def frequency
  #   case object.frequency.downcase
  #   when "once daily"
  #     1
  #   when "twice daily"
  #     2
  #   when "once weekly"
  #     1.0 / 7
  #   else
  #     1
  #   end
  # end
end
