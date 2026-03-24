SELECT
    o.code AS officer_code,
    CONCAT(p.first_name, ' ', p.last_name) AS officer_name,
    rs.routines_schedule_date AS schedule_date,
    rs.routine_name,
    rs.type AS routine_type,
    pl.name AS location_name
FROM officer o
JOIN person p ON p.id = o.person_id
JOIN routinesofficer ro ON ro.officer_id = o.id
JOIN routinesschedule rs ON rs.id = ro.routine_id
JOIN prisonlocation pl ON pl.id = rs.prison_location_id
ORDER BY o.code, rs.routines_schedule_date;