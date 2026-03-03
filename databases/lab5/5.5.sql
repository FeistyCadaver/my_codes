-- 1. Индекс для поиска по дате приема (часто используется в отчетах)
CREATE INDEX IX_appointment_session_date 
ON appointment(session_date);
-- Обоснование: ускоряет поиск по датам, фильтрацию по месяцам/годам

-- 2. Составной индекс для связи врач-пациент
CREATE INDEX IX_appointment_doctor_patient 
ON appointment(doctor_id, patient_id);
-- Обоснование: ускоряет JOIN операции между таблицами

-- 3. Индекс для поиска диагнозов по названию
CREATE INDEX IX_diagnosis_name 
ON diagnosis(d_name);
-- Обоснование: часто выполняется поиск по названию диагноза

-- 4. Индекс для истории болезни по дате
CREATE INDEX IX_medical_history_dates 
ON medical_history(diagnosis_date, resolution_date);
-- Обоснование: ускоряет анализ временных периодов

-- 5. Индекс для поиска пациентов по дате рождения
CREATE INDEX IX_patient_dob 
ON patient(date_of_birth);
-- Обоснование: для возрастного анализа пациентов

-- 6. Индекс для внешнего ключа в appointment
CREATE INDEX IX_appointment_diagnosis 
ON appointment(diagnosis_id);
-- Обоснование: ускоряет JOIN с таблицей diagnosis

-- 7. Индекс для ожидания приема (часто в аналитике)
CREATE INDEX IX_appointment_waiting 
ON appointment(waiting_time_minutes);
-- Обоснование: для анализа эффективности работы

-- 8. Почему НЕ создаем некоторые индексы:
-- - На поле gender в patient: слишком мало уникальных значений (только M/F)
-- - На поле satisfaction_rating: мало уникальных значений (1-5)
-- - На маленьких таблицах типа doctor: полный просмотр быстрее
-- - На текстовых полях с большим объемом данных без поиска по ним

-- Проверка созданных индексов
SELECT 
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc,
    i.is_unique,
    i.is_primary_key
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name IN ('patient', 'doctor', 'appointment', 'diagnosis', 'medical_history')
ORDER BY t.name, i.name;