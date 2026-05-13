USE bolnica;
GO

CREATE PROCEDURE usp_SafeUpdateAppointment
    @ticket_id INT,
    @new_visit_cost DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE appointment
        SET visit_cost = @new_visit_cost
        WHERE ticket_id = @ticket_id;

        COMMIT TRANSACTION;
        PRINT 'Стоимость приёма обновлена';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeUpdateAppointment 42, 7000;
SELECT * FROM appointment ORDER BY ticket_id DESC;