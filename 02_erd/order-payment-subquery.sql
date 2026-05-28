SELECT * FROM `member`;
SELECT * FROM `order`;
SELECT * FROM `order_item`;
SELECT * FROM `product`;

-- product 평균 재고 이상 물건
SELECT AVG(stock) FROM `product`;

SELECT *
FROM `product`
WHERE stock > 69;

SELECT *
FROM `product`
WHERE stock > (
	SELECT AVG(stock) FROM `product`
);

SELECT *
FROM `order`
WHERE total_price > (
    SELECT AVG(total_price) FROM `order`
);

-- 독거미 키보드 산 적 있는 회원

SELECT id FROM `product` WHERE name = '독거미 키보드';

SELECT o.member_id_fk
FROM `order` o
JOIN order_item oi ON o.id = oi.order_id_fk
WHERE oi.product_id_fk = (
	SELECT id FROM `product` WHERE name = '독거미 키보드'
);


SELECT * FROM `order`;


SELECT *
FROM member
WHERE id NOT IN (
    SELECT o.member_id_fk
    FROM `order` o
    JOIN order_item oi ON o.id = oi.order_id_fk
    WHERE oi.product_id_fk = (
		SELECT id FROM `product` WHERE name = '독거미 키보드'
    )
);

SELECT * FROM `member`;


SELECT *
FROM member
WHERE id NOT IN (
    SELECT member_id_fk
    FROM `order`
);

SELECT DISTINCT m.*
FROM member m
LEFT JOIN `order` o
       ON o.member_id_fk = m.id
LEFT JOIN order_item oi
       ON oi.order_id_fk = o.id
       AND oi.product_id_fk = 1
WHERE oi.id IS NULL;

SELECT * FROM member
WHERE id IN (
    SELECT o.member_id_fk
    FROM `order` o
    JOIN order_item oi ON o.id = oi.order_id_fk
    WHERE oi.product_id_fk = 7
);

-- JOIN 변환



SELECT *
FROM member
WHERE id IN (
    SELECT o.member_id_fk
    FROM `order` o
    JOIN order_item oi ON o.id = oi.order_id_fk
    WHERE oi.product_id_fk = (
		SELECT id FROM `product` WHERE name = '독거미 키보드'
    )
);

SELECT DISTINCT m.*
FROM member m
JOIN `order` o ON o.member_id_fk = m.id
JOIN order_item oi ON oi.order_id_fk = o.id
WHERE oi.product_id_fk = (
	SELECT id FROM `product` WHERE name = '독거미 키보드'
);

