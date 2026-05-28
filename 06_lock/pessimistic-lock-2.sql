START TRANSACTION; 

SELECT * FROM product
WHERE name = '맥북 네오'
FOR UPDATE;

UPDATE product
SET stock = stock - 1
WHERE id = 7; 

ROLLBACK;