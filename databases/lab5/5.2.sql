USE bolnica;
GO

CREATE VIEW vw_complete_medical_records AS
SELECT 
    p.patient_name AS 'Пациент',
    p.date_of_birth AS 'Дата рождения',
    p.adres AS 'Адрес',
    p.gender AS 'Пол',
    p.discount_on_service AS 'Скидка %',
    a.session_date AS 'Дата приема',
    a.purpose_visit AS 'Цель визита',
    a.visit_cost AS 'Стоимость приема',
    d.d_name AS 'Врач',
    d.spec AS 'Специализация',
    d.category AS 'Категория врача',
    diag.d_name AS 'Диагноз',
    diag.category AS 'Категория диагноза'
FROM patient p
INNER JOIN appointment a ON p.mk_number = a.patient_mk_number
INNER JOIN doctor d ON a.doctor_id = d.doctor_id
LEFT JOIN diagnosis diag ON a.diagnosis_id = diag.diagnosis_id;
GO