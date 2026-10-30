
import os

from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
from sqlalchemy.orm import sessionmaker

connection_url = URL.create(
    "mssql+mssqlpython",
    host=os.getenv("DB_HOST", "DESKTOP-4D9N2TE"),
    database=os.getenv("DB_NAME", "DocVerifyDb"),
    query={
        "trusted_connection": "yes",
        "TrustServerCertificate": "yes",
    },
)

engine = create_engine(connection_url, pool_pre_ping=True)

SessionLocal = sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False,
)


def test_connection():
    with engine.connect() as connection:
        return connection.execute(text("SELECT 1")).scalar_one()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
