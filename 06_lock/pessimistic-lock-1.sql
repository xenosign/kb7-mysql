UPDATE `product` SET stock = 1 WHERE name = '맥북 네오';

-- 비관 락 확인
START TRANSACTION;  -- 트랙잭션을 시작

SELECT * FROM product
WHERE name = '맥북 네오'
FOR UPDATE;

UPDATE product
SET stock = stock - 1
WHERE id = 7; 

SELECT * FROM `product` WHERE name = '맥북 네오';

COMMIT;



