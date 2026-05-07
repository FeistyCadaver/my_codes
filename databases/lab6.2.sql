USE bolnica;

GO

CREATE PROCEDURE usp_UpdateVisitCost
	@medCardNum INT
	,@Skidka DECIMAL(5, 2) = 10.00
AS
BEGIN
	UPDATE patient
	SET discount_on_service = @Skidka
	WHERE mk_number = @medCardNum;
END;

EXEC usp_UpdateVisitCost @medCardNum = 1, @Skidka = 5.00;

select * from patient;