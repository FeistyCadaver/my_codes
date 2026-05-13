USE bolnica;
GO

CREATE PROCEDURE usp_BuildHealthProfile
    @patient_mk_number TINYINT,
    @patient_name VARCHAR(128) OUTPUT,
    @unique_diagnoses INT OUTPUT,
    @total_visits INT OUTPUT,
    @avg_cost DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @patient_name = patient_name
    FROM patient
    WHERE mk_number = @patient_mk_number;

    IF @patient_name IS NULL
    BEGIN
        SET @unique_diagnoses = 0;
        SET @total_visits = 0;
        SET @avg_cost = 0;
        RETURN;
    END;

    SELECT 
        @unique_diagnoses = COUNT(DISTINCT a.diagnosis_id),
        @total_visits = COUNT(a.ticket_id),
        @avg_cost = AVG(a.visit_cost)
    FROM appointment a
    WHERE a.patient_mk_number = @patient_mk_number;

    SET @unique_diagnoses = ISNULL(@unique_diagnoses, 0);
    SET @total_visits = ISNULL(@total_visits, 0);
    SET @avg_cost = ISNULL(@avg_cost, 0);
END
GO

DECLARE @pat_name VARCHAR(128), @uniq_diag INT, @tot_vis INT, @avg_cst DECIMAL(10,2);

EXEC usp_BuildHealthProfile 
    @patient_mk_number = 1,
    @patient_name = @pat_name OUTPUT,
    @unique_diagnoses = @uniq_diag OUTPUT,
    @total_visits = @tot_vis OUTPUT,
    @avg_cost = @avg_cst OUTPUT;

PRINT 'Пациент: ' + @pat_name;
PRINT 'Уникальных диагнозов: ' + CAST(@uniq_diag AS VARCHAR);
PRINT 'Всего визитов: ' + CAST(@tot_vis AS VARCHAR);
PRINT 'Средняя стоимость: ' + CAST(@avg_cst AS VARCHAR);