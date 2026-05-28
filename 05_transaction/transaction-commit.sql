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
VALUES (1, 'PENDING', 990000, NOW());

-- 3단계: 주문 상세 생성
INSERT INTO order_item (order_id_fk, product_id_fk, quantity, product_price)
VALUES (LAST_INSERT_ID(), 7, 1, 990000);

COMMIT; -- 위에서 예외가 발생하지 않았을 경우, TRANSACTION 에 포함 된 작업을 한번에 수행

SELECT m.*
FROM member m
JOIN `order` o ON o.member_id_fk = m.id
JOIN order_item oi ON oi.order_id_fk = o.id
WHERE oi.product_id_fk = (
	SELECT id FROM `product` WHERE name = '맥북 네오'
);

