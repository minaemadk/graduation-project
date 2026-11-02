# main.py
from fastapi import FastAPI
from users import router as users_router

app = FastAPI(title="Backend Project API", version="1.0")


app.include_router(users_router)


@app.get("/")
def read_root():
  return {"message": "Welcome to the Backend API Task!"}