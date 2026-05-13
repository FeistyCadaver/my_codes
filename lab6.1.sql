USE bolnica;

GO

CREATE PROCEDURE usp_GetAllPatients
AS
BEGIN 
	SELECT mk_number AS 'Номер карты'
	,patient_name AS 'Имя пациента'
	,date_of_birth AS 'Дата рождения'
	,adres AS 'Адрес'
	,gender AS 'Пол'
	,discount_on_service AS 'Скидка на обслуживание'
	FROM patient
	ORDER BY patient_name;
END;

EXEC sp_GetAllPatients;