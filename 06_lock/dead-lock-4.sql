-- &&& 님의 상황
START TRANSACTION;

-- 뉴진스 콘서트 티켓을 LOCK 을 걸어서 조회
SELECT * FROM `ticket`
WHERE id = 2
FOR UPDATE;

-- 한국 시리즈 티켓을 LOCK 을 걸어서 조회
SELECT * FROM `ticket`
WHERE id = 1
FOR UPDATE;

COMMIT;