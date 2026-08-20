# adhere-ml-r-datascience
# ADHERE-ML: Behavioral Persona Segmentation & Non-Adherence Risk Prediction

## 📌 Project Overview
Chronic disease non-adherence leads to approximately $300 billion in annual avoidable healthcare costs. Standard models treat patients as a single uniform group, ignoring socio-demographic and behavioral nuances. **ADHERE-ML** utilizes a behavioral data science approach to clean healthcare appointment data, perform Exploratory Data Analysis (EDA) in R, segment patients into socio-behavioral personas, and predict non-adherence risk.

## 📁 Repository Structure
- `data/processed/`: Contains the cleaned and transformed dataset `cleaned_medical_appointments.csv`.
- `src/`: R scripts for data cleaning, feature engineering, and `ggplot2` visualizations.
- `docs/`: Formal academic project proposal and review reports.

## 🛠️ Data Preprocessing Pipeline
1. **Target Binary Encoding:** Converted `No-show` strings to binary targets (`NoShow_Binary`: `1` = No-Show, `0` = Attended).
2. **Column Standardizations:** Corrected typos and naming conventions (`PatientId` → `PatientID`, `Hipertension` → `Hypertension`, `Handcap` → `Handicap`).
3. **Temporal Processing:** Extracted `ScheduledDate` and `AppointmentDate` to derive lead time (`WaitTime` in days).
4. **Data Cleansing:** Removed negative wait times (`WaitTime < 0`) and invalid age entries (`Age < 0` or `Age > 100`).
5. **Outlier Filtering:** Applied 1.5 × IQR trimming on `WaitTime` to eliminate distribution skewness.

## 📊 Exploratory Data Analysis (EDA)
Key insights derived from R `ggplot2` visualizations:
- **Lead Time Effect:** Patients who missed appointments had a median wait time of 8 days compared to 2 days for attending patients.
- **Age Profile:** Younger cohorts (ages 18–35) demonstrate higher non-attendance density relative to older demographics.
- **Linear Correlation:** Low global Pearson correlation across individual predictors justifies transitioning to non-linear ensemble models and clustering techniques in subsequent project phases.

## 💻 How to Run
1. Clone this repository:
   ```bash
   git clone [https://github.com/YOUR-USERNAME/adhere-ml-r-datascience.git](https://github.com/YOUR-USERNAME/adhere-ml-r-datascience.git)
