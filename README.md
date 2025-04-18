
# Prescription Cost Calculator

This project is a **full-stack application** consisting of a **Ruby on Rails backend** and a **React frontend**, designed to calculate the total cost of a prescription based on selected medications and their dosages. It ensures the cost does not exceed a configurable budget, and if it does, it suggests ways to reduce the cost.

---

## 🚀 Features
### Backend:
- Calculate prescription costs using predefined formulas.
- Validate cost against a configurable budget.
- Apply discounts for long-term prescriptions.
- Suggest cost reductions when exceeding the budget.
- Expose APIs for integration with a **React frontend**.

### Frontend:
- **Select Medications**: Choose medications and dosages from an available list.
- **Cost Summary**: Get an overview of the total cost of selected medications.
- **Budget Validation**: The system validates the prescription against a set budget.
- **Smart Suggestions**: If the budget is exceeded, alternative suggestions are provided.
- **Pagination**: Allows users to browse medications efficiently.

---

## 📌 Prerequisites

### Backend:
- **Ruby**: `>= 3.1.3`
- **Rails**: `>= 7.1.4`
- **Bundler**: `gem install bundler`

### Frontend:
- **Node.js** (v16+ recommended)
- **npm** or **yarn**

---

## ⚙️ Setup Instructions

### Backend Setup:
1. **Install Dependencies**
   ```bash
   bundle install
   ```

2. **Configure Database**
   ```bash
   rails db:create
   rails db:migrate
   db:seed
   ```

3. **Run Server**
   ```bash
   rails s
   ```

### Frontend Setup:
1. **Install Dependencies**
   ```bash
   npm i
   ```

2. **Run Server**
   ```bash
   npm run dev
   ```

---

## **⚙️ API Endpoints**

### 📍 **Medications**
| Method | Endpoint                         | Description |
|--------|----------------------------------|-------------|
| **GET**  | `http://127.0.0.1:3000/medications` | Fetch all medications with dosages |
| **GET**  | `http://127.0.0.1:3000/medications/1` | Fetch a specific medication |

### 📍 **Prescriptions**
| Method | Endpoint                              | Description |
|--------|--------------------------------------|-------------|
| **POST** | `http://localhost:3000/prescriptions`  | Create a new prescription & calculate cost |
| **GET**  | `http://localhost:3000/prescriptions`  | Fetch all prescriptions |
| **GET**  | `http://localhost:3000/prescriptions/1` | Fetch a specific prescription |

---
