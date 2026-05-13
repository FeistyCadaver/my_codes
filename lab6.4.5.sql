USE bolnica;
GO

CREATE PROCEDURE usp_SafeTransferDoctor
    @old_doctor_id INT,
    @new_doctor_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE appointment
        SET doctor_id = @new_doctor_id
        WHERE doctor_id = @old_doctor_id;

        COMMIT TRANSACTION;
        PRINT 'Все приёмы переназначены с врача ' + CAST(@old_doctor_id AS VARCHAR) + 
              ' на врача ' + CAST(@new_doctor_id AS VARCHAR);
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeTransferDoctor @old_doctor_id = 1, @new_doctor_id = 2;
USE bolnica;
GO

CREATE PROCEDURE usp_SafeTransferDoctor
    @old_doctor_id INT,
    @new_doctor_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE appointment
        SET doctor_id = @new_doctor_id
        WHERE doctor_id = @old_doctor_id;

        COMMIT TRANSACTION;
        PRINT 'Все приёмы переназначены с врача ' + CAST(@old_doctor_id AS VARCHAR) + 
              ' на врача ' + CAST(@new_doctor_id AS VARCHAR);
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeTransferDoctor @old_doctor_id = 1, @new_doctor_id = 27;
SELECT * FROM appointment ORDER BY patient_mk_number DESC;