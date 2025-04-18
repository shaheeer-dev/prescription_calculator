import { clsx } from "clsx";
import { twMerge } from "tailwind-merge"

export function cn(...inputs) {
  return twMerge(clsx(inputs));
}

export const getFrequency = (frequency) => {
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
