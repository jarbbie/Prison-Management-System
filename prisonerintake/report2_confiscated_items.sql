-- list confiscated items for each intake
-- by Phurithip Paisanworajit

SELECT 
    p.code,
    pi.intake_date,
    ci.item_name,
    ci.quantity,
    ci.remarks
FROM confiscateditem ci
JOIN prisonerintake pi 
    ON ci.prisonerintake_id = pi.id
JOIN prisoner p 
    ON p.prison_intake_id = pi.id;