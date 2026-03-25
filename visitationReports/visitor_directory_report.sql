-- Report: Registered Visitors' Contact and Demographic Information
-- by Suwiwat

SELECT DISTINCT
    p.first_name,
    p.last_name,
    p.gender,
    p.contact_no,
    p.blood_type
FROM VisitmentLineItem vli
JOIN Person p
    ON p.id = vli.person_id
ORDER BY p.first_name, p.last_name;