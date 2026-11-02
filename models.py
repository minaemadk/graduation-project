# models.py
from datetime import datetime
from sqlalchemy import Column, DateTime, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class User(Base):
  __tablename__ = "users"

  user_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
  username = Column(String(50), unique=True, index=True, nullable=False)
  email = Column(String(100), unique=True, index=True, nullable=False)
  hashed_password = Column(String(255), nullable=False)
  created_at = Column(DateTime, default=datetime.utcnow)