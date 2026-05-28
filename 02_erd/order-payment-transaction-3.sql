SELECT * FROM `product`;
UPDATE `product` SET stock = 20 WHERE name = '맥북 네오';

START TRANSACTION;  -- 트랙잭션을 시작

-- 순자님이 맥북 네오 1대를 구매
-- 1단계: 재고 확인 후 차감
UPDATE product
SET stock = stock - 1
WHERE id = 7 AND stock >= 1; 

-- 2단계: 주문 생성
INSERT INTO `order` (member_id_fk, status, total_price, order_date)
VALUES (2, 'PENDING', 990000, NOW());

ROLLBACK;

-- 3단계: 주문 상세 생성
INSERT INTO order_item (order_id_fk, product_id_fk, quantity, product_price)
VALUES (LAST_INSERT_ID(), 7, 1, 990000);

SELECT DISTINCT m.*
FROM member m
JOIN `order` o ON o.member_id_fk = m.id
JOIN order_item oi ON oi.order_id_fk = o.id
WHERE oi.product_id_fk = (
	SELECT id FROM `product` WHERE name = '맥북 네오'
);

