USE bolnica;
GO

CREATE PROCEDURE usp_CalculateDepartmentKPI
    @doctor_spec VARCHAR(64) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.spec AS 'Специализация',
        COUNT(DISTINCT a.patient_mk_number) AS 'Уникальных пациентов',
        COUNT(a.ticket_id) AS 'Всего визитов',

        CASE 
            WHEN COUNT(a.ticket_id) > COUNT(DISTINCT a.patient_mk_number)
            THEN COUNT(a.ticket_id) - COUNT(DISTINCT a.patient_mk_number)
            ELSE 0 
        END AS 'Повторных визитов',
        CASE 
            WHEN COUNT(a.ticket_id) > 0 
            THEN CAST((COUNT(a.ticket_id) - COUNT(DISTINCT a.patient_mk_number)) * 100.0 / COUNT(a.ticket_id) AS DECIMAL(5,2))
            ELSE 0 
        END AS 'Индекс удовлетворённости (%)'
    FROM doctor d
    LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
    WHERE (@doctor_spec IS NULL OR d.spec = @doctor_spec)
    GROUP BY d.spec
    ORDER BY 'Индекс удовлетворённости (%)' DESC;
END
GO

EXEC usp_CalculateDepartmentKPI;
EXEC usp_CalculateDepartmentKPI @doctor_spec = 'Терапия';