SELECT
    d.d_name AS 'Врач',
    d.spec AS 'Специальность',
    COUNT(a.ticket_id) AS 'Количество приемов'
FROM doctor d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.d_name, d.spec
ORDER BY COUNT(a.ticket_id) DESC, d.d_name;

