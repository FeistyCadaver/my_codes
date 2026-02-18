-- Попытка обновления данных через комплексное представление
-- СЛЕДУЮЩИЙ ЗАПРОС ВЫЗОВЕТ ОШИБКУ:
UPDATE vw_complete_medical_records 
SET [Стоимость приема] = 2000.00 
WHERE [Пациент] = 'Иван Петров';

-- Ошибка: View or function 'vw_complete_medical_records' is not updatable 
-- because the modification affects multiple base tables.

-- Попытка вставки данных - ТОЖЕ ВЫЗОВЕТ ОШИБКУ:
INSERT INTO vw_complete_medical_records VALUES 
('Петр Сидоров', '1990-01-20', 'ул. Гагарина, 5', 'M', 0, 
 '2024-01-15 10:00', 'Консультация', 1500.00, 
 'Смирнова Е.И.', 'Терапевт', 'Высшая', 'ОРВИ', 'Инфекционные');

-- Ошибка: Cannot insert into view because it contains multiple base tables.