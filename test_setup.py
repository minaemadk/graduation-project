
from database import engine, SessionLocal, get_db

print("Database module loaded successfully")

if engine is None:
    print("Database URL is not configured yet")
else:
    print("Database engine is configured")

if SessionLocal is None:
    print("Database session is waiting for configuration")
else:
    print("Database session is ready")
