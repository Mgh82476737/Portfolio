# 📰 Fake News Classifier using NLP and Deep Learning

## 🎯 Project Objective
The primary objective of this project is to build a classification model that distinguishes between real and fake news articles. The project compares the performance of several models including Logistic Regression (traditional machine learning), and deep learning methods such as LSTM and Bi-LSTM. After collecting data from various online sources and preprocessing it, the models were trained and evaluated. The best-performing model achieved an accuracy of **98%**, confirming its effectiveness in detecting fake news with high reliability.

## 🛠️ Techniques & Models Used

### 🔹 Data Preparation
- Merged datasets of real and fake news
- Preprocessing: removing stopwords and punctuation
- Feature extraction: TF-IDF, N-grams, sentiment scores, and word counts

### 🔹 Traditional ML Models
- Logistic Regression (Best performing with 96.5% accuracy)
- Decision Tree
- K-Nearest Neighbors (KNN)
- Naive Bayes

### 🔹 Deep Learning Models
- LSTM (Long Short-Term Memory)
- Bi-LSTM (Bidirectional LSTM)
- Accuracy for both LSTM and Bi-LSTM: ~98%

## 📊 Exploratory Data Analysis (EDA)
- Distribution of fake vs. real news
- Word frequency analysis (uni-grams, bi-grams, tri-grams)
- Word clouds for both fake and real news
- Time-series trends

## 📁 Folder Structure
```
notebooks/
    Fake_News_Classifier.ipynb

report/
    Fake News Classifier.pdf

README.md
requirements.txt
```

## ✅ Outcome
The results indicate that **LSTM**, **Bi-LSTM**, and **Logistic Regression** models performed best in detecting fake versus real news, each achieving similarly high accuracy. Among deep learning models, both LSTM and Bi-LSTM demonstrated identical behavior during training and converged at the same pace across epochs. This consistency highlights their reliability and robustness for text classification tasks. The comparison confirms that deep learning methods are competitive with traditional approaches in handling natural language-based fake news detection.


