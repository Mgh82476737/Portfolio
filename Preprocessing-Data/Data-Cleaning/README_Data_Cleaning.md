# 🧹 Customer Orders - Data Cleaning Project

## 🎯 Objective
The goal of this project is to demonstrate core data cleaning skills on a simulated customer orders dataset. The dataset contains various types of common data issues, including missing values, incorrect formats, duplicates, and outliers.

## 📦 Dataset Overview
The dataset includes the following columns:
- `Order ID`: Unique identifier (with some missing)
- `Customer Name`: Contains inconsistent casing and full name in a single field
- `Order Date`: Dates in mixed formats
- `Product Price`: Includes negative values
- `Quantity`: Includes missing and abnormal entries
- `Shipping Address`: Incomplete or null values

## 🧹 Data Issues and Cleaning Solutions

| Problem Type           | Column             | Description                                                                 | Cleaning Approach                          |
|------------------------|--------------------|-----------------------------------------------------------------------------|--------------------------------------------|
| Missing Values         | Order ID           | Some records had no order ID (critical field)                              | Dropped rows with missing Order ID         |
| Missing Values         | Shipping Address   | Incomplete or null address                                                  | Dropped rows with missing address          |
| Missing Values         | Quantity           | Some records had missing product quantity                                  | Filled with median quantity                |
| Inconsistent Formatting| Customer Name      | Mixed casing and full name in one column                                   | Normalized casing and split into two fields|
| Incorrect Data Types   | Order Date         | Stored as string in DD/MM/YYYY format                                      | Converted to datetime                      |
| Invalid Values         | Product Price      | Some prices were negative                                                  | Removed rows with negative prices          |
| Duplicates             | All Columns        | Some fully duplicated rows                                                 | Removed using `drop_duplicates()`          |

Each of these issues is addressed step-by-step in the notebook to produce a clean dataset ready for further analysis.

## 🛠️ Cleaning Tasks Performed
- Detect and handle missing values
- Convert date formats to a consistent type
- Remove duplicates
- Handle invalid values (e.g. negative prices)
- Normalize text (e.g. name casing)
- Split customer full name into `First Name` and `Last Name`
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
A cleaned version of the customer order dataset is prepared and ready for analysis or visualization. This project reflects essential data wrangling steps needed in real-world datasets, including customer name parsing and value normalization.
