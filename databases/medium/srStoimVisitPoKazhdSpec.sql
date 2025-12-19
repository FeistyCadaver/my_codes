SELECT 
    d.spec AS 'Специальность',
    COUNT(a.ticket_id) AS 'Количество приемов',
    ROUND(AVG(a.visit_cost), 2) AS 'Средняя стоимость визита',
    MIN(a.visit_cost) AS 'Минимальная стоимость',
    MAX(a.visit_cost) AS 'Максимальная стоимость'
FROM doctor d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
WHERE a.visit_cost IS NOT NULL
GROUP BY d.spec
ORDER BY AVG(a.visit_cost) DESC;

