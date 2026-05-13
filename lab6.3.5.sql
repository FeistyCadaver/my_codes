USE bolnica;
GO

CREATE PROCEDURE usp_DetectEpidemicPeak
    @year INT = NULL,
    @threshold_percent DECIMAL(5,2) = 50
AS
BEGIN
    IF @year IS NULL SET @year = YEAR(GETDATE());

    WITH monthly_cases AS (
        SELECT 
            d.diagnosis_id,
            d.d_name,
            MONTH(a.session_date) AS visit_month,
            COUNT(*) AS case_count
        FROM appointment a
        INNER JOIN diagnosis d ON a.diagnosis_id = d.diagnosis_id
        WHERE YEAR(a.session_date) = @year
            AND a.diagnosis_id IS NOT NULL
        GROUP BY d.diagnosis_id, d.d_name, MONTH(a.session_date)
    ),
    growth AS (
        SELECT 
            m1.diagnosis_id,
            m1.d_name,
            m1.visit_month,
            m1.case_count AS current_count,
            ISNULL(m2.case_count, 0) AS prev_count,
            CASE 
                WHEN ISNULL(m2.case_count, 0) > 0 
                THEN ((m1.case_count - m2.case_count) * 100.0 / m2.case_count)
                ELSE 100 
            END AS growth_percent
        FROM monthly_cases m1
        LEFT JOIN monthly_cases m2 ON m1.diagnosis_id = m2.diagnosis_id 
            AND m1.visit_month = m2.visit_month + 1
    )
    SELECT TOP 1
        d_name AS 'Диагноз',
        visit_month AS 'Месяц пика',
        current_count AS 'Случаев в месяц пика',
        prev_count AS 'Случаев в предыдущем месяце',
        CAST(growth_percent AS DECIMAL(5,2)) AS 'Рост %'
    FROM growth
    WHERE growth_percent >= @threshold_percent
    ORDER BY growth_percent DESC;
END
GO

EXEC usp_DetectEpidemicPeak @year = 2026, @threshold_percent = 30;

DROP PROCEDURE usp_DetectEpidemicPeak