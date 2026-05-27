USE `kb7-order-payment`;
SELECT * FROM `member`;

SELECT * FROM `product`;

SELECT * FROM `order`;

SELECT *
FROM `order` o
JOIN `member` m ON o.member_id_fk = m.id;

SELECT 
	m.name,
    o.total_price,
    o.status
FROM `order` o
INNER JOIN `member` m ON o.member_id_fk = m.id;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
INNER JOIN `member` m ON o.member_id_fk = m.id;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `member` m
LEFT JOIN `order` o ON m.id = o.member_id_fk;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `order` o
RIGHT JOIN `member` m ON o.member_id_fk = m.id;

SELECT 
	m.name AS 주문자,
    o.total_price AS 주문총액,
    o.status AS 주문상태
FROM `member` m
RIGHT JOIN `order` o ON o.member_id_fk = m.id;

DELETE from `member` WHERE name = '강채연';

SELECT
    m.name          AS 주문자,
    o.id            AS 주문번호,
    o.status        AS 주문상태,
    p.name          AS 상품명,
    oi.quantity     AS 수량,
    oi.product_price   AS 단가,
    o.total_price   AS 주문총액,
    o.order_date    AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
ORDER BY o.id, p.name;

SELECT
    m.name        AS 주문자,
    o.id          AS 주문번호,
    o.status      AS 주문상태,
    o.order_date  AS 주문일,
    SUM(oi.quantity * oi.product_price) AS 주문총액
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
GROUP BY o.id, m.name, o.status, o.order_date
HAVING SUM(oi.quantity * oi.product_price) >= 200000;

SELECT
    m.name                              AS 주문자,
    o.id                                AS 주문번호,
    o.status                            AS 주문상태,
    GROUP_CONCAT(p.name)                AS 주문상품,
    o.total_price                       AS 주문총액,
    SUM(oi.quantity * oi.product_price)    AS 집계총액,
    o.order_date                        AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
HAVING SUM(oi.quantity * oi.product_price) >= 80000
ORDER BY o.id;

SELECT
    m.name                                  AS 주문자,
    o.id                                    AS 주문번호,
    o.status                                AS 주문상태,
    GROUP_CONCAT(p.name)                    AS 주문상품,
    o.total_price                           AS 주문총액,
    SUM(oi.quantity * oi.product_price)     AS 집계총액,
    o.order_date                            AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
HAVING CHAR_LENGTH(GROUP_CONCAT(p.name)) >= 15
ORDER BY o.id;

SELECT
    m.name                                  AS 주문자,
    o.id                                    AS 주문번호,
    o.status                                AS 주문상태,
    GROUP_CONCAT(p.name)                    AS 주문상품,
    o.total_price                           AS 주문총액,
    SUM(oi.quantity * oi.product_price)     AS 집계총액,
    o.order_date                            AS 주문일
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
HAVING m.name = '이효석'
ORDER BY o.id;

SELECT * FROM `order_item`;

SELECT
    m.name                                  AS 주문자,
    o.id                                    AS 주문번호,
    o.status                                AS 주문상태,
    GROUP_CONCAT(p.name)                    AS 주문상품,
    o.total_price                           AS 주문총액,
    SUM(oi.quantity * oi.product_price)     AS 집계총액,
    o.order_date                            AS 주문일    
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
JOIN product    p  ON oi.product_id_fk = p.id
GROUP BY o.id, m.name, o.status, o.total_price, o.order_date
HAVING CHAR_LENGTH(GROUP_CONCAT(p.name)) >= 15
ORDER BY o.id;

SELECT
    m.name              AS 주문자,    
    SUM(oi.quantity * oi.product_price) AS 총구매금액
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
GROUP BY m.id
HAVING SUM(oi.quantity * oi.product_price) >= 500000;


SELECT
    m.name        AS 주문자,
    o.id          AS 주문번호,
    o.order_date  AS 주문일,
    COUNT(oi.id)  AS 상품종류수
FROM `order` o
JOIN member     m  ON o.member_id_fk   = m.id
JOIN order_item oi ON oi.order_id_fk   = o.id
GROUP BY o.id
HAVING COUNT(oi.id) >= 2;


-- 실습 정답
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

-- 서브 쿼리 시작

-- 평균보다 비싼 주문

SELECT AVG(total_price) FROM `order`;

SELECT *
FROM `order`
WHERE total_price > 251433.3333;



SELECT *
FROM `order`
WHERE total_price > (
    SELECT AVG(total_price) FROM `order`
);

-- 맥북 네오를 주문한 회원
SELECT *
FROM `member`
WHERE id IN (
    SELECT member_id_fk
    FROM `order` o
    JOIN order_item oi ON o.id = oi.order_id_fk
    WHERE oi.product_id_fk = 7
);

SELECT name
FROM `member`
WHERE id IN (
    SELECT member_id_fk
    FROM `order` o
    JOIN order_item oi ON o.id = oi.order_id_fk
    WHERE oi.product_id_fk = (
        SELECT id FROM product WHERE name = '맥북 네오'
    )
);

-- "한 번도 주문 안 한 회원"

SELECT name
FROM `member`
WHERE id NOT IN (
    SELECT DISTINCT member_id_fk FROM `order`
);

-- "회원별 주문 합계에서 100만원 이상인 회원"
SELECT *
FROM (
    SELECT
        member_id_fk,
        SUM(total_price) AS total
    FROM `order`
    GROUP BY member_id_fk
) sub
JOIN `member` m ON sub.member_id_fk = m.id
WHERE sub.total >= 1000000;

-- "정산이 완료된 주문이 있는 회원"
SELECT name
FROM `member` m
WHERE EXISTS (
    SELECT 1
    FROM `order` o
    JOIN settlement s ON o.id = s.order_id_fk
    WHERE o.member_id_fk = m.id
      AND s.status = 'COMPLETED'
);

SELECT *
FROM `member`
WHERE EXISTS (
	SELECT 1
    FROM `order` 
    WHERE total_price >= 1000000    
);

SELECT *
FROM `member` m
WHERE EXISTS (
    SELECT 1
    FROM `order`
    WHERE member_id_fk = m.id    
    AND total_price >= 100000
);

-- "각 회원의 첫 번째 주문"
SELECT *
FROM `order` o
WHERE order_date = (
    SELECT MIN(order_date)
    FROM `order`
    WHERE member_id_fk = o.member_id_fk  -- ← 바깥 참조
);
