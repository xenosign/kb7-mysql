-- 낙관 락을 사용하는 &&& 님의 트랜잭션!
START TRANSACTION;

-- FOR UPDATE 없이 남은 자리 확인
SELECT * FROM `ticket`
WHERE id = 1;

-- &&& 님이 표를 예매할 때 해당 표의 stock 과 version 을 같이 검증해서 예매를 진행
-- version 이 0 이 아니면 예매 실패
UPDATE `ticket`
SET stock = stock - 1, 
version = version + 1
WHERE id = 1 AND version = 0;

-- 확정
COMMIT;

-- 확인
SELECT * FROM `ticket`;