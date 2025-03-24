# Building Energy Efficiency Prediction

[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Flutter](https://img.shields.io/badge/flutter-3.0+-blue.svg)](https://flutter.dev/)
[![FastAPI](https://img.shields.io/badge/fastapi-0.68+-green.svg)](https://fastapi.tiangolo.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A complete solution for predicting building heating loads based on architectural features. This project includes a machine learning model, a REST API for serving predictions, and a mobile application for end users.

## Table of Contents
- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Features](#features)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Data Exploration](#data-exploration)
- [Model Training](#model-training)
- [API Service](#api-service)
- [Mobile Application](#mobile-application)
- [Video Presentation](#video-presentation)
- [Development Setup](#development-setup)
- [Contributing](#contributing)
- [License](#license)

## Overview

This project predicts the heating load requirements for buildings based on specific characteristics such as surface area, wall area, roof area, and other architectural features. By leveraging machine learning, it provides a practical tool for energy efficiency analysis in building design.

## Technologies Used

- **Python 3.8+**
  - scikit-learn
  - pandas
  - numpy
  - FastAPI
  - Pydantic
- **Flutter 3.0+**
  - Material Design
  - HTTP package
  - Provider for state management
- **Machine Learning**
  - scikit-learn
  - Random Forest
  - Decision Trees
  - Linear Regression

## Features

- **Machine Learning Models**
  - Multiple model comparison
  - Automated model selection
  - Model persistence
- **API Service**
  - RESTful endpoints
  - Input validation
  - CORS support
  - Swagger documentation
- **Mobile Application**
  - Clean, intuitive UI
  - Real-time predictions
  - Error handling
  - Input validation

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [UCI Machine Learning Repository](https://archive.ics.uci.edu/) for providing the Energy Efficiency dataset
- [FastAPI](https://fastapi.tiangolo.com/) for the excellent web framework
- [Flutter](https://flutter.dev/) for the cross-platform UI framework
