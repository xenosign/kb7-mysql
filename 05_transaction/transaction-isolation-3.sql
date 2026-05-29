UPDATE `ticket`
SET stock = 1 WHERE id = 1;

SELECT * FROM `ticket`;

-- LOCK 을 적용한, ### 님의 예매 쿼리
START TRANSACTION;

-- 남은 자리 확인
SELECT * FROM `ticket`
WHERE id = 1
FOR UPDATE;

-- ### 님이 LOCK 을 건 한국 시리즈 티켓을 빠르게 예매
UPDATE `ticket`
SET stock = stock - 1
WHERE id = 1 AND stock >= 1;

-- 확정
COMMIT;

-- 확인
SELECT * FROM `ticket`;