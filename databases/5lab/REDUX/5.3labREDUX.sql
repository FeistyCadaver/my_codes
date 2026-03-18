USE bolnica;

GO

CREATE VIEW v_doctor_workload AS
SELECT d.doctor_id
,d.d_name AS 'Врач'
,d.spec AS 'Специализация'
,d.category AS 'Категория'
COUNT(a.ticket_id) AS 'Кол-во приемов за месяц',
