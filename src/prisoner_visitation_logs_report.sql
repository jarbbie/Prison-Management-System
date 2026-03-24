-- Visitation Logs for Each Prisoner
-- by Suwiwat

SELECT
    pr.code AS prisoner_code,
    v.visitment_date,
    v.duration,
    v.description,
    pe.first_name AS visitor_first_name,
    pe.last_name AS visitor_last_name
FROM Visitment v
JOIN Prisoner pr
    ON pr.id = v.prisoner_id
JOIN VisitmentLineItem vli
    ON vli.visitment_id = v.id
JOIN Person pe
    ON pe.id = vli.person_id
ORDER BY pr.code, v.visitment_date DESC, pe.first_name, pe.last_name;