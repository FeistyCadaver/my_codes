USE Tour
GO

CREATE PROCEDURE usp_ApplySeasonalPrice
AS
BEGIN
    UPDATE sale
    SET ticket_price = ticket_price * 1.3
    WHERE MONTH(date_sale) IN (6, 7, 8);
    UPDATE sale
    SET ticket_price = ticket_price * 2
    WHERE MONTH(date_sale) IN (12, 1, 2);
END
GO

drop procedure usp_ApplySeasonalPrice

EXEC usp_ApplySeasonalPrice;

SELECT * FROM sale