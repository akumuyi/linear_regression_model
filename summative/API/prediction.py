from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import pandas as pd
from typing import Literal
import os

# Initialize FastAPI app
app = FastAPI(title="Energy Efficiency Prediction API", description="Predicts building heating load")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all for testing; restrict in production
    allow_credentials=True,
    allow_methods=["POST"],
    allow_headers=["*"],
)

# Define input data model with Pydantic
class BuildingInput(BaseModel):
    X1: float = Field(..., ge=0.62, le=0.98, description="Relative Compactness")
    X2: float = Field(..., ge=514.5, le=808.5, description="Surface Area (m²)")
    X3: float = Field(..., ge=245.0, le=416.5, description="Wall Area (m²)")
    X4: float = Field(..., ge=110.25, le=220.5, description="Roof Area (m²)")
    X5: float = Field(..., ge=3.5, le=7.0, description="Overall Height (m)")
    X6: Literal[2, 3, 4, 5] = Field(..., description="Orientation (2=North, 3=East, 4=South, 5=West)")
    X7: float = Field(..., ge=0.0, le=0.4, description="Glazing Area")
    X8: Literal[0, 1, 2, 3, 4, 5] = Field(..., description="Glazing Area Distribution (0=None, 1-5=Patterns)")

# Load the pre-trained model (relative to API folder)
model_path = os.path.join(os.path.dirname(__file__), "best_model.pkl")
model = joblib.load(model_path)

# Define the prediction endpoint
@app.post("/predict")
def predict(data: BuildingInput):
    # Convert Pydantic model to DataFrame
    input_dict = data.dict()
    input_df = pd.DataFrame([input_dict])
    # Ensure column order matches training data
    input_df = input_df[["X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8"]]
    # Make prediction
    prediction = model.predict(input_df)[0]
    # Return as JSON
    return {"heating_load": float(prediction)}

# Run locally for testing
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)