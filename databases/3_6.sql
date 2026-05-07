USE Tour
GO

CREATE PROCEDURE usp_CalculateDestinationROI
    @country_id INT
AS
BEGIN
    SELECT 
        c.name_country AS 'Страна',
        SUM(s.ticket_price * s.quantity_ticket) AS 'Выручка',
        SUM(s.ticket_price * s.quantity_ticket) * 0.6 AS 'Себестоимость',
        SUM(s.ticket_price * s.quantity_ticket) * 0.4 AS 'Прибыль',
        (SUM(s.ticket_price * s.quantity_ticket) * 0.4 / SUM(s.ticket_price * s.quantity_ticket)) * 100 AS 'Рентабельность'
    FROM country c
    INNER JOIN marshrut m ON c.id_country = m.id_country
    INNER JOIN sale s ON m.id_route = s.id_route
    WHERE c.id_country = @country_id
    GROUP BY c.name_country;
END
GO

EXEC usp_CalculateDestinationROI 1;