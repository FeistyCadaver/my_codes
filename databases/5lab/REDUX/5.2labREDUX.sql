USE bolnica;

GO

CREATE VIEW v_complete_medical_data AS
SELECT p.patient_name AS 'Пациент'
,p.date_of_birth AS 'Дата рождения'
,p.adres AS 'Адрес'
,p.gender AS 'Пол'
,p.discount_on_service AS 'Скидка'
,d.d_name AS 'Врач'
,d.spec AS 'Специализация'
,d.category AS 'Категория'
,diag.d_name AS 'Название диагноза'
,diag.category AS 'Категория диагноза'
,a.session_date AS 'Дата приема'
,a.purpose_visit AS 'Цель визита'
,a.visit_cost AS 'Стоимость посещения'
FROM appointment a
INNER JOIN patient p ON a.patient_mk_number = p.mk_number
INNER JOIN doctor d ON a.doctor_id = d.doctor_id
LEFT JOIN diagnosis diag ON a.diagnosis_id = diag.diagnosis_id;

GO