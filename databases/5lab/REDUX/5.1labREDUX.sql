USE bolnica;

GO

CREATE VIEW v_patient_no_pk AS 
SELECT patient_name, date_of_birth, adres, gender,discount_on_service
FROM patient;

GO

CREATE VIEW v_doctor_no_pk AS
SELECT d_name, spec,category
FROM doctor;

GO

CREATE VIEW v_diagnosis_no_pk AS
SELECT d_name, category
FROM diagnosis;

GO

CREATE VIEW v_appointment_no_pk AS
SELECT session_date, purpose_visit, visit_cost, patient_mk_number, doctor_id, diagnosis_id
FROM appointment;

GO