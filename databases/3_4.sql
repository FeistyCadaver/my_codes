USE Tour
GO

CREATE PROCEDURE usp_BuildCustomerProfile
    @client_id INT
AS
BEGIN
    SELECT 
        c.full_name AS 'Клиент',
        COUNT(s.id_sale) AS 'Поездок',
        'Турист' AS 'Тип'
    FROM client c
    LEFT JOIN sale s ON c.id_client = s.id_client
    WHERE c.id_client = @client_id
    GROUP BY c.full_name;
END
GO

EXEC usp_BuildCustomerProfile 15;

