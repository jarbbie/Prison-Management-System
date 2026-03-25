-- show all prisoner intake records
-- by Phurithip Paisanworajit

SELECT 
    p.code,
    pe.first_name || ' ' || pe.last_name AS name,
    pi.intake_date,
    pi.initial_health_status
FROM prisoner p
JOIN person pe ON p.person_id = pe.id
JOIN prisonerintake pi ON p.prison_intake_id = pi.id;