# 🧪 Outlier Detection in Winner Price

## 📌 Project Goal
This project focuses on detecting and handling outliers in the `winner_price` column to ensure the data is clean and reliable for machine learning pipelines.

## 📊 Steps Performed
- Initial descriptive statistics of the dataset
- Outlier detection using:
  - BoxPlot and KDE
  - IQR method
- Two approaches applied:
  - **Trimming:** Remove extreme values completely
  - **Capping:** Limit extreme values within an acceptable range

## 🛠️ Tools & Libraries Used
- Python
- pandas, numpy
- matplotlib, seaborn

## 📁 Folder Structure
```
data/
    Data.csv

notebooks/
    Outlier_Analysis_Clean.ipynb

README.md
requirements.txt
```

## ✅ Outcome
Both trimming and capping were applied to prepare the dataset for downstream machine learning models, maintaining either accuracy or completeness depending on the method used.
