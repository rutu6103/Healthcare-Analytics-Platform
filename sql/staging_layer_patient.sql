DROP TABLE IF EXISTS healthcare.dim_patient;

CREATE TABLE healthcare.dim_patient AS
SELECT
    patient_id,
    gender,
    birth_date::date,
    city,
    state,
    country,
    deceased_flag,
    
    EXTRACT(
        YEAR FROM AGE(
            CURRENT_DATE,
            birth_date::date
        )
    ) AS patient_age

FROM raw_patient;