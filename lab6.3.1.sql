USE bolnica;
GO

CREATE PROCEDURE usp_AnalyzeDoctorLoad
    @doctor_id INT,
    @month INT = NULL,
    @year INT = NULL,
    @doctor_name VARCHAR(128) OUTPUT,
    @load_percent DECIMAL(5,2) OUTPUT,
    @status_message VARCHAR(256) OUTPUT
AS
BEGIN
    DECLARE @norm_hours DECIMAL(10,2) = 160;
    DECLARE @actual_hours INT;

    IF @month IS NULL SET @month = MONTH(GETDATE());
    IF @year IS NULL SET @year = YEAR(GETDATE());

    SELECT @doctor_name = d_name
    FROM doctor
    WHERE doctor_id = @doctor_id;


    SELECT @actual_hours = COUNT(*)
    FROM appointment
    WHERE doctor_id = @doctor_id
        AND MONTH(session_date) = @month
        AND YEAR(session_date) = @year;

    SET @load_percent = (@actual_hours / @norm_hours) * 100;

    SET @status_message = 'Врач: ' + @doctor_name + 
                         ', Период: ' + CAST(@month AS VARCHAR) + '/' + CAST(@year AS VARCHAR) +
                         ', Загруженность: ' + CAST(@load_percent AS VARCHAR) + '%';
END
GO

DECLARE @doc_name VARCHAR(128), @load_pct DECIMAL(5,2), @msg VARCHAR(256);

EXEC usp_AnalyzeDoctorLoad 
    @doctor_id = 1,
    @doctor_name = @doc_name OUTPUT,
    @load_percent = @load_pct OUTPUT,
    @status_message = @msg OUTPUT;

PRINT @msg;
PRINT 'Имя врача: ' + @doc_name;
PRINT 'Загруженность: ' + CAST(@load_pct AS VARCHAR) + '%';

