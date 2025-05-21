# 🎬 Netflix Content Insights

## 🎯 Objective
The aim of this project is to clean and explore Netflix content data for business insights. This includes understanding the type, distribution, release trends, country-wise contributions, and other content metadata like rating, genre, and duration.

## 📦 Dataset Overview
The dataset includes information on:
- Title, Type (Movie/TV Show)
- Director and Cast
- Country and Date Added
- Release Year and Rating
- Duration and Listed Genres

## 🧹 Cleaning & Exploration Steps
- Convert `date_added` to datetime
- Extract `year_added` and `month_added`
- Analyze counts of content types over time
- Visualize top countries, genres, and content duration
- Prepare data for potential dashboarding or business recommendations

## 📁 Folder Structure
```
data/
    netflix1.csv

notebooks/
    Netflix_Analysis_Initial.ipynb

README.md
requirements.txt
```

## ✅ Outcome
Cleaned and organized Netflix data ready for business analytics, including time trends and content segmentation.
