USE Tour
GO

CREATE PROCEDURE usp_SafeDeleteSale
    @sale_id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM sale WHERE id_sale = @sale_id;
        
        COMMIT TRANSACTION;
        PRINT 'Удалено';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка';
    END CATCH
END

GO
-- без транзакции
UPDATE sale SET ticket_price = 1000 WHERE id_sale = 1;
UPDATE client SET full_name = 'Новое имя' WHERE id_client = 1;
-- с транзакцией
BEGIN TRANSACTION;
UPDATE sale SET ticket_price = 1000 WHERE id_sale = 1;
UPDATE client SET full_name = 'Новое имя' WHERE id_client = 1;
COMMIT;