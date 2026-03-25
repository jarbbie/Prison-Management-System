-- count total confiscated items per intake
-- by Phurithip Paisanworajit

SELECT 
    pi.id,
    p.code,
    pi.intake_date,
    SUM(ci.quantity) AS total_items
FROM confiscateditem ci
JOIN prisonerintake pi 
    ON ci.prisonerintake_id = pi.id
JOIN prisoner p 
    ON p.prison_intake_id = pi.id
GROUP BY pi.id, p.code, pi.intake_date
ORDER BY total_items DESC;