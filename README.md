# Building Energy Efficiency Prediction

A complete solution for predicting building heating loads based on architectural features. This project includes a machine learning model, a REST API for serving predictions, and a mobile application for end users.

## Table of Contents
- [Overview](#overview)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Data Exploration](#data-exploration)
- [Model Training](#model-training)
- [API Service](#api-service)
- [Mobile Application](#mobile-application)
- [Video Presentation](#video-presentation)
- [Development Setup](#development-setup)

## Overview

This project predicts the heating load requirements for buildings based on specific characteristics such as surface area, wall area, roof area, and other architectural features. By leveraging machine learning, it provides a practical tool for energy efficiency analysis in building design.

## Dataset

The project uses the Energy Efficiency dataset from the UCI Machine Learning Repository:
- **Source**: [UCI Machine Learning Repository Energy Efficiency Dataset](https://archive.ics.uci.edu/dataset/242/energy+efficiency)
- **Size**: 768 samples
- **Features**: 8 variables
  - Relative compactness
  - Surface area
  - Wall area
  - Roof area
  - Overall height
  - Orientation
  - Glazing area
  - Glazing area distribution
- **Target**: Heating load (Y1) and cooling load (Y2)
- **Citation**: Tsanas, A. & Xifara, A. (2012). Energy Efficiency [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C51307

## Project Structure

```
linear_regression_model/
├── summative/
│   ├── linear_regression/
│   │   └── multivariate.ipynb
│   ├── API/
│   │   ├── prediction.py
│   │   ├── best_model.pkl
│   │   └── requirements.txt
│   └── energy_prediction_app/
│       ├── lib/
│       │   ├── main.dart
│       │   └── screens/
│       │       ├── home_page.dart
│       │       └── prediction_page.dart
│       └── pubspec.yaml
└── README.md
```

## Data Exploration

The project includes comprehensive data visualization:

### Correlation Heatmap
- Displays relationships between features and heating load
- Identifies key predictors and feature interactions
- Guides feature selection for model development

### Variable Distributions
- Scatterplots showing feature relationships
- Outlier detection and data quality assessment

## Model Training

### Implemented Models
1. **Linear Regression**
   - Baseline model for continuous prediction
   - Scatter plot visualization of actual vs. predicted values

2. **Random Forest Regressor**
   - Captures non-linear relationships
   - Handles feature interactions

3. **Decision Tree Regressor**
   - Provides interpretable decision rules
   - Baseline for ensemble methods

### Model Evaluation
- Mean Squared Error (MSE) comparison
- Best model saved as `best_model.pkl`
- Single test sample prediction demonstration

## API Service

### Features
- FastAPI-based REST API
- Input validation with Pydantic
- CORS middleware support
- Swagger UI documentation

### Endpoints
- POST `https://energy-prediction-00ed.onrender.com/predict`: Accepts building parameters and returns heating load prediction

### Setup
```bash
cd summative/API
pip install -r requirements.txt
python prediction.py
```

### Documentation
Swagger UI available at: `https://energy-prediction-00ed.onrender.com/docs`

## Mobile Application

### Features
- User-friendly interface
- Input validation
- Real-time prediction display
- Error handling

### Setup
```bash
cd summative/energy_prediction_app
flutter pub get
flutter run
```


## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/akumuyi/linear_regression_model.git
cd linear_regression_model
```

2. Set up Python environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
cd summative/API
pip install -r requirements.txt
```

3. Install Flutter dependencies:
```bash
cd ../energy_prediction_app
flutter pub get
```

4. Run the application:
- Start the API server
- Launch the Flutter app
- Test the complete system
