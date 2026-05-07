USE Tour
GO

UPDATE sale SET ticket_price = 1000 WHERE id_sale = 1;
UPDATE sale SET ticket_price = 1000 WHERE id_sale = 1/10;

BEGIN TRANSACTION;
UPDATE sale SET ticket_price = 1000 WHERE id_sale = 2;
UPDATE sale SET ticket_price = 1000 WHERE id_sale = 1/10;
ROLLBACK;

select * from sale
