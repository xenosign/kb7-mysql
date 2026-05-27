SELECT * FROM `member`;
SELECT * FROM `order`;
SELECT * FROM `order_item`;
SELECT * FROM `product`;
SELECT * FROM `settlement`;

SELECT * FROM `order`;

SELECT *
FROM `order` o
JOIN `member` m
ON o.member_id_fk = m.id;

SELECT
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
INNER JOIN `member` m
ON o.member_id_fk = m.id;



INSERT
	INTO `member` (name, email) 
    VALUES ('홍길동', 'gildong.hong@example.com');
    
SELECT * FROM `member`;

SELECT
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `member` m
LEFT JOIN `order` o
ON o.member_id_fk = m.id;

SELECT
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
RIGHT JOIN `member` m
ON o.member_id_fk = m.id;

SELECT
	m.name             AS 주문자,
    o.id               AS 주문번호,
    o.status           AS 주문상태,
    p.name             AS 상품명,
    oi.quantity        AS 수량,
    oi.product_price   AS 단가,
    o.total_price      AS 주문총액,
    o.order_date       AS 주문일
FROM `order`      o
JOIN `member`     m   ON o.member_id_fk = m.id
JOIN `order_item` oi  ON oi.order_id_fk = o.id
JOIN `product`    p   ON oi.product_id_fk = p.id
ORDER BY o.id, p.name;

SELECT * FROM `order_item`;

SELECT
	m.name                               AS 주문자,
    o.id                                 AS 주문번호,
    GROUP_CONCAT(p.name)  			     AS 주문상품,
    o.status   					         AS 주문상태,
    o.total_price        				 AS 주문총액,
    SUM(oi.quantity * oi.product_price)  AS 집계총액,
    o.order_date                         AS 주문일
FROM `order`      o
JOIN `member`     m   ON o.member_id_fk = m.id
JOIN `order_item` oi  ON oi.order_id_fk = o.id
JOIN `product`    p   ON oi.product_id_fk = p.id
GROUP BY o.id, m.name
HAVING CHAR_LENGTH(GROUP_CONCAT(p.name)) >= 15
ORDER BY o.id;

SELECT * FROM `order`;
SELECT AVG(total_price) FROM `order`;
SELECT * FROM `order` WHERE total_price > 251433.3333;

SELECT *
FROM `order`
WHERE total_price > (
	SELECT AVG(total_price) FROM `order`
);

SELECT *
FROM `member`
WHERE id IN (
	SELECT member_id_fk
	FROM `order` o
	JOIN `order_item` oi ON o.id = oi.order_id_fk
	WHERE oi.product_id_fk = (
		SELECT id FROM `product` WHERE name = '맥북 네오'
    )
);
	















