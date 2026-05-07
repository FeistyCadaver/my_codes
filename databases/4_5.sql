USE Tour
GO

SELECT TOP 5 id_sale, id_client, id_route, ticket_price, date_sale 
FROM sale 
ORDER BY id_sale DESC;