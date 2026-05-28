UPDATE `product` SET stock = 20 WHERE name = '맥북 네오';

-- 격리성 확인 1
START TRANSACTION;  -- 트랙잭션을 시작

-- 순자님이 맥북 네오 1대를 구매
-- 1단계: 재고 확인 후 차감
UPDATE product
SET stock = stock - 1
WHERE id = 7 AND stock >= 1; 

SELECT * FROM `product` WHERE name = '맥북 네오';

COMMIT;

