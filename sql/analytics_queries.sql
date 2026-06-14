-- Top Cities

SELECT
    city,
    COUNT(*) AS patient_count
FROM dim_patient
GROUP BY city
ORDER BY patient_count DESC;

-- Repeat Patient
SELECT
    patient_id,
    COUNT(*) AS encounter_count
FROM fact_encounter
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- Top Conditions
SELECT
    condition_name,
    COUNT(*) AS condition_count
FROM fact_condition
GROUP BY condition_name
ORDER BY condition_count DESC;

-- Avg Encounter Per Patient
SELECT
    ROUND(
        COUNT(*)::numeric /
        COUNT(DISTINCT patient_id),
        2
    ) AS avg_encounters_per_patient
FROM fact_encounter;