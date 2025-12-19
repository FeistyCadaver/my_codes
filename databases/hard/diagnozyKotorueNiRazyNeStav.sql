SELECT 
    d.diagnosis_id AS 'ID диагноза',
    d.d_name AS 'Наименование диагноза',
    d.category AS 'Категория диагноза'
FROM diagnosis d
LEFT JOIN appointment a ON d.diagnosis_id = a.diagnosis_id
WHERE a.diagnosis_id IS NULL
ORDER BY d.d_name;
