from joblib import load
import numpy as np
import pandas as pd

# Load the model and scaler
model = load('best_model.joblib')
scaler = load('scaler.joblib')

def predict_next_close(last_5_days):
    """
    Predict the next day's closing price given the last 5 days' OHLC and Volume data.
    Input: DataFrame with columns ['Date', 'Open', 'High', 'Low', 'Close', 'Volume']
    """
    # Ensure input has exactly 5 days
    if len(last_5_days) != 5:
        raise ValueError("Input must contain exactly 5 days of data")

    # Extract features in the correct order (lag5 to lag1)
    features = []
    for i in range(4, -1, -1):  # From oldest (t-4) to newest (t)
        day = last_5_days.iloc[i]
        features.extend([day['Open'], day['High'], day['Low'], day['Close'], day['Volume']])

    # Convert to numpy array and reshape for prediction
    features = np.array(features).reshape(1, -1)

    # Scale the features
    features_scaled = scaler.transform(features)

    # Make prediction
    prediction = model.predict(features_scaled)
    return prediction[0]

# Example usage
if __name__ == "__main__":
    # Sample input: last 5 days from the dataset (e.g., 2025-03-17 to 2025-03-21)
    sample_data = pd.DataFrame({
        'Date': pd.to_datetime(['2025-03-17', '2025-03-18', '2025-03-19', '2025-03-20', '2025-03-21']),
        'Open': [1.08794, 1.0918, 1.09386, 1.09116, 1.08535],
        'High': [1.09297, 1.09545, 1.09449, 1.09171, 1.08611],
        'Low': [1.08685, 1.08924, 1.08603, 1.08145, 1.0797],
        'Close': [1.0918, 1.09385, 1.09115, 1.08532, 1.08121],
        'Volume': [135357, 169593, 172839, 162746, 155295]
    })
    pred = predict_next_close(sample_data)
    print(f"Predicted next closing price for 2025-03-22: {pred:.5f}")
    