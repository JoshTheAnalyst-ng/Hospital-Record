import os
import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine, String, Date

# ---------- CHANGE THESE THREE ----------
FOLDER = r"C:\Users\Ihimire Joshua\Desktop\Hospital Record"   # folder that holds the 4 CSV files
DATABASE = "hospital_record"          # must already exist in MySQL
PASSWORD = "Josh10109##"             # your MySQL password
# ----------------------------------------

USER = "root"
HOST = "localhost"
PORT = 3306

engine = create_engine(
    f"mysql+pymysql://{USER}:{quote_plus(PASSWORD)}@{HOST}:{PORT}/{DATABASE}"
)

DATE_COLUMNS = {"birth_date", "admission_date", "discharge_date"}

for file in sorted(os.listdir(FOLDER)):
    if not file.lower().endswith(".csv"):
        continue

    table = os.path.splitext(file)[0]          # patients.csv -> patients
    df = pd.read_csv(os.path.join(FOLDER, file))

    dtypes = {}
    for col in df.columns:
        if col in DATE_COLUMNS:
            df[col] = pd.to_datetime(df[col]).dt.date
            dtypes[col] = Date()                # real DATE columns
        elif df[col].dtype == object:
            dtypes[col] = String(50)            # VARCHAR so it can be indexed

    df.to_sql(table, engine, if_exists="replace", index=False,
              dtype=dtypes, chunksize=5000)
    print(f"Loaded {table}: {len(df)} rows")

print("Done.")
