USE bolnica;

GO

CREATE VIEW vw_patient AS
SELECT 
	patient_name,
	date_of_birth,
	adres,
	gender,
	discount_on_service,
FROM patient;

GO

CREATE VIEW vw_doctor AS
SELECT
	d_name,
	spec,
	category,
FROM doctor;

GO

CREATE VIEW vw_diagnosis AS
SELECT
	d_name,
	category,
FROM diagnosis;

GO

CREATE VIEW vw_appointment AS
SELECT
	session_date,
	purpose_visit,
	visit_cost,
	patient_mk_number,
	doctor_id,
	diagnosis_id,
FROM appointment;
	