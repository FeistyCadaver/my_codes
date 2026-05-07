USE Tour
GO


CREATE PROCEDURE usp_UpdateTicketPrice
    @ClientID INT,
    @NewPrice DECIMAL(10, 2)
AS
BEGIN
    UPDATE sale
    SET ticket_price = @NewPrice
    WHERE id_client = @ClientID;
END;

drop procedure usp_UpdateTicketPrice

EXEC usp_UpdateTicketPrice @ClientID = 1, @NewPrice = 3000;
EXEC usp_UpdateTicketPrice @ClientID = 27, @NewPrice = 11.11;

select * from sale;