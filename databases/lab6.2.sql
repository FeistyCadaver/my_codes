USE bolnica;

GO

CREATE PROCEDURE usp_UpdateVisitCost
	@medCardNum INT = NULL
	,@cost_increase_patient DECIMAL(5, 2) = NULL
AS
BEGIN
	UPDATE appointment
	SET visit_cost = @cost_increase_patient
	WHERE patient_mk_number = @medCardNum;
END;

EXEC usp_UpdateVisitCost @medCardNum = 1, @cost_increase_patient = 4000;

select * from usp_UpdateVisitCost;