USE bolnica;
GO

CREATE PROCEDURE usp_AnalyzeDiscountUsage
    @patient_mk_number TINYINT
AS
BEGIN
    DECLARE @patient_name VARCHAR(128);
    DECLARE @total_cost DECIMAL(10,2);
    DECLARE @total_discount DECIMAL(10,2);
    DECLARE @paid_amount DECIMAL(10,2);

    SELECT @patient_name = patient_name
    FROM patient
    WHERE mk_number = @patient_mk_number;

    IF @patient_name IS NULL
    BEGIN
        PRINT 'Ошибка: пациент не найден';
        RETURN;
    END;

    SELECT @total_cost = SUM(a.visit_cost)
    FROM appointment a
    WHERE a.patient_mk_number = @patient_mk_number;

    SELECT @total_discount = SUM(a.visit_cost * p.discount_on_service / 100)
    FROM appointment a
    INNER JOIN patient p ON a.patient_mk_number = p.mk_number
    WHERE a.patient_mk_number = @patient_mk_number;

    SET @paid_amount = ISNULL(@total_cost, 0) - ISNULL(@total_discount, 0);

    PRINT 'Пациент: ' + @patient_name;
    PRINT 'Общая стоимость услуг: ' + ISNULL(CAST(@total_cost AS VARCHAR), '0');
    PRINT 'Общая сумма скидки: ' + ISNULL(CAST(@total_discount AS VARCHAR), '0');
    PRINT 'Фактически оплачено: ' + CAST(@paid_amount AS VARCHAR);
END
GO

EXEC usp_AnalyzeDiscountUsage @patient_mk_number = 1;