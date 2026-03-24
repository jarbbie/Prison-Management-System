-- Visitation Analysis per Prisoner
-- by Suwiwat

WITH visit_duration AS (
    SELECT
        v.prisoner_id,
        SUM(v.duration) AS total_visitation_duration,
        COUNT(v.id) AS total_visitment_count
    FROM Visitment v
    WHERE v.status = 'completed'
    GROUP BY v.prisoner_id
),
unique_visitors AS (
    SELECT
        v.prisoner_id,
        COUNT(DISTINCT vli.person_id) AS unique_visitor_count
    FROM Visitment v
JOIN VisitmentLineItem vli
        ON vli.visitment_id = v.id
    WHERE v.status = 'completed'
    GROUP BY v.prisoner_id
)
SELECT
    pr.id AS prisoner_id,
    pr.code AS prisoner_code,
    pr.evaluation_score,
    COALESCE(vd.total_visitation_duration, 0) AS total_visitation_duration,
    COALESCE(vd.total_visitment_count, 0) AS total_visitment_count,
    COALESCE(uv.unique_visitor_count, 0) AS unique_visitor_count
FROM Prisoner pr
LEFT JOIN visit_duration vd
    ON vd.prisoner_id = pr.id
LEFT JOIN unique_visitors uv
    ON uv.prisoner_id = pr.id
ORDER BY total_visitation_duration DESC, unique_visitor_count DESC;