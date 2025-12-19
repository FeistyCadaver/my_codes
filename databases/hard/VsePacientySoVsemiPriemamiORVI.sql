SELECT 
    p.mk_number AS 'Номер МК',
    p.patient_name AS 'Пациент',
    COUNT(a.ticket_id) AS 'Количество приемов'
FROM patient p
INNER JOIN appointment a ON p.mk_number = a.patient_mk_number
INNER JOIN diagnosis d ON a.diagnosis_id = d.diagnosis_id
WHERE d.d_name = 'ОРВИ'
    AND p.mk_number NOT IN (
        SELECT DISTINCT a2.patient_mk_number 
        FROM appointment a2 
        INNER JOIN diagnosis d2 ON a2.diagnosis_id = d2.diagnosis_id
        WHERE d2.d_name != 'ОРВИ'
    )
GROUP BY p.mk_number, p.patient_name
HAVING COUNT(a.ticket_id) > 0;

