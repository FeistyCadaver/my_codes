USE Tour
GO

CREATE PROCEDURE usp_SafeUpdatePrice
    @sale_id INT,
    @new_price DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE sale SET ticket_price = @new_price WHERE id_sale = @sale_id;
        
        COMMIT TRANSACTION;
        PRINT 'Цена обновлена';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC usp_SafeUpdatePrice 1, 4000;

select * from sale