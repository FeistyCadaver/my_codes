USE bolnica;

GO

UPDATE v_complete_medical_data
SET Стоимость = 2000.00
WHERE Пациент = 'Андрей Балконский' AND Врач = 'Ефим Алексеев';

GO
--НЕВОЗМОЖНО АПДЕЙТИ НАПИСАТЬ!!!!