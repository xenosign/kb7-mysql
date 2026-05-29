-- 아까와 동일하게 하지만 동시에 &&& 님도 예매를 시작!!
START TRANSACTION;

-- 다시 &&& 님이 남은 자리 확인
SELECT * FROM `ticket`
WHERE id = 1
FOR UPDATE;


-- 손이 느린 &&& 님은 조금 더 늦게 예매를 완료!
UPDATE `ticket`
SET stock = stock - 1
WHERE id = 1 AND stock >= 1;

-- 확정!!
COMMIT;

SELECT * FROM `ticket`;