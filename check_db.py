
from sqlalchemy import text
from database import engine, test_connection

tables = [
    "Document",
    "Driver_License",
    "Id_Card",
    "Verification",
    "Verification_Issues",
]

try:
    print("Testing database connection...")

    print("Result:", test_connection())
    print("Database connection successful!")

    with engine.connect() as connection:
        print("\n========== TABLES TEST ==========")

        result = connection.execute(text("""
            SELECT TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_SCHEMA = 'dbo'
              AND TABLE_TYPE = 'BASE TABLE'
        """))

        existing_tables = {row[0] for row in result.fetchall()}

        for table in tables:
            status = "EXISTS" if table in existing_tables else "MISSING"
            print(f"{table}: {status}")

        print("\n========== ROW COUNTS ==========")

        for table in tables:
            if table in existing_tables:
                count = connection.execute(
                    text(f"SELECT COUNT(*) FROM dbo.[{table}]")
                ).scalar_one()

                print(f"{table}: {count} rows")

except Exception as error:
    print("\nDatabase test failed:")
    print(error)

finally:
    engine.dispose()
