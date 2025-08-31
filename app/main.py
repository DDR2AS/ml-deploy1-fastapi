from fastapi import FastAPI
import numpy as np
from pydantic import BaseModel
import pickle

app = FastAPI()
model_predict = pickle.load(open("app/train-model/model.pkl", "rb"))


class Model(BaseModel):
    age_experience: float

@app.get("/")
def main():
    return "Welcome to Machine Learning FastAPI"

# Request body
@app.post("/api/")
def model(api: Model):
    # Import the saved model
    user_salary = model_predict.predict([[np.array(api.age_experience)]])

    return {"Salary ": int(user_salary)}


# Query parameters
@app.post("/api/{age_experience}")
def model(age_experience: float):
    # Import the saved model
    user_salary = model_predict.predict([[np.array(age_experience)]])
    salary_integer = int(user_salary)

    return {"Salary ": salary_integer}
