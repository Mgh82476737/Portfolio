# 🧹 Customer Orders - Data Cleaning Project

## 🎯 Objective
The goal of this project is to demonstrate core data cleaning skills on a simulated customer orders dataset. The dataset contains various types of common data issues, including missing values, incorrect formats, duplicates, and outliers.

## 📦 Dataset Overview
The dataset includes the following columns:
- `Order ID`: Unique identifier (with some missing)
- `Customer Name`: Contains inconsistent casing and duplicates
- `Order Date`: Dates in mixed formats
- `Product Price`: Includes negative values
- `Quantity`: Includes missing and abnormal entries
- `Shipping Address`: Incomplete or null values

## 🛠️ Cleaning Tasks Performed
- Detect and handle missing values
- Convert date formats to a consistent type
- Remove duplicates
- Handle invalid values (e.g. negative prices)
- Normalize text (e.g. name casing)
- Generate cleaned version of the dataset

## 📁 Folder Structure
```
data/
    raw_customer_orders.csv
    clean_customer_orders.csv

notebooks/
    Data_Cleaning_Customer_Orders.ipynb

README.md
requirements.txt
```

## ✅ Outcome
A cleaned version of the customer order dataset is prepared and ready for analysis or visualization. This project reflects essential data wrangling steps needed in real-world datasets.

