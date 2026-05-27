SELECT * FROM `product`;

START TRANSACTION;

UPDATE product SET stock = 20 WHERE name = '맥북 네오';

INSERT INTO `order` (member_id_fk, status, total_price, order_date)
VALUES (1, 'PENDING', 22770000, NOW());

SELECT * FROM `order`
WHERE member_id_fk = (
    SELECT id
    FROM `member`
    WHERE name = '이효석'
);

INSERT INTO order_item (order_id_fk, product_id_fk, quantity, product_price) VALUES
(49,  7, 23,  990000);

select * FROM product WHERE name = '맥북 네오';

SELECT * FROM `order_item`;
DELETE from `order_item` WHERE id = 80;
DELETE from `order` WHERE id = 49;



START TRANSACTION;  -- 트랙잭션을 시작

-- 1단계: 재고 확인 후 차감
UPDATE product
SET stock = stock - 50
WHERE id = 7 AND stock >= 50;  -- 맥북 네오

-- 영향받은 행이 0이면 재고 부족 → 애플리케이션에서 감지 후 ROLLBACK

-- 2단계: 주문 생성
INSERT INTO `order` (member_id_fk, status, total_price, order_date)
VALUES (1, 'PENDING', 22770000, NOW());

-- 3단계: 주문 상세 생성
INSERT INTO order_item (order_id_fk, product_id_fk, quantity, product_price)
VALUES (LAST_INSERT_ID(), 7, 50, 990000);

COMMIT; -- 위에서 예외가 발생하지 않았을 경우, TRANSACTION 에 포함 된 작업을 한번에 수행
