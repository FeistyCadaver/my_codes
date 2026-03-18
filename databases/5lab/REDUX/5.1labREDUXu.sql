USE bolnica;

GO

UPDATE v_patient_no_pk SET adres = 'Новый адрес'
WHERE patient_name = 'Алексей Ефимов';

UPDATE v_doctor_no_pk SET category = 'Высшая'
WHERE d_name = 'Кто-то';

UPDATE v_diagnosis_no_pk SET category = 'Новая категория'
WHERE d_name = 'Очень страшная болезнь';

UPDATE v_appointment_no_pk SET visit_cost = 1000.00
WHERE purpose_visit = 'Осмотр';