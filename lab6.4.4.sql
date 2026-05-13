USE bolnica;
GO

CREATE PROCEDURE usp_SafeUpdatePatientDiscount
    @mk_number TINYINT,
    @new_discount DECIMAL(5,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE patient
        SET discount_on_service = @new_discount
        WHERE mk_number = @mk_number;

        COMMIT TRANSACTION;
        PRINT 'Скидка пациента обновлена';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeUpdatePatientDiscount 25, 15.00;
SELECT * FROM patient ORDER BY mk_number DESC;