USE bolnica;
GO

CREATE VIEW vw_full AS
SELECT 
    p.patient_name AS 'Пациент',
    p.date_of_birth AS 'Дата рождения',
    p.adres AS 'Адрес',
    p.gender AS 'Пол',
    p.discount_on_service AS 'Скидка %',
FROM patient p;
    a.session_date AS 'Дата приема',
    a.purpose_visit AS 'Цель визита',
    a.visit_cost AS 'Стоимость приема',
FROM appointment a;
    d.d_name AS 'Врач',
    d.spec AS 'Специализация',
    d.category AS 'Категория врача',
FROM doctor d;
    diag.d_name AS 'Диагноз',
    diag.category AS 'Категория диагноза'
FROM diagnosis diag;



INNER JOIN appointment a ON p.mk_number = a.patient_mk_number
INNER JOIN doctor d ON a.doctor_id = d.doctor_id
INNER JOIN diagnosis diag ON a.diagnosis_id = diag.diagnosis_id;
GO