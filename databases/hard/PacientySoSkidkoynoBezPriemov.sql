SELECT 
    p.mk_number AS 'Номер МК',
    p.patient_name AS 'Пациент',
    p.discount_on_service AS 'Скидка (%)',
    p.date_of_birth AS 'Дата рождения'
FROM patient p
WHERE p.discount_on_service > 0
    AND NOT EXISTS (
        SELECT 1 
        FROM appointment a 
        WHERE a.patient_mk_number = p.mk_number
            AND YEAR(a.session_date) = 2024
    )
ORDER BY p.discount_on_service DESC;

