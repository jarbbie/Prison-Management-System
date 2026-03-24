SELECT
    EXTRACT(YEAR FROM rs.routines_schedule_date) AS inspection_year,
    EXTRACT(MONTH FROM rs.routines_schedule_date) AS inspection_month,
    ir.type AS irregularity_type,
    COUNT(*) AS total_incidents
FROM routinesschedule rs
JOIN inspection i ON i.routine_id = rs.id
JOIN inspectionresult irr ON irr.inspection_id = i.id
JOIN irregularity ir ON ir.id = irr.found_irregularity_id
WHERE rs.routines_schedule_date BETWEEN :'start_date' AND :'end_date'
GROUP BY
    EXTRACT(YEAR FROM rs.routines_schedule_date),
    EXTRACT(MONTH FROM rs.routines_schedule_date),
    ir.type
ORDER BY inspection_year, inspection_month, ir.type;