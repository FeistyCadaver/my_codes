USE Tour
GO

CREATE PROCEDURE usp_CalculateRouteProfit
    @route_id INT
AS
BEGIN
    DECLARE @revenue DECIMAL(10,2);
    DECLARE @cost DECIMAL(10,2);
    DECLARE @profit DECIMAL(10,2);
    DECLARE @route_name NVARCHAR(100);
    
    SELECT 
        @route_name = MAX(m.name_route),
        @revenue = SUM(s.ticket_price * s.quantity_ticket)
    FROM marshrut m
    LEFT JOIN sale s ON m.id_route = s.id_route
    WHERE m.id_route = @route_id;
    
    SET @cost = @revenue * 0.6;
    
    SET @profit = @revenue - @cost;
    
    PRINT 'Маршрут: ' + @route_name;
    PRINT 'Выручка: ' + CAST(@revenue AS NVARCHAR) + ' USD';
    PRINT 'Прибыль: ' + CAST(@profit AS NVARCHAR) + ' USD';
END
GO

EXEC usp_CalculateRouteProfit 3;