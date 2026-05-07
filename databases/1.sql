USE Tour
GO

CREATE PROCEDURE usp_GetAllClientName
AS
BEGIN
    SELECT full_name, passport_data
    FROM client;
END;

drop procedure usp_GetAllClientName;

EXEC usp_GetAllClientName;