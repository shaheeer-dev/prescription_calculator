const getFrequency = (frequency) => {
  switch (frequency.toLowerCase()) {
    case "once daily":
      return 1;
    case "twice daily":
      return 2;
    case "once weekly":
      return 1 / 7;
    default:
      return 1;
  }
}

export { getFrequency };