
INSERT INTO vw_patient_data (patient_name, date_of_birth, adres, gender, discount_on_service)
VALUES ('Иван Петров', '1985-05-15', 'ул. Ленина, 10', 'M', 5.00);


SELECT * FROM patient;
SELECT * FROM vw_patient_data;


UPDATE vw_patient_data 
SET discount_on_service = 10.00 
WHERE patient_name = 'Иван Петров';

DELETE FROM vw_patient_data 
WHERE patient_name = 'Иван Петров';