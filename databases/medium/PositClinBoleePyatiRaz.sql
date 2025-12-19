SELECT 
    p.patient_name AS 'Пациент',
    COUNT(a.ticket_id) AS 'Количество посещений'
FROM patient p
INNER JOIN appointment a ON p.mk_number = a.patient_mk_number
GROUP BY p.patient_name, p.mk_number
HAVING COUNT(a.ticket_id) > 5
ORDER BY COUNT(a.ticket_id) DESC;
