-- ALTER TABLE `product` DROP COLUMN version;
-- ALTER TABLE `product` ADD COLUMN version INT DEFAULT 0;

-- SELECT * FROM `product`;
UPDATE `product` SET stock = 1, version = 0 WHERE name = '맥북 네오';

START TRANSACTION;  

SELECT stock, version 
FROM `product` WHERE name = '맥북 네오';

UPDATE product
SET stock = stock - 1,
	version = version + 1
WHERE id = 7
AND version = 0; 

COMMIT;

SELECT stock, version 
FROM `product` WHERE name = '맥북 네오';