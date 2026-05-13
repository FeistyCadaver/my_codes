USE bolnica;
GO

CREATE PROCEDURE usp_SafeDeleteAppointment
    @ticket_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM appointment WHERE ticket_id = @ticket_id;

        COMMIT TRANSACTION;
        PRINT 'Приём удалён';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeDeleteAppointment 42;
SELECT * FROM appointment ORDER BY ticket_id DESC;