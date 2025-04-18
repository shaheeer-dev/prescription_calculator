import { useState, useEffect } from "react";
import MedicationSelect from "../components/MedicationSelect";
import CostSummary from "../components/CostSummary";
import SuggestionList from "../components/SuggestionList";
import { getFrequency } from "@/lib/utils";
import { API_BASE_URL, BUDGET } from "@/lib/config";

const PrescriptionSelectPage = () => {
  const [prescriptions, setPrescriptions] = useState([]);
  const [medications, setMedications] = useState([]);
  const [validation, setValidation] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API_BASE_URL}/medications`)
      .then((res) => res.json())
      .then((data) => {
        setMedications(data);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  const handleAddMedication = (updatedMed) => {  
    setPrescriptions((prev) => {
      if (updatedMed.selectedDosages?.length === 0) {
        return prev.filter((med) => med.id !== updatedMed.id);
      }
      return prev.some((med) => med.id === updatedMed.id)
        ? prev.map((med) => med.id === updatedMed.id ? { ...med, selectedDosages: updatedMed.selectedDosages } : med)
        : [...prev, updatedMed];
    });
  };

  const handleConfirmPrescription = async () => {
    const requestData = {
      medications: prescriptions.flatMap((med) =>
        med.selectedDosages.map((dosage) => ({
          medication_id: med.id,
          dosage_id: dosage.id,
          duration: dosage.default_duration,
        }))
      ),
    };

    try {
      const response = await fetch(`${API_BASE_URL}/prescriptions`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(requestData),
      });
      const data = await response.json();
      setValidation(data);

      if (data.status === "valid") {
        alert("Prescription confirmed successfully!");
        setPrescriptions([]);
      }
    } catch {
      alert("Error submitting prescription");
    }
  };

  const calculateTotalCost = () =>
    prescriptions.reduce(
      (acc, med) =>
        acc +
        Number(med.unit_price) *
          med.selectedDosages.reduce((sum, d) => sum + getFrequency(d.frequency) * d.default_duration, 0),
      0
    );

  const applySuggestion = (suggestion) => {
    setPrescriptions((prev) =>
      prev.map((med) =>
        med.id === suggestion.id
          ? {
              ...med,
              selectedDosages: med.selectedDosages.map((d) =>
                d.default_duration === suggestion.original_duration
                  ? { ...d, default_duration: suggestion.suggested_duration }
                  : d
              ),
            }
          : med
      )
    );

    setValidation((prevValidation) => ({
      ...prevValidation,
      suggestions: prevValidation.suggestions.filter(
        (s) => !(s.id === suggestion.id && s.original_duration === suggestion.original_duration)
      ),
    }));
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-100 p-6">
      <div className="w-full max-w-5xl flex flex-col gap-6 bg-white shadow-lg rounded-lg p-6">
        <h1 className="text-3xl font-bold text-center text-blue-700">Prescription Management</h1>

        <div className="flex gap-6">
          <div className="w-2/3 p-4 bg-gray-50 rounded-lg shadow">
            <h2 className="text-2xl font-semibold mb-4 text-gray-800">Select Medications</h2>
            {loading ? (
              <p className="text-gray-500">Loading medications...</p>
            ) : (
              <MedicationSelect selectedMeds={prescriptions} setSelectedMeds={setPrescriptions} medications={medications} onAddMedication={handleAddMedication} />
            )}
          </div>

          <div className="w-1/3 bg-gray-50 p-4 rounded-lg shadow-md">
            <CostSummary prescriptions={prescriptions} totalCost={calculateTotalCost()} budget={BUDGET} />
            {validation?.status === "invalid" && <SuggestionList validation={validation} onApplySuggestion={applySuggestion} />}
            <button
              onClick={handleConfirmPrescription}
              disabled={prescriptions.length === 0}
              className={`w-full mt-4 py-2 rounded-md text-white font-semibold transition ${
                prescriptions.length === 0 ? "bg-gray-400 cursor-not-allowed" : "bg-green-500 hover:bg-green-600"
              }`}
            >
              Confirm Prescription
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PrescriptionSelectPage;