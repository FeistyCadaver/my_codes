WITH doctor_stats AS (
    SELECT 
        d.doctor_id,
        d.d_name AS 'Врач',
        d.spec AS 'Специальность',
        AVG(a.visit_cost) AS avg_doctor_cost,
        COUNT(a.ticket_id) AS visit_count
    FROM doctor d
    LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
    WHERE a.visit_cost IS NOT NULL
    GROUP BY d.doctor_id, d.d_name, d.spec
    HAVING COUNT(a.ticket_id) > 0
),
overall_avg AS (
    SELECT AVG(visit_cost) AS overall_avg_cost
    FROM appointment
    WHERE visit_cost IS NOT NULL
)
SELECT 
    ds.doctor_id AS 'ID врача',
    ds.Врач,
    ds.Специальность,
    ROUND(ds.avg_doctor_cost, 2) AS 'Средняя стоимость врача',
    ROUND(oa.overall_avg_cost, 2) AS 'Общая средняя стоимость',
    ds.visit_count AS 'Количество приемов'
FROM doctor_stats ds
CROSS JOIN overall_avg oa
WHERE ds.avg_doctor_cost > oa.overall_avg_cost
ORDER BY ds.avg_doctor_cost DESC;

