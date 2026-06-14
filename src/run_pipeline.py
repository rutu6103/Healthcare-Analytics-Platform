import subprocess
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

scripts = [
    "extract_fhir.py",
    "transform_patient.py",
    "transform_encounter.py",
    "transform_condition.py",
    "load_postgres.py"
]

for script in scripts:
    script_path = os.path.join(BASE_DIR, script)

    print(f"Running {script}")

    subprocess.run(
        ["python", script_path],
        check=True
    )

print("Pipeline Completed")