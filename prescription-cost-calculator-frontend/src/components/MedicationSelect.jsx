import { useState } from "react";
import { Pagination, PaginationContent, PaginationItem } from "@/components/ui/pagination";

const ITEMS_PER_PAGE = 5;

export default function MedicationSelect({ medications, selectedMeds, setSelectedMeds, onAddMedication }) {
  const [currentPage, setCurrentPage] = useState(1);

  const paginatedMedications = medications.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const handleMedicationToggle = (med) => {
    setSelectedMeds((prev) => {
      const isSelected = prev.some((m) => m.id === med.id);
      let updatedMeds;

      if (isSelected) {
        updatedMeds = prev.filter((m) => m.id !== med.id);
      } else {
        updatedMeds = [...prev, { ...med, selectedDosages: [] }];
      }

      return updatedMeds;
    });
  };

  const handleDosageToggle = (medId, dosage) => {
    setSelectedMeds((prev) => {
      return prev.map((med) => {
        if (med.id === medId) {
          const dosageExists = med.selectedDosages.some((d) => d.id === dosage.id);
          const updatedDosages = dosageExists
            ? med.selectedDosages.filter((d) => d.id !== dosage.id)
            : [...med.selectedDosages, { ...dosage }];

          return { ...med, selectedDosages: updatedDosages };
        }
        return med;
      });
    });
  };

  const handleDurationChange = (medId, dosageId, newDuration) => {
    setSelectedMeds((prev) => {
      return prev.map((med) => {
        if (med.id === medId) {
          return {
            ...med,
            selectedDosages: med.selectedDosages.map((dosage) =>
              dosage.id === dosageId ? { ...dosage, default_duration: newDuration } : dosage
            ),
          };
        }
        return med;
      });
    });
  };

  return (
    <div className="p-4 max-w-xl mx-auto space-y-4">
      <h2 className="text-lg font-semibold">Select Medications</h2>
      {paginatedMedications.map((med) => {
        const isSelected = selectedMeds.some((m) => m.id === med.id);
        const selectedMed = selectedMeds.find((m) => m.id === med.id) || { selectedDosages: [] };

        return (
          <div key={med.id} className="border p-3 rounded-lg">
            <label className="flex items-center gap-2">
              <input type="checkbox" onChange={() => handleMedicationToggle(med)} checked={isSelected} />
              {med.name}
            </label>
            {isSelected && (
              <div className="ml-4 mt-2 space-y-2">
                {med.dosages.map((dosage) => (
                  <div key={dosage.id} className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      onChange={() => handleDosageToggle(med.id, dosage)}
                      checked={selectedMed.selectedDosages.some((d) => d.id === dosage.id)}
                    />
                    <span>{dosage.amount} - ${med.unit_price} per day</span>
                    <input
                      type="number"
                      min="1"
                      value={
                        selectedMed.selectedDosages.find((d) => d.id === dosage.id)?.default_duration || dosage.default_duration
                      }
                      onChange={(e) => handleDurationChange(med.id, dosage.id, Number(e.target.value))}
                      className="border rounded p-1 w-16"
                    />
                  </div>
                ))}
              </div>
            )}
          </div>
        );
      })}
      <Pagination>
        <PaginationContent>
          <PaginationItem>
            <button
              onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
              disabled={currentPage === 1}
              className="disabled:opacity-50"
            >
              Prev
            </button>
          </PaginationItem>
          <PaginationItem>
            Page {currentPage} of {Math.ceil(medications.length / ITEMS_PER_PAGE)}
          </PaginationItem>
          <PaginationItem>
            <button
              onClick={() => setCurrentPage((p) => Math.min(Math.ceil(medications.length / ITEMS_PER_PAGE), p + 1))}
              disabled={currentPage === Math.ceil(medications.length / ITEMS_PER_PAGE)}
              className="disabled:opacity-50"
            >
              Next
            </button>
          </PaginationItem>
        </PaginationContent>
      </Pagination>
    </div>
  );
}

