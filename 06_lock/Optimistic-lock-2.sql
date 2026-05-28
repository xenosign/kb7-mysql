START TRANSACTION;  

SELECT stock, version 
FROM `product` WHERE name = '맥북 네오';

UPDATE product
SET stock = stock - 1,
	version = version + 1
WHERE id = 7
AND version = 0; 

SELECT stock, version 
FROM `product` WHERE name = '맥북 네오';

ROLLBACK;