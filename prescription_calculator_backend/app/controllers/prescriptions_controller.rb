class PrescriptionsController < ApplicationController
  def index
    prescription = Prescription.all
    render json: prescription, each_serializer: PrescriptionSerializer
  end


  def create
    prescription = Prescription.create(budget: 0.00)

    prescription.add_medications(params[:medications])
    prescription.finalize_prescription
    suggestions, reduced_cost = prescription.cost_reduction_suggestions

    render json: {
      budget: prescription.budget,
      status: prescription.status,
      suggestions: suggestions,
      reduced_cost: reduced_cost
    }
  end

  def show
    prescription = Prescription.find(params[:id])
    render json: prescription, serializer: PrescriptionSerializer
  end
end
