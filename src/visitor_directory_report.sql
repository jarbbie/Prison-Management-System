-- Registered Visitors' Contact and Demographic Information
-- by Suwiwat

SELECT DISTINCT
    p.first_name,
    p.last_name,
    p.gender,
    p.contact_no,
    p.blood_type
FROM Person p
JOIN VisitmentLineItem vli
    ON vli.person_id = p.id
ORDER BY p.first_name, p.last_name;