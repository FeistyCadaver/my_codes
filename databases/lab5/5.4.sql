-- 1. v_doctor_workload - загруженность врачей
CREATE VIEW v_doctor_workload AS
SELECT 
    d.doctor_id,
    d.d_name AS doctor_name,
    d.spec,
    COUNT(CASE 
        WHEN MONTH(a.session_date) = MONTH(GETDATE()) 
        AND YEAR(a.session_date) = YEAR(GETDATE()) 
        THEN 1 
    END) AS appointments_per_month,
    AVG(CAST(DATEDIFF(minute, a.session_date, 
        LEAD(a.session_date) OVER (PARTITION BY a.doctor_id ORDER BY a.session_date)) AS FLOAT)) 
        AS avg_appointment_duration,
    COUNT(CASE 
        WHEN DATEPART(hour, a.session_date) BETWEEN 10 AND 14 
        THEN 1 
    END) AS peak_hour_load,
    (SELECT COUNT(*) FROM appointment a2 
     WHERE a2.doctor_id = d.doctor_id 
     AND a2.session_date > GETDATE()) AS free_slots
FROM doctor d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.d_name, d.spec;
GO

-- Проверка
SELECT * FROM v_doctor_workload;

-- 2. v_patient_health_profile - профиль здоровья пациентов
CREATE VIEW v_patient_health_profile AS
SELECT 
    p.patient_id,
    p.patient_name,
    p.gender,
    COUNT(CASE 
        WHEN YEAR(a.session_date) = YEAR(GETDATE()) 
        THEN 1 
    END) AS yearly_visits,
    COUNT(DISTINCT mh.diagnosis_id) AS unique_diagnoses,
    AVG(a.visit_cost) AS avg_visit_cost,
    CASE 
        WHEN COUNT(a.appointment_id) > 0 
        THEN CAST(COUNT(CASE 
            WHEN EXISTS (SELECT 1 FROM appointment a2 
                        WHERE a2.patient_id = p.patient_id 
                        AND a2.diagnosis_id = a.diagnosis_id 
                        AND a2.session_date < a.session_date)
            THEN 1 
        END) AS FLOAT) / COUNT(a.appointment_id) * 100
        ELSE 0 
    END AS repeat_visit_percentage
FROM patient p
LEFT JOIN appointment a ON p.patient_id = a.patient_id
LEFT JOIN medical_history mh ON p.patient_id = mh.patient_id
GROUP BY p.patient_id, p.patient_name, p.gender;
GO

-- Проверка
SELECT * FROM v_patient_health_profile;

-- 3. v_diagnosis_frequency_analysis - анализ частоты диагнозов
CREATE VIEW v_diagnosis_frequency_analysis AS
SELECT 
    d.diagnosis_id,
    d.d_name AS diagnosis_name,
    d.category,
    COUNT(a.appointment_id) AS total_diagnoses,
    MONTH(a.session_date) AS month,
    COUNT(CASE 
        WHEN MONTH(a.session_date) = 1 THEN 1 
    END) AS january_count,
    COUNT(CASE 
        WHEN MONTH(a.session_date) = 2 THEN 1 
    END) AS february_count,
    COUNT(CASE 
        WHEN MONTH(a.session_date) = 3 THEN 1 
    END) AS march_count,
    AVG(DATEDIFF(year, p.date_of_birth, a.session_date)) AS avg_patient_age,
    CASE 
        WHEN COUNT(a.appointment_id) > 0 
        THEN CAST(COUNT(CASE WHEN mh.is_resolved = 1 THEN 1 END) AS FLOAT) 
             / COUNT(a.appointment_id) * 100
        ELSE 0 
    END AS treatment_efficiency
FROM diagnosis d
LEFT JOIN appointment a ON d.diagnosis_id = a.diagnosis_id
LEFT JOIN patient p ON a.patient_id = p.patient_id
LEFT JOIN medical_history mh ON d.diagnosis_id = mh.diagnosis_id 
    AND mh.patient_id = p.patient_id
GROUP BY d.diagnosis_id, d.d_name, d.category, MONTH(a.session_date);
GO

-- Проверка
SELECT * FROM v_diagnosis_frequency_analysis;

-- 4. v_department_efficiency - эффективность отделений
CREATE VIEW v_department_efficiency AS
SELECT 
    d.spec AS department,
    COUNT(a.appointment_id) AS total_appointments,
    AVG(CAST(a.waiting_time_minutes AS FLOAT)) AS avg_waiting_time,
    AVG(CAST(a.satisfaction_rating AS FLOAT)) AS avg_satisfaction,
    SUM(a.visit_cost) AS total_revenue,
    SUM(a.visit_cost) * 0.7 AS estimated_profit -- 70% от выручки
FROM doctor d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.spec;
GO

-- Проверка
SELECT * FROM v_department_efficiency;

-- 5. v_seasonal_illness_patterns - сезонные закономерности
CREATE VIEW v_seasonal_illness_patterns AS
SELECT 
    d.d_name AS diagnosis_name,
    MONTH(a.session_date) AS month,
    DATENAME(month, a.session_date) AS month_name,
    COUNT(a.appointment_id) AS monthly_count,
    AVG(COUNT(a.appointment_id)) OVER (
        PARTITION BY d.diagnosis_id 
        ORDER BY MONTH(a.session_date)
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS moving_avg_3_months,
    CASE 
        WHEN COUNT(a.appointment_id) > 
             AVG(COUNT(a.appointment_id)) OVER (PARTITION BY d.diagnosis_id) * 1.5
        THEN 'EPIDEMIC_PEAK'
        WHEN COUNT(a.appointment_id) > 
             AVG(COUNT(a.appointment_id)) OVER (PARTITION BY d.diagnosis_id) * 1.2
        THEN 'HIGH'
        ELSE 'NORMAL'
    END AS seasonality_status
FROM diagnosis d
LEFT JOIN appointment a ON d.diagnosis_id = a.diagnosis_id
GROUP BY d.diagnosis_id, d.d_name, MONTH(a.session_date), DATENAME(month, a.session_date);
GO

-- Проверка
SELECT * FROM v_seasonal_illness_patterns ORDER BY diagnosis_name, month;

-- 6. v_discount_usage_analysis - анализ использования льгот
CREATE VIEW v_discount_usage_analysis AS
SELECT 
    p.patient_id,
    p.patient_name,
    p.discount_on_service,
    COUNT(CASE 
        WHEN p.discount_on_service > 0 THEN a.appointment_id 
    END) AS discounted_visits,
    COUNT(CASE 
        WHEN p.discount_on_service = 0 THEN a.appointment_id 
    END) AS paid_visits,
    SUM(CASE 
        WHEN p.discount_on_service > 0 
        THEN a.visit_cost * (p.discount_on_service / 100.0)
        ELSE 0 
    END) AS total_savings,
    CASE 
        WHEN COUNT(a.appointment_id) > 0 
        THEN CAST(COUNT(CASE WHEN p.discount_on_service > 0 THEN 1 END) AS FLOAT) 
             / COUNT(a.appointment_id) * 100
        ELSE 0 
    END AS discount_usage_percentage
FROM patient p
LEFT JOIN appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name, p.discount_on_service;
GO

-- Проверка
SELECT * FROM v_discount_usage_analysis;