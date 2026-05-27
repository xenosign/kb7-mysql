USE `kb7-order-payment`;
SELECT * FROM `member`;

SELECT * FROM `product`;

SELECT * FROM `order`;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
INNER JOIN `member` m ON o.member_id = m.id;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `member` m
LEFT JOIN `order` o ON m.id = o.member_id;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
RIGHT JOIN `member` m ON o.member_id = m.id;

SELECT *	
FROM `member` m
LEFT JOIN `order` o ON m.id = o.member_id;

SELECT *	
FROM `member` m
RIGHT JOIN `order` o ON m.id = o.member_id;

SELECT *
FROM `order` o
RIGHT JOIN `member` m ON o.member_id = m.id;

DELETE from `member` WHERE name = '강채연';

SELECT
    m.name          AS 주문자,
    o.id            AS 주문번호,
    o.status        AS 주문상태,
    p.name          AS 상품명,
    oi.quantity     AS 수량,
    oi.unit_price   AS 단가,
    o.total_price   AS 주문총액,
    o.order_date    AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id   = m.id
JOIN order_item oi ON oi.order_id   = o.id
JOIN product    p  ON oi.product_id = p.id
ORDER BY o.id, p.name;

SELECT
    m.name                          AS 주문자,
    o.id                            AS 주문번호,
    o.status                        AS 주문상태,
    GROUP_CONCAT(p.name)            AS 주문상품,
    o.total_price                   AS 주문총액,
    o.order_date                    AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id    = m.id
JOIN order_item oi ON oi.order_id    = o.id
JOIN product    p  ON oi.product_id  = p.id
GROUP BY o.id
ORDER BY o.id;

SELECT
    m.name                          AS 주문자,
    o.id                            AS 주문번호,
    o.status                        AS 주문상태,
    GROUP_CONCAT(p.name)            AS 주문상품,
    o.total_price                   AS 주문총액,
    o.order_date                    AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id    = m.id
JOIN order_item oi ON oi.order_id    = o.id
JOIN product    p  ON oi.product_id  = p.id
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
ORDER BY o.id;

SELECT
    m.name                              AS 주문자,
    o.id                                AS 주문번호,
    o.status                            AS 주문상태,
    GROUP_CONCAT(p.name)                AS 주문상품,
    o.total_price                       AS 주문총액,
    SUM(oi.quantity * oi.unit_price)    AS 집계총액,
    o.order_date                        AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id   = m.id
JOIN order_item oi ON oi.order_id   = o.id
JOIN product    p  ON oi.product_id = p.id
WHERE m.name = '강태규'
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
ORDER BY o.id;

SELECT
    m.name        AS 주문자,
    o.id          AS 주문번호,
    o.total_price AS 주문총액
FROM `order` o
JOIN member m ON o.member_id = m.id
WHERE o.status = 'COMPLETED'
ORDER BY o.total_price DESC;

SELECT
    m.name   AS 주문자,
    o.id     AS 주문번호,
    o.status AS 주문상태
FROM `order` o
JOIN member     m  ON o.member_id   = m.id
JOIN order_item oi ON oi.order_id   = o.id
JOIN product    p  ON oi.product_id = p.id
WHERE p.name = '맥북 네오';

SELECT
    m.name                  AS 회원명,
    COUNT(o.id)             AS 주문횟수
FROM member m
LEFT JOIN `order` o ON m.id = o.member_id
GROUP BY m.id, m.name
ORDER BY 주문횟수 DESC;



