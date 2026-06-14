DROP TABLE IF EXISTS healthcare.fact_encounter;

CREATE TABLE healthcare.fact_encounter AS
SELECT
    encounter_id,
    patient_id,
    encounter_class,
    status,
    start_date,
    end_date,
    service_provider_id

FROM raw_encounter;