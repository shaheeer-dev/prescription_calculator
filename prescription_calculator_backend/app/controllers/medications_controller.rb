class MedicationsController < ApplicationController
  def index
    medications = Medication.includes(:dosages).all
    render json: medications, each_serializer: MedicationSerializer
  end

  def show
    medication = Medication.find(params[:id])
    render json: medication, serializer: MedicationSerializer
  end
end
