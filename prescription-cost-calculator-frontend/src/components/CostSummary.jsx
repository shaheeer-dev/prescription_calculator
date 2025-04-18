const CostSummary = ({ prescriptions, totalCost, budget }) => {
  console.log('prescriptions ', prescriptions.length);
  return (
    <div className="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-md shadow-sm">
      <h2 className="text-lg font-semibold text-blue-800 mb-2">Prescription Summary</h2>
      {prescriptions.length === 0 ? (
        <p className="text-sm text-gray-500">No medications added.</p>
      ) : (
        <ul className="text-sm">
          {prescriptions.map((med, index) => (
            <li key={index} className="mb-2">
              <span className="font-semibold">{med.name}:</span>
              <ul className="ml-4 list-disc">
                {med.selectedDosages.map((dosage, i) => (
                  <li key={i}>
                    {`${dosage.amount} - $${med.unit_price}
                    (${dosage.default_duration} days, ${dosage.frequency})`}
                  </li>
                ))}
              </ul>
            </li>
          ))}
        </ul>
      )}
        <div className="mt-4 text-lg font-bold">
        Total Cost: <span className={totalCost > budget ? "text-red-600" : "text-green-600"}>${totalCost.toFixed(2)}</span>
      </div>
    </div>
  );
};

export default CostSummary;
