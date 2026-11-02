# schemas.py
from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class UserCreate(BaseModel):
  username: str
  email: str
  password: str


class UserResponse(BaseModel):
  user_id: int
  username: str
  email: str
  created_at: datetime

  class Config:
    from_attributes = True


class UserUpdate(BaseModel):
  username: Optional[str] = None
  email: Optional[str] = None


class PasswordChange(BaseModel):
  current_password: str
  new_password: str


class ForgotPasswordRequest(BaseModel):
  email: str


class ResetPasswordRequest(BaseModel):
  token: str
  new_password: str