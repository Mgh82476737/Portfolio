# 🧪 Outlier Detection in Winner Price

## 📌 هدف پروژه
در این پروژه ستون `winner_price` برای شناسایی و حذف مقادیر پرت بررسی شده تا این داده‌ها برای مدل‌های یادگیری ماشین قابل اعتماد باشند.

## 📊 مراحل انجام شده
- بررسی آماری اولیه داده‌ها
- شناسایی Outlier با استفاده از:
  - BoxPlot و KDE
  - روش IQR
- اعمال دو رویکرد:
  - **Trimming:** حذف کامل مقادیر پرت
  - **Capping:** محدود کردن مقادیر پرت به محدوده قابل قبول

## 🛠️ ابزارها و کتابخانه‌ها
- Python
- Pandas, NumPy
- Matplotlib, Seaborn

## 📁 ساختار پوشه‌ها
```
data/
    AA.csv

notebooks/
    Outlier_Analysis.ipynb

README.md
requirements.txt
```

## 📌 نتیجه‌گیری
هر دو رویکرد trimming و capping اجرا شده‌اند تا داده‌های نهایی آماده استفاده در مدل‌های یادگیری ماشین شوند.
