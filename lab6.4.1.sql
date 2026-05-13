USE bolnica;
GO

CREATE PROCEDURE usp_SafeInsertAppointment
    @patient_mk_number TINYINT,
    @doctor_id INT,
    @session_date DATETIME,
    @purpose_visit VARCHAR(64),
    @visit_cost DECIMAL(10,2),
    @diagnosis_id INT = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO appointment (session_date, purpose_visit, visit_cost, patient_mk_number, doctor_id, diagnosis_id)
        VALUES (@session_date, @purpose_visit, @visit_cost, @patient_mk_number, @doctor_id, @diagnosis_id);

        COMMIT TRANSACTION;
        PRINT 'Приём успешно добавлен';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

SELECT * FROM appointment ORDER BY ticket_id DESC;

DROP PROCEDURE  usp_SafeInsertAppointment