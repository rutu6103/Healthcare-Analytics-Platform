DROP TABLE IF EXISTS healthcare.fact_condition;

CREATE TABLE healthcare.fact_condition AS
SELECT
    condition_id,
    patient_id,
    encounter_id,
    clinical_status,
    verification_status,
    condition_code,
    condition_name,
    onset_date

FROM raw_condition;