SELECT
    rs.routines_schedule_date AS inspection_date,
    pl.name AS location_name,
    ir.type AS irregularity_type,
    ir.description AS irregularity_description,
    irr.result_description AS specific_findings,
    i.reason AS inspection_reason
FROM routinesschedule rs
JOIN prisonlocation pl ON rs.prison_location_id = pl.id
JOIN inspection i ON i.routine_id = rs.id
JOIN inspectionresult irr ON irr.inspection_id = i.id
JOIN irregularity ir ON ir.id = irr.found_irregularity_id
WHERE rs.routines_schedule_date BETWEEN :'start_date' AND :'end_date'
ORDER BY rs.routines_schedule_date;