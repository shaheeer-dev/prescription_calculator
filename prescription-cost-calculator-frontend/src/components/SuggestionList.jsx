const SuggestionList = ({ validation, onApplySuggestion }) => {
  if (!validation || validation.status !== "invalid" || !validation.suggestions?.length) return null;

  return (
    <div className="mt-4 p-4 bg-red-100 border border-red-400 rounded-md shadow-sm">
      <p className="text-red-700 font-semibold">Budget exceeded! Suggested adjustments:</p>
      {validation.suggestions.map((suggestion, index) => (
        <div key={index} className="mt-2 p-3 bg-white shadow-sm rounded-md">
          <p className="text-gray-700">
            <strong>{suggestion.medication}</strong>: Reduce from 
            <span className="text-red-600"> {suggestion.original_duration} days</span> to 
            <span className="text-green-600"> {suggestion.suggested_duration} days</span>
          </p>
          <button
            className="mt-2 px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition"
            onClick={() => onApplySuggestion(suggestion)}
          >
            Apply
          </button>
        </div>
      ))}
    </div>
  );
};

export default SuggestionList;