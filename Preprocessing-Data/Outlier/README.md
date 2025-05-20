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
    AA.csv

notebooks/
    Outlier_Analysis_Clean.ipynb

README.md
requirements.txt
```

## ✅ Outcome
The comparison between the original, trimmed, and capped distributions of `winner_price` illustrates the effects of each outlier handling method:

- **Trimming** removes outliers entirely, resulting in a more compact and possibly normal distribution, which is ideal for analyses that are sensitive to extreme values.
- **Capping**, on the other hand, truncates the distribution's tails and introduces peaks at the boundary limits. This maintains the integrity and size of the dataset but may affect how naturally the data reflects its original distribution.

Each method is suitable depending on the analytical need:
- Trimming is useful for reducing variability and preparing data for models like linear regression.
- Capping is more suitable when data loss is a concern and you need to preserve the sample size.
