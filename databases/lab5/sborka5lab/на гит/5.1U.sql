USE bolnica;

GO 

INSERT INTO vw_patient (patient_name, date_of_birth, adres, gender, discount_of_service)
VALUES ('Алексей Ефимов', '2066-66-66', 'ул. Пушкина, 66', 'M', 6.00);

SELECT * FROM patient;
SELECT * FROM vw_patient;

UPDATE vw_patient
SET discount_on_service = 10.00
WHERE patient_name = 'Алексей Ефимов';
