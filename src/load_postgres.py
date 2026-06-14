import os
import pandas as pd
from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

PATIENT_PATH = os.path.join(BASE_DIR, "data", "processed", "fhir", "patient.csv")
ENCOUNTER_PATH = os.path.join(BASE_DIR, "data", "processed", "fhir", "encounter.csv")
CONDITION_PATH = os.path.join(BASE_DIR, "data", "processed", "fhir", "condition.csv")

DB_USER = "your_username"
DB_PASSWORD = "your_password"
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "healthcare_analytics"

encoded_password = quote_plus(DB_PASSWORD)

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{encoded_password}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )
    
print("Connecting to PostgresSQL...")

def load_table(csv_path, table_name):

    print(f"Loading {table_name} from {csv_path}")

    if not os.path.exists(csv_path):
        raise FileNotFoundError(f"File not found: {csv_path}")

    df = pd.read_csv(csv_path)

    print(f"{table_name} shape: {df.shape}")

    df.to_sql(table_name, engine, if_exists="replace", index=False)

    # ETL Logging
    with engine.begin() as conn:
        conn.execute(
            text("""
                INSERT INTO etl_log
                (
                    load_timestamp,
                    table_name,
                    records_loaded
                )
                VALUES
                (
                    NOW(),
                    :table_name,
                    :records
                )
            """),
            {
                "table_name": table_name,
                "records": len(df)
            }
        )

    print(f"{table_name} loaded successfully.\n")


def main():
    load_table(PATIENT_PATH, "raw_patient")
    load_table(ENCOUNTER_PATH, "raw_encounter")
    load_table(CONDITION_PATH, "raw_condition")
    print("All tables loaded to Postgres successfully.")


if __name__ == "__main__":
    main()


