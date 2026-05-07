USE Tour
GO

CREATE PROCEDURE usp_SafeInsertSale
    @client_id INT,
    @route_id INT,
    @price DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO sale(id_client, id_route, ticket_price, date_sale)
        VALUES (@client_id, @route_id, @price, GETDATE());
        
        COMMIT TRANSACTION;
        PRINT 'Добавлено';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Ошибка';
    END CATCH
END

GO

EXEC usp_SafeUpdatePrice 1, 2000;