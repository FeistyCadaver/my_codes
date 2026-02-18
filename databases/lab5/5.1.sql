USE bolnica;
GO

CREATE VIEW vw_patient_data AS
SELECT 
    patient_name,
    date_of_birth,
    adres,
    gender,
    discount_on_service
FROM patient;
GO

CREATE VIEW vw_doctor_data AS
SELECT 
    d_name,
    spec,
    category
FROM doctor;
GO


CREATE VIEW vw_diagnosis_data AS
SELECT 
    d_name,
    category
FROM diagnosis;
GO


CREATE VIEW vw_appointment_data AS
SELECT 
    session_date,
    purpose_visit,
    visit_cost,
    patient_mk_number,
    doctor_id,
    diagnosis_id
FROM appointment;
