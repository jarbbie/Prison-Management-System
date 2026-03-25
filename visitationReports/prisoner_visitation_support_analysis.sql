-- Report: Visitation Analysis per Prisoner
-- by Suwiwat

SELECT
    pr.code AS prisoner_code,
    pr.evaluation_score,
    SUM(v.duration) AS total_visitation_duration,
    COUNT(DISTINCT vli.person_id) AS unique_visitor_count
FROM Prisoner pr
LEFT JOIN Visitment v
    ON v.prisoner_id = pr.id
   AND v.status = 'completed'
LEFT JOIN VisitmentLineItem vli
    ON vli.visitment_id = v.id
GROUP BY pr.id, pr.code, pr.evaluation_score
ORDER BY total_visitation_duration DESC NULLS LAST;
