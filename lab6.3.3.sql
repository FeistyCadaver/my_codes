USE bolnica;
GO

CREATE PROCEDURE usp_UpdateDiagnosisStats
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'diagnosis_stats')
    BEGIN
        CREATE TABLE diagnosis_stats (
            diagnosis_id INT PRIMARY KEY,
            diagnosis_name VARCHAR(64),
            frequency INT,
            last_updated DATETIME DEFAULT GETDATE()
        );
    END;

    UPDATE ds SET
        ds.frequency = (
            SELECT COUNT(*) 
            FROM appointment a 
            WHERE a.diagnosis_id = ds.diagnosis_id
        ),
        ds.last_updated = GETDATE()
    FROM diagnosis_stats ds;

    INSERT INTO diagnosis_stats (diagnosis_id, diagnosis_name, frequency, last_updated)
    SELECT 
        d.diagnosis_id,
        d.d_name,
        COUNT(a.ticket_id),
        GETDATE()
    FROM diagnosis d
    LEFT JOIN appointment a ON d.diagnosis_id = a.diagnosis_id
    WHERE NOT EXISTS (SELECT 1 FROM diagnosis_stats ds WHERE ds.diagnosis_id = d.diagnosis_id)
    GROUP BY d.diagnosis_id, d.d_name;

    PRINT 'Статистика диагнозов обновлена';
END
GO

EXEC usp_UpdateDiagnosisStats

SELECT * FROM diagnosis_stats

DROP PROCEDURE usp_UpdateDiagnosisStats