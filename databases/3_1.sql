USE Tour
GO

CREATE PROCEDURE usp_GetVisaInfo
    @country_name NVARCHAR(50),
    @visa_type NVARCHAR(20) OUTPUT,
    @visa_cost DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT 
        @visa_cost = cost_visa,
        @visa_type = CASE 
            WHEN cost_visa = 0 THEN 'Безвизовая'
            WHEN cost_visa > 0 THEN 'Визовая'
            ELSE 'Неизвестно'
        END
    FROM country
    WHERE name_country = @country_name;
    
    PRINT 'Страна: ' + @country_name;
    PRINT 'Тип визы: ' + @visa_type;
    PRINT 'Стоимость: ' + CAST(@visa_cost AS NVARCHAR) + ' USD';
END
GO

drop procedure usp_GetVisaInfo

DECLARE @type NVARCHAR(20), @cost DECIMAL(10,2);
EXEC usp_GetVisaInfo 'ОАЭ', @type OUTPUT, @cost OUTPUT;